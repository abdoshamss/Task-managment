// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get unexpectedError => 'حدث خطأ غير متوقع.';

  @override
  String get unknownError =>
      'حدث خطأ غير معروف، يرجى التحقق من اتصالك بالإنترنت.';

  @override
  String get connectionTimeout => 'انتهت مهلة الاتصال. حاول مرة أخرى.';

  @override
  String get badCertificate => 'شهادة الأمان غير صالحة.';

  @override
  String get requestCanceled => 'تم إلغاء الطلب.';

  @override
  String get serverError => 'خطأ في الخادم.';

  @override
  String get noNetwork => 'لا يوجد اتصال. يرجى التحقق من الشبكة.';

  @override
  String get pickLocation => 'اختر الموقع';

  @override
  String get requiredField => 'هذا الحقل مطلوب';

  @override
  String get requiredPhone => 'الهاتف مطلوب';

  @override
  String get phoneDoseNotMatch => 'الهاتف غير متطابق';

  @override
  String get requiredEmail => 'البريد الالكتروني مطلوب';

  @override
  String get wrongEmailValidation => 'البريد الالكتروني غير صحيح';

  @override
  String get requiredPassword => 'كلمة المرور مطلوبة';

  @override
  String get smallPassword => 'كلمة المرور قصيرة جدا';

  @override
  String get confirmPassword => 'تأكيد كلمة المرور';

  @override
  String get passwordNotMatch => 'كلمة المرور غير متطابقة';

  @override
  String get camera => 'الكاميرا';

  @override
  String get gallery => 'المعرض';

  @override
  String get noImageSelected => 'لم يتم اختيار صورة.';

  @override
  String get mediaPickError => 'حدث خطأ أثناء اختيار الصورة.';

  @override
  String get permissionRequired => 'مطلوب إذن';

  @override
  String get enablePermissions =>
      'يرجى تمكين الأذونات المطلوبة من إعدادات التطبيق.';

  @override
  String get cancel => 'إلغاء';

  @override
  String get settings => 'الإعدادات';

  @override
  String get parsingError => 'حدث خطأ آثناء معالجه البيانات ';

  @override
  String get appName => 'تاسك فلو';

  @override
  String get login => 'تسجيل الدخول';

  @override
  String get register => 'إنشاء حساب';

  @override
  String get email => 'البريد الإلكتروني';

  @override
  String get password => 'كلمة المرور';

  @override
  String get fullName => 'الاسم الكامل';

  @override
  String get confirmPasswordLabel => 'تأكيد كلمة المرور';

  @override
  String get home => 'الرئيسية';

  @override
  String get addTask => 'إضافة مهمة';

  @override
  String get editTask => 'تعديل المهمة';

  @override
  String get taskTitle => 'عنوان المهمة';

  @override
  String get taskDescription => 'الوصف';

  @override
  String get dueDate => 'تاريخ الاستحقاق';

  @override
  String get priority => 'الأولوية';

  @override
  String get low => 'منخفضة';

  @override
  String get medium => 'متوسطة';

  @override
  String get high => 'عالية';

  @override
  String get completed => 'مكتملة';

  @override
  String get pending => 'قيد التنفيذ';

  @override
  String get completedTasks => 'المهام المكتملة';

  @override
  String get profile => 'الملف الشخصي';

  @override
  String get darkMode => 'الوضع الداكن';

  @override
  String get language => 'اللغة';

  @override
  String get english => 'الإنجليزية';

  @override
  String get arabic => 'العربية';

  @override
  String get logout => 'تسجيل الخروج';

  @override
  String get delete => 'حذف';

  @override
  String get edit => 'تعديل';

  @override
  String get save => 'حفظ';

  @override
  String get noTasks => 'لا توجد مهام. أضف مهمتك الأولى!';

  @override
  String get deleteConfirm => 'هل أنت متأكد من حذف هذه المهمة؟';

  @override
  String get logoutConfirm => 'هل تريد تسجيل الخروج؟';

  @override
  String get totalTasks => 'إجمالي المهام';

  @override
  String get completedCount => 'المكتملة';

  @override
  String get pendingCount => 'المعلقة';

  @override
  String get forgotPassword => 'نسيت كلمة المرور؟';

  @override
  String get dontHaveAccount => 'ليس لديك حساب؟ سجل';

  @override
  String get alreadyHaveAccount => 'لديك حساب؟ تسجيل الدخول';

  @override
  String get emailNotFound => 'البريد الإلكتروني غير مسجل';

  @override
  String get wrongPassword => 'كلمة المرور غير صحيحة';

  @override
  String get emailAlreadyInUse => 'البريد مستخدم بالفعل';

  @override
  String get passwordTooWeak => 'كلمة المرور ضعيفة جداً';

  @override
  String get checkInternet => 'تحقق من اتصال الإنترنت';

  @override
  String get permissionDenied => 'ليس لديك صلاحية';

  @override
  String get aboutApp => 'حول التطبيق';

  @override
  String get version => 'الإصدار';

  @override
  String get developer => 'المطور';

  @override
  String get all => 'الكل';

  @override
  String get forgotPasswordTitle => 'نسيت كلمة المرور';

  @override
  String get enterEmailToReset =>
      'أدخل بريدك الإلكتروني لاستقبال رابط إعادة تعيين كلمة المرور';

  @override
  String get sendResetLink => 'إرسال رابط إعادة التعيين';

  @override
  String get resetLinkSent =>
      'تم إرسال رابط إعادة تعيين كلمة المرور! تحقق من بريدك.';

  @override
  String get editProfile => 'تعديل الملف الشخصي';

  @override
  String get profileUpdated => 'تم تحديث الملف الشخصي بنجاح';

  @override
  String get displayName => 'اسم العرض';

  @override
  String get onboardingTitle1 => 'نظم مهامك بسهولة';

  @override
  String get onboardingSubtitle1 =>
      'تطبيق تاسك فلو يساعدك على ترتيب أولوياتك وإنجاز مهامك اليومية بكفاءة عالية.';

  @override
  String get onboardingTitle2 => 'تابع تقدمك';

  @override
  String get onboardingSubtitle2 =>
      'راقب مستوى إنجازك من خلال إحصائيات دقيقة لكل المهام المكتملة والمعلقة.';

  @override
  String get onboardingTitle3 => 'لا تفوت أي موعد';

  @override
  String get onboardingSubtitle3 =>
      'مع ميزة تاريخ الاستحقاق والتنبيهات، ستكون دائماً على علم بمواعيدك القادمة.';
}
