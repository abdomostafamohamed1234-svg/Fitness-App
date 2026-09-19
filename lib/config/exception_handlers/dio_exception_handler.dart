import 'package:dio/dio.dart';
import 'package:flowery/config/di/di_config.dart';
import 'package:flowery/config/exception_handlers/app_exception.dart';
import 'package:flowery/config/helpers/shared_preferences/shared_preferences_helper.dart';
import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flutter/material.dart';

class DioExceptionHandler {
  DioExceptionHandler._();

  static Future<AppException> handle(DioException e) async {
    final locale = Locale(
      getIt<SharedPreferencesHelper>().getString('locale') ?? 'en',
    );

    final l10n = await AppLocalizations.delegate.load(locale);

    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return AppException(l10n.connectionTimeout);

      case DioExceptionType.sendTimeout:
        return AppException(l10n.requestTimeout);

      case DioExceptionType.receiveTimeout:
        return AppException(l10n.responseTimeout);

      case DioExceptionType.connectionError:
        return AppException(l10n.noInternetConnection);

      case DioExceptionType.badCertificate:
        return AppException(l10n.badCertificate);

      case DioExceptionType.cancel:
        return AppException(l10n.requestCancelled);

      case DioExceptionType.badResponse:
        return AppException('${l10n.serverError} (${e.response?.statusCode})');

      case DioExceptionType.transformTimeout:
        return AppException(l10n.transformTimeout);

      case DioExceptionType.unknown:
        return AppException(e.message ?? l10n.unexpectedError);
    }
  }
}
