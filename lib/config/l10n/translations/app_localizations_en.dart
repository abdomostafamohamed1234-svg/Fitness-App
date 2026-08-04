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
  String get profile => 'Profile';

  @override
  String get editProfile => 'Edit Profile';

  @override
  String get changePassword => 'Change Password';

  @override
  String get selectLanguage => 'Select Language';

  @override
  String get english => 'English';

  @override
  String get arabic => 'Arabic';

  @override
  String get security => 'Security';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get help => 'Help';

  @override
  String get logout => 'Logout';

  @override
  String get areYouSureToCloseApplication =>
      'Are You Sure To Close Application?';

  @override
  String get no => 'NO';

  @override
  String get yes => 'Yes';
}
