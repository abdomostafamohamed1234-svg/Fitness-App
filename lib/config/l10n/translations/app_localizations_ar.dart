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
  String get profile => 'الملف الشخصي';

  @override
  String get editProfile => 'تعديل الملف الشخصي';

  @override
  String get changePassword => 'تغيير كلمة المرور';

  @override
  String get selectLanguage => 'اختر اللغة';

  @override
  String get english => 'الإنجليزية';

  @override
  String get arabic => 'العربية';

  @override
  String get security => 'الأمان';

  @override
  String get privacyPolicy => 'سياسة الخصوصية';

  @override
  String get help => 'المساعدة';

  @override
  String get logout => 'تسجيل الخروج';

  @override
  String get areYouSureToCloseApplication => 'هل أنت متأكد من إغلاق التطبيق؟';

  @override
  String get no => 'لا';

  @override
  String get yes => 'نعم';
}
