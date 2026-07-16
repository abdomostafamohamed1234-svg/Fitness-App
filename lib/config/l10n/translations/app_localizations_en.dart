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
}
