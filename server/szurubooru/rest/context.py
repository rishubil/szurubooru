from typing import Any, Union, List, Dict, Optional, cast
from szurubooru import model, errors
from szurubooru.func import net, file_uploads


MISSING = object()
Request = Dict[str, Any]
Response = Optional[Dict[str, Any]]


class Context:
    def __init__(
            self,
            method: str,
            url: str,
            headers: Dict[str, str] = None,
            params: Request = None,
            files: Dict[str, bytes] = None) -> None:
        self.method = method
        self.url = url
        self._headers = headers or {}
        self._params = params or {}
        self._files = files or {}

        self.user = model.User()
        self.user.name = None
        self.user.rank = 'anonymous'

        self.session = None  # type: Any

    def has_header(self, name: str) -> bool:
        return name in self._headers

    def get_header(self, name: str) -> str:
        return self._headers.get(name, '')

    def has_file(self, name: str, allow_tokens: bool = True) -> bool:
        return (
            name in self._files or
            name + 'Url' in self._params or
            (allow_tokens and name + 'Token' in self._params))

    def get_file(
            self,
            name: str,
            default: Union[object, bytes] = MISSING,
            allow_tokens: bool = True) -> bytes:
        if name in self._files and self._files[name]:
            return self._files[name]

        if name + 'Url' in self._params:
            return net.download(self._params[name + 'Url'])

        if allow_tokens and name + 'Token' in self._params:
            ret = file_uploads.get(self._params[name + 'Token'])
            if ret:
                return ret
            elif default is not MISSING:
                raise errors.MissingOrExpiredRequiredFileError(
                    '필수 파일 %r 이(가) 누락되었거나 만료되었습니다.' % name)

        if default is not MISSING:
            return cast(bytes, default)
        raise errors.MissingRequiredFileError(
            '필수 파일 %r 이(가) 누락되었습니다.' % name)

    def has_param(self, name: str) -> bool:
        return name in self._params

    def get_param_as_list(
            self,
            name: str,
            default: Union[object, List[Any]] = MISSING) -> List[Any]:
        if name not in self._params:
            if default is not MISSING:
                return cast(List[Any], default)
            raise errors.MissingRequiredParameterError(
                '필수 파라미터 %r 이(가) 누락되었습니다.' % name)
        value = self._params[name]
        if type(value) is str:
            if ',' in value:
                return value.split(',')
            return [value]
        if type(value) is list:
            return value
        raise errors.InvalidParameterError(
            '파라미터 %r 은(는) 리스트여야 합니다.' % name)

    def get_param_as_int_list(
            self,
            name: str,
            default: Union[object, List[int]] = MISSING) -> List[int]:
        ret = self.get_param_as_list(name, default)
        for item in ret:
            if type(item) is not int:
                raise errors.InvalidParameterError(
                    '파라미터 %r 은(는) 정수 리스트여야 합니다.' % name)
        return ret

    def get_param_as_string_list(
            self,
            name: str,
            default: Union[object, List[str]] = MISSING) -> List[str]:
        ret = self.get_param_as_list(name, default)
        for item in ret:
            if type(item) is not str:
                raise errors.InvalidParameterError(
                    '파라미터 %r 은(는) 문자열 리스트여야 합니다.' % name)
        return ret

    def get_param_as_string(
            self,
            name: str,
            default: Union[object, str] = MISSING) -> str:
        if name not in self._params:
            if default is not MISSING:
                return cast(str, default)
            raise errors.MissingRequiredParameterError(
                '필수 파라미터 %r 이(가) 누락되었습니다.' % name)
        value = self._params[name]
        try:
            if value is None:
                return ''
            if type(value) is list:
                return ','.join(value)
            if type(value) is int or type(value) is float:
                return str(value)
            if type(value) is str:
                return value
        except TypeError:
            pass
        raise errors.InvalidParameterError(
            '파라미터 %r 은(는) 문자열이여야 합니다.' % name)

    def get_param_as_int(
            self,
            name: str,
            default: Union[object, int] = MISSING,
            min: Optional[int] = None,
            max: Optional[int] = None) -> int:
        if name not in self._params:
            if default is not MISSING:
                return cast(int, default)
            raise errors.MissingRequiredParameterError(
                '필수 파라미터 %r 이(가) 누락되었습니다.' % name)
        value = self._params[name]
        try:
            value = int(value)
            if min is not None and value < min:
                raise errors.InvalidParameterError(
                    '파라미터 %r 은(는) 최소 %r 이어야 합니다.' % (name, min))
            if max is not None and value > max:
                raise errors.InvalidParameterError(
                    '파라미터 %r 은(는) %r 초과할 수 없습니다.' % (name, max))
            return value
        except (ValueError, TypeError):
            pass
        raise errors.InvalidParameterError(
            '파라미터 %r 은(는) 정수여야 합니다.' % name)

    def get_param_as_bool(
            self,
            name: str,
            default: Union[object, bool] = MISSING) -> bool:
        if name not in self._params:
            if default is not MISSING:
                return cast(bool, default)
            raise errors.MissingRequiredParameterError(
                '필수 파라미터 %r 이(가) 누락되었습니다.' % name)
        value = self._params[name]
        try:
            value = str(value).lower()
        except TypeError:
            pass
        if value in ['1', 'y', 'yes', 'yeah', 'yep', 'yup', 't', 'true']:
            return True
        if value in ['0', 'n', 'no', 'nope', 'f', 'false']:
            return False
        raise errors.InvalidParameterError(
            '파라미터 %r 은(는) 불리언 값이어야 합니다.' % name)
