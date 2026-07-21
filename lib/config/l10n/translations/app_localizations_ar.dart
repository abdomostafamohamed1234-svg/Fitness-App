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
  String get motivation =>
      'حقق أهدافك الرياضية من خلال تمارين مخصصة وإرشادات احترافية. حافظ على حماسك، وتتبع تقدمك، وكن أفضل نسخة من نفسك.';

  @override
  String get motivation_title_1 => 'ثمن التميز هو \nالانضباط';

  @override
  String get motivation_title_2 =>
      'اللياقة البدنية لم تكن ممتعة \nبهذا الشكل من قبل';

  @override
  String get motivation_title_3 => 'لا مزيد من الأعذار، \nابدأ الآن';

  @override
  String get skip => 'تخطي';

  @override
  String get next => 'التالي';

  @override
  String get back => 'السابق';

  @override
  String get do_it => 'افعلها';
}
