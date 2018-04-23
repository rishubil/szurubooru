import os
import time
import logging
import threading
from typing import Callable, Any, Type

import coloredlogs
import sqlalchemy as sa
import sqlalchemy.orm.exc
from szurubooru import config, db, errors, rest
from szurubooru.func import posts, file_uploads
# pylint: disable=unused-import
from szurubooru import api, middleware


def _map_error(
        ex: Exception,
        target_class: Type[rest.errors.BaseHttpError],
        title: str) -> rest.errors.BaseHttpError:
    return target_class(
        name=type(ex).__name__,
        title=title,
        description=str(ex),
        extra_fields=getattr(ex, 'extra_fields', {}))


def _on_auth_error(ex: Exception) -> None:
    raise _map_error(ex, rest.errors.HttpForbidden, '인증 오류')


def _on_validation_error(ex: Exception) -> None:
    raise _map_error(ex, rest.errors.HttpBadRequest, '유효성 오류')


def _on_search_error(ex: Exception) -> None:
    raise _map_error(ex, rest.errors.HttpBadRequest, '검색 오류')


def _on_integrity_error(ex: Exception) -> None:
    raise _map_error(ex, rest.errors.HttpConflict, '무결성 위반')


def _on_not_found_error(ex: Exception) -> None:
    raise _map_error(ex, rest.errors.HttpNotFound, '찾을 수 없음')


def _on_processing_error(ex: Exception) -> None:
    raise _map_error(ex, rest.errors.HttpBadRequest, '처리 오류')


def _on_third_party_error(ex: Exception) -> None:
    raise _map_error(
        ex,
        rest.errors.HttpInternalServerError,
        '서버 설정 오류')


def _on_stale_data_error(_ex: Exception) -> None:
    raise rest.errors.HttpConflict(
        name='IntegrityError',
        title='무결성 위반',
        description=(
            '다른 누군가 이미 수정하고 있습니다. '
            '다시 시도해 보세요.'))


def validate_config() -> None:
    '''
    Check whether config doesn't contain errors that might prove
    lethal at runtime.
    '''
    from szurubooru.func.auth import RANK_MAP
    for privilege, rank in config.config['privileges'].items():
        if rank not in RANK_MAP.values():
            raise errors.ConfigError(
                '권한 %r 의 등급 %r 이(가) 누락되었습니다' % (privilege, rank))
    if config.config['default_rank'] not in RANK_MAP.values():
        raise errors.ConfigError(
            '기본 등급 %r 은(는) 알려진 등급 리스트에 없습니다' % (
                config.config['default_rank']))

    for key in ['base_url', 'api_url', 'data_url', 'data_dir']:
        if not config.config[key]:
            raise errors.ConfigError(
                '서비스가 설정되지 않았습니다: %r 이(가) 누락됨' % key)

    if not os.path.isabs(config.config['data_dir']):
        raise errors.ConfigError(
            'data_dir 는 절대 경로여야 합니다')

    if not config.config['database']:
        raise errors.ConfigError('데이터베이스가 설정되지 않았습니다')


def purge_old_uploads() -> None:
    while True:
        try:
            file_uploads.purge_old_uploads()
        except Exception as ex:
            logging.exception(ex)
        time.sleep(60 * 5)


def create_app() -> Callable[[Any, Any], Any]:
    ''' Create a WSGI compatible App object. '''
    validate_config()
    coloredlogs.install(fmt='[%(asctime)-15s] %(name)s %(message)s')
    logging.getLogger('elasticsearch').disabled = True
    if config.config['debug']:
        logging.getLogger('szurubooru').setLevel(logging.INFO)
    if config.config['show_sql']:
        logging.getLogger('sqlalchemy.engine').setLevel(logging.INFO)

    purge_thread = threading.Thread(target=purge_old_uploads)
    purge_thread.daemon = True
    purge_thread.start()

    try:
        posts.populate_reverse_search()
        db.session.commit()
    except errors.ThirdPartyError:
        pass

    rest.errors.handle(errors.AuthError, _on_auth_error)
    rest.errors.handle(errors.ValidationError, _on_validation_error)
    rest.errors.handle(errors.SearchError, _on_search_error)
    rest.errors.handle(errors.IntegrityError, _on_integrity_error)
    rest.errors.handle(errors.NotFoundError, _on_not_found_error)
    rest.errors.handle(errors.ProcessingError, _on_processing_error)
    rest.errors.handle(errors.ThirdPartyError, _on_third_party_error)
    rest.errors.handle(sa.orm.exc.StaleDataError, _on_stale_data_error)

    return rest.application


app = create_app()  # pylint: disable=invalid-name
