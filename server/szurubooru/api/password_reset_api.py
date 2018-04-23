from typing import Dict
from szurubooru import config, errors, rest
from szurubooru.func import auth, mailer, users, versions
from hashlib import md5
from email.header import Header
from email.utils import formataddr


MAIL_SUBJECT = '[{name}] 비밀번호 재설정'
MAIL_BODY = (
    '{name}에서 당신의 계정 비밀번호 재설정이 요청되었습니다.\n'
    '비밀번호 재설정을 위해 다음 링크를 클릭하세요. {url}\n'
    '만약 비밀번호 재설정을 요청하지 않으셨다면, 이 이메일을 무시해주세요.')


@rest.routes.get('/password-reset/(?P<user_name>[^/]+)/?')
def start_password_reset(
        _ctx: rest.Context, params: Dict[str, str]) -> rest.Response:
    user_name = params['user_name']
    user = users.get_user_by_name_or_email(user_name)
    if not user.email:
        raise errors.ValidationError(
            '사용자 %r님은 이메일 주소를 등록하지 않았습니다. 비밀번호를 재설정할 수 없습니다.' % (
                user_name))
    token = auth.generate_authentication_token(user)
    url = '%s/password-reset/%s:%s' % (
        config.config['base_url'].rstrip('/'), user.name, token)
    mailer.send_mail(
        formataddr((str(Header(config.config['smtp']['user_display'], 'utf-8')), config.config['smtp']['user'])),
        user.email,
        MAIL_SUBJECT.format(name=config.config['name']),
        MAIL_BODY.format(name=config.config['name'], url=url))
    return {}


def _hash(token: str) -> str:
    return md5(token.encode('utf-8')).hexdigest()


@rest.routes.post('/password-reset/(?P<user_name>[^/]+)/?')
def finish_password_reset(
        ctx: rest.Context, params: Dict[str, str]) -> rest.Response:
    user_name = params['user_name']
    user = users.get_user_by_name_or_email(user_name)
    good_token = auth.generate_authentication_token(user)
    token = ctx.get_param_as_string('token')
    if _hash(token) != _hash(good_token):
        raise errors.ValidationError('Invalid password reset token.')
    new_password = users.reset_user_password(user)
    versions.bump_version(user)
    ctx.session.commit()
    return {'password': new_password}
