import 'package:flowery/config/l10n/translations/app_localizations.dart';

import 'validators.dart';

extension ValidationErrorMessage on ValidationError {
  String message(AppLocalizations l10n) {
    switch (this) {
      case ValidationError.required:
        return l10n.validation_required;
      case ValidationError.invalidName:
        return l10n.validation_invalid_name;
      case ValidationError.invalidEmail:
        return l10n.validation_invalid_email;
      case ValidationError.invalidPassword:
        return l10n.validation_invalid_password;
      case ValidationError.invalidConfirmPassword:
        return l10n.validation_invalid_confirm_password;
      case ValidationError.passwordMismatch:
        return l10n.validation_password_mismatch;
      case ValidationError.invalidPhoneNumber:
        return l10n.validation_invalid_phone_number;
    }
  }
}
