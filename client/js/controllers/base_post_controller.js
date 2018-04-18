'use strict';

const api = require('../api.js');
const topNavigation = require('../models/top_navigation.js');
const EmptyView = require('../views/empty_view.js');

class BasePostController {
    constructor(ctx) {
        if (!api.hasPrivilege('posts:view')) {
            this._view = new EmptyView();
            this._view.showError('짤을 볼 수 있는 권한이 없습니다.');
            return;
        }

        topNavigation.activate('posts');
        topNavigation.setTitle('짤 #' + ctx.parameters.id.toString());
    }
}

module.exports = BasePostController;
