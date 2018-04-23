from datetime import datetime
from typing import Any, Optional, Union, List, Dict, Callable
import re
import sqlalchemy as sa
from szurubooru import config, db, model, errors, rest
from szurubooru.func import auth, util, serialization, files, images


class UserNotFoundError(errors.NotFoundError):
    pass


class UserAlreadyExistsError(errors.ValidationError):
    pass


class InvalidUserNameError(errors.ValidationError):
    pass


class InvalidEmailError(errors.ValidationError):
    pass


class InvalidPasswordError(errors.ValidationError):
    pass


class InvalidRankError(errors.ValidationError):
    pass


class InvalidAvatarError(errors.ValidationError):
    pass


def get_avatar_path(user_name: str) -> str:
    return 'avatars/' + user_name.lower() + '.png'


def get_avatar_url(user: model.User) -> str:
    assert user
    if user.avatar_style == user.AVATAR_GRAVATAR:
        assert user.email or user.name
        return 'https://gravatar.com/avatar/%s?d=retro&s=%d' % (
            util.get_md5((user.email or user.name).lower()),
            config.config['thumbnails']['avatar_width'])
    assert user.name
    return '%s/avatars/%s.png' % (
        config.config['data_url'].rstrip('/'), user.name.lower())


def get_email(
        user: model.User,
        auth_user: model.User,
        force_show_email: bool) -> Union[bool, str]:
    assert user
    assert auth_user
    if not force_show_email \
            and auth_user.user_id != user.user_id \
            and not auth.has_privilege(auth_user, 'users:edit:any:email'):
        return False
    return user.email


def get_liked_post_count(
        user: model.User, auth_user: model.User) -> Union[bool, int]:
    assert user
    assert auth_user
    if auth_user.user_id != user.user_id:
        return False
    return user.liked_post_count


def get_disliked_post_count(
        user: model.User, auth_user: model.User) -> Union[bool, int]:
    assert user
    assert auth_user
    if auth_user.user_id != user.user_id:
        return False
    return user.disliked_post_count


class UserSerializer(serialization.BaseSerializer):
    def __init__(
            self,
            user: model.User,
            auth_user: model.User,
            force_show_email: bool = False) -> None:
        self.user = user
        self.auth_user = auth_user
        self.force_show_email = force_show_email

    def _serializers(self) -> Dict[str, Callable[[], Any]]:
        return {
            'name': self.serialize_name,
            'creationTime': self.serialize_creation_time,
            'lastLoginTime': self.serialize_last_login_time,
            'version': self.serialize_version,
            'rank': self.serialize_rank,
            'avatarStyle': self.serialize_avatar_style,
            'avatarUrl': self.serialize_avatar_url,
            'commentCount': self.serialize_comment_count,
            'uploadedPostCount': self.serialize_uploaded_post_count,
            'favoritePostCount': self.serialize_favorite_post_count,
            'likedPostCount': self.serialize_liked_post_count,
            'dislikedPostCount': self.serialize_disliked_post_count,
            'email': self.serialize_email,
        }

    def serialize_name(self) -> Any:
        return self.user.name

    def serialize_creation_time(self) -> Any:
        return self.user.creation_time

    def serialize_last_login_time(self) -> Any:
        return self.user.last_login_time

    def serialize_version(self) -> Any:
        return self.user.version

    def serialize_rank(self) -> Any:
        return self.user.rank

    def serialize_avatar_style(self) -> Any:
        return self.user.avatar_style

    def serialize_avatar_url(self) -> Any:
        return get_avatar_url(self.user)

    def serialize_comment_count(self) -> Any:
        return self.user.comment_count

    def serialize_uploaded_post_count(self) -> Any:
        return self.user.post_count

    def serialize_favorite_post_count(self) -> Any:
        return self.user.favorite_post_count

    def serialize_liked_post_count(self) -> Any:
        return get_liked_post_count(self.user, self.auth_user)

    def serialize_disliked_post_count(self) -> Any:
        return get_disliked_post_count(self.user, self.auth_user)

    def serialize_email(self) -> Any:
        return get_email(self.user, self.auth_user, self.force_show_email)


def serialize_user(
        user: Optional[model.User],
        auth_user: model.User,
        options: List[str] = [],
        force_show_email: bool = False) -> Optional[rest.Response]:
    if not user:
        return None
    return UserSerializer(user, auth_user, force_show_email).serialize(options)


def serialize_micro_user(
        user: Optional[model.User],
        auth_user: model.User) -> Optional[rest.Response]:
    return serialize_user(
        user, auth_user=auth_user, options=['name', 'avatarUrl'])


def get_user_count() -> int:
    return db.session.query(model.User).count()


def try_get_user_by_name(name: str) -> Optional[model.User]:
    return (
        db.session
        .query(model.User)
        .filter(sa.func.lower(model.User.name) == sa.func.lower(name))
        .one_or_none())


def get_user_by_name(name: str) -> model.User:
    user = try_get_user_by_name(name)
    if not user:
        raise UserNotFoundError('사용자 %r 을(를) 찾을 수 없습니다.' % name)
    return user


