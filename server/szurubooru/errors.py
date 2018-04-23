from typing import Dict


class BaseError(RuntimeError):
    def __init__(
            self,
            message: str = '알 수 없는 오류',
            extra_fields: Dict[str, str] = None) -> None:
        super().__init__(message)
        self.extra_fields = extra_fields


class ConfigError(BaseError):
    pass


class AuthError(BaseError):
    pass


class IntegrityError(BaseError):
    pass


class ValidationError(BaseError):
    pass


class SearchError(BaseError):
    pass


class NotFoundError(BaseError):
    pass


class ProcessingError(BaseError):
    pass


class MissingRequiredFileError(ValidationError):
    pass


class MissingOrExpiredRequiredFileError(MissingRequiredFileError):
    pass


class MissingRequiredParameterError(ValidationError):
    pass


class InvalidParameterError(ValidationError):
    pass


class ThirdPartyError(BaseError):
    pass
