'use strict';

const api = require('../api.js');
const config = require('../config.js');
const router = require('../router.js');
const uri = require('../util/uri.js');
const misc = require('../util/misc.js');
const progress = require('../util/progress.js');
const topNavigation = require('../models/top_navigation.js');
const Post = require('../models/post.js');
const Tag = require('../models/tag.js');
const PostUploadView = require('../views/post_upload_view.js');
const EmptyView = require('../views/empty_view.js');

const genericErrorMessage =
    '확인이 필요한 짤이 있습니다. ' +
    '확인이 완료되면 "업로드 계속"을 클릭해주세요.';

class PostUploadController {
    constructor() {
        this._lastCancellablePromise = null;

        if (!api.hasPrivilege('posts:create')) {
            this._view = new EmptyView();
            this._view.showError('짤을 업로드할 수 있는 권한이 없습니다.');
            return;
        }

        topNavigation.activate('upload');
        topNavigation.setTitle('Upload');
        this._view = new PostUploadView({
            canUploadAnonymously: api.hasPrivilege('posts:create:anonymous'),
            canViewPosts: api.hasPrivilege('posts:view'),
            enableSafety: config.enableSafety,
        });
        this._view.addEventListener('change', e => this._evtChange(e));
        this._view.addEventListener('submit', e => this._evtSubmit(e));
        this._view.addEventListener('cancel', e => this._evtCancel(e));
    }

    _evtChange(e) {
        if (e.detail.uploadables.length) {
            misc.enableExitConfirmation();
        } else {
            misc.disableExitConfirmation();
            this._view.clearMessages();
        }
    }

    _evtCancel(e) {
        if (this._lastCancellablePromise) {
            this._lastCancellablePromise.abort();
        }
    }

    _evtSubmit(e) {
        this._view.disableForm();
        this._view.clearMessages();

        e.detail.uploadables.reduce(
            (promise, uploadable) =>
                promise.then(() => this._uploadSinglePost(
                    uploadable, e.detail.skipDuplicates)),
            Promise.resolve())
                .then(() => {
                    this._view.clearMessages();
                    misc.disableExitConfirmation();
                    const ctx = router.show(uri.formatClientLink('posts'));
                    ctx.controller.showSuccess('짤 업로드됨.');
                }, error => {
                    if (error.uploadable) {
                        if (error.similarPosts) {
                            error.uploadable.lookalikes = error.similarPosts;
                            this._view.updateUploadable(error.uploadable);
                            this._view.showInfo(genericErrorMessage);
                            this._view.showInfo(
                                error.message, error.uploadable);
                        } else {
                            this._view.showError(genericErrorMessage);
                            this._view.showError(
                                error.message, error.uploadable);
                        }
                    } else {
                        this._view.showError(error.message);
                    }
                    this._view.enableForm();
                });
    }

    _uploadSinglePost(uploadable, skipDuplicates) {
        progress.start();
        let reverseSearchPromise = Promise.resolve();
        if (!uploadable.lookalikesConfirmed) {
            reverseSearchPromise =
                Post.reverseSearch(uploadable.url || uploadable.file);
        }
        this._lastCancellablePromise = reverseSearchPromise;

        return reverseSearchPromise.then(searchResult => {
            if (searchResult) {
                // notify about exact duplicate
                if (searchResult.exactPost) {
                    if (skipDuplicates) {
                        this._view.removeUploadable(uploadable);
                        return Promise.resolve();
                    } else {
                        let error = new Error('이미 업로드된 짤 ' +
                            `(@${searchResult.exactPost.id})`);
                        error.uploadable = uploadable;
                        return Promise.reject(error);
                    }
                }

                // notify about similar posts
                if (searchResult.similarPosts.length) {
                    let error = new Error(
                        `비슷한 ${searchResult.similarPosts.length}개의 짤이 있습니다.` +
                        '\n업로드를 계속하거나 취소할 수 있습니다.');
                    error.uploadable = uploadable;
                    error.similarPosts = searchResult.similarPosts;
                    return Promise.reject(error);
                }
            }

            // no duplicates, proceed with saving
            let post = this._uploadableToPost(uploadable);
            let savePromise = post.save(uploadable.anonymous)
                .then(() => {
                    this._view.removeUploadable(uploadable);
                    return Promise.resolve();
                });
            this._lastCancellablePromise = savePromise;
            return savePromise;
        }).then(result => {
            progress.done();
            return Promise.resolve(result);
        }, error => {
            error.uploadable = uploadable;
            progress.done();
            return Promise.reject(error);
        });
    }

    _uploadableToPost(uploadable) {
        let post = new Post();
        post.safety = uploadable.safety;
        post.flags = uploadable.flags;
        for (let tagName of uploadable.tags) {
            const tag = new Tag();
            tag.names = [tagName];
            post.tags.add(tag);
        }
        post.relations = uploadable.relations;
        post.newContent = uploadable.url || uploadable.file;
        return post;
    }
}

module.exports = router => {
    router.enter(['upload'], (ctx, next) => {
        ctx.controller = new PostUploadController();
    });
};