def try_get_user_by_name_or_email(name_or_email: str) -> Optional[model.User]:
    return (
        db.session
        .query(model.User)
        .filter(
            (sa.func.lower(model.User.name) == sa.func.lower(name_or_email)) |
            (sa.func.lower(model.User.email) == sa.func.lower(name_or_email)))
        .one_or_none())


def get_user_by_name_or_email(name_or_email: str) -> model.User:
    user = try_get_user_by_name_or_email(name_or_email)
    if not user:
        raise UserNotFoundError('사용자 %r 을(를) 찾을 수 없습니다.' % name_or_email)
    return user


def create_user(name: str, password: str, email: str) -> model.User:
    user = model.User()
    update_user_name(user, name)
    update_user_password(user, password)
    update_user_email(user, email)
    if get_user_count() > 0:
        user.rank = util.flip(auth.RANK_MAP)[config.config['default_rank']]
    else:
        user.rank = model.User.RANK_ADMINISTRATOR
    user.creation_time = datetime.utcnow()
    user.avatar_style = model.User.AVATAR_GRAVATAR
    return user


def update_user_name(user: model.User, name: str) -> None:
    assert user
    if not name:
        raise InvalidUserNameError('닉네임(ID)은 빈 값일 수 없습니다.')
    if util.value_exceeds_column_size(name, model.User.name):
        raise InvalidUserNameError('닉네임(ID)이 너무 깁니다.')
    name = name.strip()
    name_regex = config.config['user_name_regex']
    if not re.match(name_regex, name):
        raise InvalidUserNameError(
            '닉네임(ID) %r 은(는) 다음의 정규식을 만족해야 합니다: %r' % (name, name_regex))
    other_user = try_get_user_by_name(name)
    if other_user and other_user.user_id != user.user_id:
        raise UserAlreadyExistsError('사용자 %r 은(는) 이미 존재합니다.' % name)
    if user.name and files.has(get_avatar_path(user.name)):
        files.move(get_avatar_path(user.name), get_avatar_path(name))
    user.name = name


def update_user_password(user: model.User, password: str) -> None:
    assert user
    if not password:
        raise InvalidPasswordError('비밀번호는 빈 값일 수 없습니다.')
    password_regex = config.config['password_regex']
    if not re.match(password_regex, password):
        raise InvalidPasswordError(
            '비밀번호는 다음의 정규식을 만족해야 합니다: %r' % password_regex)
    user.password_salt = auth.create_password()
    password_hash, revision = auth.get_password_hash(
        user.password_salt, password)
    user.password_hash = password_hash
    user.password_revision = revision


def update_user_email(user: model.User, email: str) -> None:
    assert user
    email = email.strip()
    if util.value_exceeds_column_size(email, model.User.email):
        raise InvalidEmailError('이메일이 너무 깁니다.')
    if not util.is_valid_email(email):
        raise InvalidEmailError('잘못된 이메일입니다.')
    user.email = email or None


def update_user_rank(
        user: model.User, rank: str, auth_user: model.User) -> None:
    assert user
    if not rank:
        raise InvalidRankError('등급은 빈 값일 수 없습니다.')
    rank = util.flip(auth.RANK_MAP).get(rank.strip(), None)
    all_ranks = list(auth.RANK_MAP.values())
    if not rank:
        raise InvalidRankError(
            '등급은 다음중 하나여야 합니다: %r' % all_ranks)
    if rank in (model.User.RANK_ANONYMOUS, model.User.RANK_NOBODY):
        raise InvalidRankError('등급 %r 은(는) 사용할 수 없습니다.' % auth.RANK_MAP[rank])
    if all_ranks.index(auth_user.rank) \
            < all_ranks.index(rank) and get_user_count() > 0:
        raise errors.AuthError('당신보다 높은 등급을 지정할 수 없습니다.')
    user.rank = rank


def update_user_avatar(
        user: model.User,
        avatar_style: str,
        avatar_content: Optional[bytes] = None) -> None:
    assert user
    if avatar_style == 'gravatar':
        user.avatar_style = user.AVATAR_GRAVATAR
    elif avatar_style == 'manual':
        user.avatar_style = user.AVATAR_MANUAL
        avatar_path = 'avatars/' + user.name.lower() + '.png'
        if not avatar_content:
            if files.has(avatar_path):
                return
            raise InvalidAvatarError('아바타 컨텐츠가 누락되었습니다.')
        image = images.Image(avatar_content)
        image.resize_fill(
            int(config.config['thumbnails']['avatar_width']),
            int(config.config['thumbnails']['avatar_height']))
        files.save(avatar_path, image.to_png())
    else:
        raise InvalidAvatarError(
            '아바타 스타일 %r 은(는) 잘못된 값입니다. 올바른 스타일 값: %r.' % (
                avatar_style, ['gravatar', 'manual']))


def bump_user_login_time(user: model.User) -> None:
    assert user
    user.last_login_time = datetime.utcnow()


def reset_user_password(user: model.User) -> str:
    assert user
    password = auth.create_password()
    user.password_salt = auth.create_password()
    password_hash, revision = auth.get_password_hash(
        user.password_salt, password)
    user.password_hash = password_hash
    user.password_revision = revision
    return password
