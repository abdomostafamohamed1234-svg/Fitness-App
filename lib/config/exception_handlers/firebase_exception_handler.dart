import 'package:firebase_core/firebase_core.dart';
import 'package:flowery/config/di/di_config.dart';
import 'package:flowery/config/exception_handlers/app_exception.dart';
import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/config/helpers/shared_preferences/shared_preferences_helper.dart';
import 'package:flutter/material.dart';

class FirebaseExceptionHandler {
  FirebaseExceptionHandler._();

  static Future<AppException> handle(FirebaseException e) async {
    final locale = Locale(
      getIt<SharedPreferencesHelper>().getString('locale') ?? 'en',
    );

    final l10n = await AppLocalizations.delegate.load(locale);

    switch (e.code) {
      // Firestore
      case 'permission-denied':
        return AppException(l10n.permissionDenied);

      case 'not-found':
        return AppException(l10n.notFound);

      case 'already-exists':
        return AppException(l10n.alreadyExists);

      case 'resource-exhausted':
        return AppException(l10n.resourceExhausted);

      case 'failed-precondition':
        return AppException(l10n.failedPrecondition);

      case 'aborted':
        return AppException(l10n.operationAborted);

      case 'unavailable':
        return AppException(l10n.serviceUnavailable);

      case 'deadline-exceeded':
        return AppException(l10n.requestTimeout);

      // Firebase Auth
      case 'invalid-email':
        return AppException(l10n.invalidEmail);

      case 'user-disabled':
        return AppException(l10n.userDisabled);

      case 'user-not-found':
        return AppException(l10n.userNotFound);

      case 'wrong-password':
      case 'invalid-credential':
        return AppException(l10n.invalidCredentials);

      case 'email-already-in-use':
        return AppException(l10n.emailAlreadyInUse);

      case 'weak-password':
        return AppException(l10n.weakPassword);

      case 'too-many-requests':
        return AppException(l10n.tooManyRequests);

      // Generic
      default:
        return AppException(
          e.message ?? l10n.unexpectedError,
        );
    }
  }
}