import 'package:flutter/widgets.dart';

import 'package:coach_space/core/helpers/context_extensions.dart';
import 'package:coach_space/core/networking/network_exceptions.dart';

/// Maps a typed [FailureKind] to a localized, user-displayable message.
///
/// Validation/business rejections keep the server message: DRF localizes them
/// through the `Accept-Language` header sent by the API client.
String localizedFailureMessage(
  BuildContext context,
  FailureKind kind,
  String serverMessage,
) {
  return switch (kind) {
    FailureKind.validation ||
    FailureKind.businessRejection => serverMessage.isNotEmpty
        ? serverMessage
        : context.l10n.commonError,
    FailureKind.offline => context.l10n.errorOffline,
    FailureKind.notFound => context.l10n.errorNotFound,
    FailureKind.forbidden => context.l10n.errorForbidden,
    FailureKind.conflict => context.l10n.errorConflict,
    FailureKind.rateLimited => context.l10n.errorRateLimited,
    FailureKind.unauthorized => context.l10n.errorSessionExpired,
    FailureKind.serverError => context.l10n.errorServer,
    FailureKind.unknown => context.l10n.errorUnknown,
  };
}
