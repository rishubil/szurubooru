from szurubooru import errors, rest, model


def verify_version(
        entity: model.Base,
        context: rest.Context,
        field_name: str = 'version') -> None:
    actual_version = context.get_param_as_int(field_name)
    expected_version = entity.version
    if actual_version != expected_version:
        raise errors.IntegrityError(
            '다른 누군가 이미 수정하고 있습니다. ' +
            '다시 시도해 보세요.')


def bump_version(entity: model.Base) -> None:
    entity.version = entity.version + 1
