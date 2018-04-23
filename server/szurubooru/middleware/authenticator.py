import base64
from typing import Optional, Tuple
from szurubooru import model, errors, rest
from szurubooru.func import auth, users, user_tokens
from szurubooru.rest.errors import HttpBadRequest


def _authenticate_basic_auth(username: str, password: str) -> model.User:
    ''' Try to authenticate user. Throw AuthError for invalid users. '''
    user = users.get_user_by_name(username)
    if not auth.is_valid_password(user, password):
        raise errors.AuthError('잘못된 비밀번호입니다.')
    return user


def _authenticate_token(
        username: str, token: str) -> Tuple[model.User, model.UserToken]:
    ''' Try to authenticate user. Throw AuthError for invalid users. '''
    user = users.get_user_by_name(username)
    user_token = user_tokens.get_by_user_and_token(user, token)
    if not auth.is_valid_token(user_token):
        raise errors.AuthError('잘못된 토큰입니다.')
    return user, user_token


def _get_user(ctx: rest.Context, bump_login: bool) -> Optional[model.User]:
    if not ctx.has_header('Authorization'):
        return None

    auth_token = None

    try:
        auth_type, credentials = ctx.get_header('Authorization').split(' ', 1)
        if auth_type.lower() == 'basic':
            username, password = base64.decodebytes(
                credentials.encode('ascii')).decode('utf8').split(':', 1)
            auth_user = _authenticate_basic_auth(username, password)
        elif auth_type.lower() == 'token':
            username, token = base64.decodebytes(
                credentials.encode('ascii')).decode('utf8').split(':', 1)
            auth_user, auth_token = _authenticate_token(username, token)
        else:
            raise HttpBadRequest(
                'ValidationError',
                '기본 및 토큰 HTTP 인증만을 지원합니다.')
    except ValueError as err:
        msg = (
            '인증 헤더 값이 적절한 형식이 아닙니다. '
            '전달된 헤더 {0}. 오류: {1}')
        raise HttpBadRequest(
            'ValidationError',
            msg.format(ctx.get_header('Authorization'), str(err)))

    if bump_login and auth_user.user_id:
        users.bump_user_login_time(auth_user)
        if auth_token is not None:
            user_tokens.bump_usage_time(auth_token)
        ctx.session.commit()

    return auth_user


def process_request(ctx: rest.Context) -> None:
    ''' Bind the user to request. Update last login time if needed. '''
    bump_login = ctx.get_param_as_bool('bump-login', default=False)
    auth_user = _get_user(ctx, bump_login)
    if auth_user:
        ctx.user = auth_user


@rest.middleware.pre_hook
def process_request_hook(ctx: rest.Context) -> None:
    process_request(ctx)
