// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get connectionTimeout => 'Connection timeout';

  @override
  String get requestTimeout => 'Request timeout';

  @override
  String get responseTimeout => 'Response timeout';

  @override
  String get noInternetConnection => 'No internet connection';

  @override
  String get badCertificate => 'Bad certificate';

  @override
  String get requestCancelled => 'Request cancelled';

  @override
  String get serverError => 'Server error';

  @override
  String get transformTimeout => 'Transform timeout';

  @override
  String get unexpectedError => 'Unexpected error';

  @override
  String get validation_required => 'This field is required';

  @override
  String get validation_invalid_name => 'Enter a valid name';

  @override
  String get validation_invalid_email => 'Enter a valid email';

  @override
  String get validation_invalid_password =>
      'Password must be at least 8 characters and include an uppercase letter, a lowercase letter, a number and a special character';

  @override
  String get validation_invalid_confirm_password =>
      'Confirm password must be at least 8 characters and include an uppercase letter, a lowercase letter, a number and a special character';

  @override
  String get validation_password_mismatch => 'Passwords do not match';

  @override
  String get validation_invalid_phone_number => 'Enter a valid phone number';
}
