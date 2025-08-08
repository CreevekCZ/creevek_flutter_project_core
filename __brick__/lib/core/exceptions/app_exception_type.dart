import 'package:{{packageName}}/l10n/app_localizations.dart';

enum AppExceptionType {
  unknownError,
  noInternetConnection,
  connectionTimeout,
  unauthorized,
  forbidden,
  notFound,
  conflict,
  validationError,
  tooManyRequests,
  serverError,
  requestCancelled,
  badCertificate;

  String getLocalizedMessage(AppLocalizations l10n) => switch (this) {
    AppExceptionType.unknownError => l10n.core__lblUnknownError,
    AppExceptionType.noInternetConnection => l10n.core__lblNoInternetConnection,
    AppExceptionType.connectionTimeout => l10n.core__lblConnectionTimeout,
    AppExceptionType.unauthorized => l10n.core__lblUnauthorized,
    AppExceptionType.forbidden => l10n.core__lblForbidden,
    AppExceptionType.notFound => l10n.core__lblNotFound,
    AppExceptionType.conflict => l10n.core__lblConflict,
    AppExceptionType.validationError => l10n.core__lblValidationError,
    AppExceptionType.tooManyRequests => l10n.core__lblTooManyRequests,
    AppExceptionType.serverError => l10n.core__lblServerError,
    AppExceptionType.requestCancelled => l10n.core__lblRequestCancelled,
    AppExceptionType.badCertificate => l10n.core__lblBadCertificate,
  };
}
