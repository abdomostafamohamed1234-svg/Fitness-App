// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get connectionTimeout => 'انتهت مهلة الاتصال';

  @override
  String get requestTimeout => 'انتهت مهلة الطلب';

  @override
  String get responseTimeout => 'انتهت مهلة الاستجابة';

  @override
  String get noInternetConnection => 'لا يوجد اتصال بالإنترنت';

  @override
  String get badCertificate => 'شهادة غير صالحة';

  @override
  String get requestCancelled => 'تم إلغاء الطلب';

  @override
  String get serverError => 'خطأ في الخادم';

  @override
  String get transformTimeout => 'انتهت مهلة المعالجة';

  @override
  String get unexpectedError => 'حدث خطأ غير متوقع';

  @override
  String get follow_the_plan =>
      'اتبع الخطة أدناه واختر مستوى الصعوبة الذي يناسبك للبدء';

  @override
  String get exercise => 'التمرين';

  @override
  String get no_exercises_found => 'لم يتم العثور على تمارين لهذا المستوى';
}
