import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @unexpectedError.
  ///
  /// In ar, this message translates to:
  /// **'حدث خطأ غير متوقع.'**
  String get unexpectedError;

  /// No description provided for @unknownError.
  ///
  /// In ar, this message translates to:
  /// **'حدث خطأ غير معروف، يرجى التحقق من اتصالك بالإنترنت.'**
  String get unknownError;

  /// No description provided for @connectionTimeout.
  ///
  /// In ar, this message translates to:
  /// **'انتهت مهلة الاتصال. حاول مرة أخرى.'**
  String get connectionTimeout;

  /// No description provided for @badCertificate.
  ///
  /// In ar, this message translates to:
  /// **'شهادة الأمان غير صالحة.'**
  String get badCertificate;

  /// No description provided for @requestCanceled.
  ///
  /// In ar, this message translates to:
  /// **'تم إلغاء الطلب.'**
  String get requestCanceled;

  /// No description provided for @serverError.
  ///
  /// In ar, this message translates to:
  /// **'خطأ في الخادم.'**
  String get serverError;

  /// No description provided for @noNetwork.
  ///
  /// In ar, this message translates to:
  /// **'لا يوجد اتصال. يرجى التحقق من الشبكة.'**
  String get noNetwork;

  /// No description provided for @pickLocation.
  ///
  /// In ar, this message translates to:
  /// **'اختر الموقع'**
  String get pickLocation;

  /// No description provided for @requiredField.
  ///
  /// In ar, this message translates to:
  /// **'هذا الحقل مطلوب'**
  String get requiredField;

  /// No description provided for @requiredPhone.
  ///
  /// In ar, this message translates to:
  /// **'الهاتف مطلوب'**
  String get requiredPhone;

  /// No description provided for @phoneDoseNotMatch.
  ///
  /// In ar, this message translates to:
  /// **'الهاتف غير متطابق'**
  String get phoneDoseNotMatch;

  /// No description provided for @requiredEmail.
  ///
  /// In ar, this message translates to:
  /// **'البريد الالكتروني مطلوب'**
  String get requiredEmail;

  /// No description provided for @wrongEmailValidation.
  ///
  /// In ar, this message translates to:
  /// **'البريد الالكتروني غير صحيح'**
  String get wrongEmailValidation;

  /// No description provided for @requiredPassword.
  ///
  /// In ar, this message translates to:
  /// **'كلمة المرور مطلوبة'**
  String get requiredPassword;

  /// No description provided for @smallPassword.
  ///
  /// In ar, this message translates to:
  /// **'كلمة المرور قصيرة جدا'**
  String get smallPassword;

  /// No description provided for @confirmPassword.
  ///
  /// In ar, this message translates to:
  /// **'تأكيد كلمة المرور'**
  String get confirmPassword;

  /// No description provided for @passwordNotMatch.
  ///
  /// In ar, this message translates to:
  /// **'كلمة المرور غير متطابقة'**
  String get passwordNotMatch;

  /// No description provided for @camera.
  ///
  /// In ar, this message translates to:
  /// **'الكاميرا'**
  String get camera;

  /// No description provided for @gallery.
  ///
  /// In ar, this message translates to:
  /// **'المعرض'**
  String get gallery;

  /// No description provided for @noImageSelected.
  ///
  /// In ar, this message translates to:
  /// **'لم يتم اختيار صورة.'**
  String get noImageSelected;

  /// No description provided for @mediaPickError.
  ///
  /// In ar, this message translates to:
  /// **'حدث خطأ أثناء اختيار الصورة.'**
  String get mediaPickError;

  /// No description provided for @permissionRequired.
  ///
  /// In ar, this message translates to:
  /// **'مطلوب إذن'**
  String get permissionRequired;

  /// No description provided for @enablePermissions.
  ///
  /// In ar, this message translates to:
  /// **'يرجى تمكين الأذونات المطلوبة من إعدادات التطبيق.'**
  String get enablePermissions;

  /// No description provided for @cancel.
  ///
  /// In ar, this message translates to:
  /// **'إلغاء'**
  String get cancel;

  /// No description provided for @settings.
  ///
  /// In ar, this message translates to:
  /// **'الإعدادات'**
  String get settings;

  /// No description provided for @parsingError.
  ///
  /// In ar, this message translates to:
  /// **'حدث خطأ آثناء معالجه البيانات '**
  String get parsingError;

  /// No description provided for @appName.
  ///
  /// In ar, this message translates to:
  /// **'تاسك فلو'**
  String get appName;

  /// No description provided for @login.
  ///
  /// In ar, this message translates to:
  /// **'تسجيل الدخول'**
  String get login;

  /// No description provided for @register.
  ///
  /// In ar, this message translates to:
  /// **'إنشاء حساب'**
  String get register;

  /// No description provided for @email.
  ///
  /// In ar, this message translates to:
  /// **'البريد الإلكتروني'**
  String get email;

  /// No description provided for @password.
  ///
  /// In ar, this message translates to:
  /// **'كلمة المرور'**
  String get password;

  /// No description provided for @fullName.
  ///
  /// In ar, this message translates to:
  /// **'الاسم الكامل'**
  String get fullName;

  /// No description provided for @confirmPasswordLabel.
  ///
  /// In ar, this message translates to:
  /// **'تأكيد كلمة المرور'**
  String get confirmPasswordLabel;

  /// No description provided for @home.
  ///
  /// In ar, this message translates to:
  /// **'الرئيسية'**
  String get home;

  /// No description provided for @addTask.
  ///
  /// In ar, this message translates to:
  /// **'إضافة مهمة'**
  String get addTask;

  /// No description provided for @editTask.
  ///
  /// In ar, this message translates to:
  /// **'تعديل المهمة'**
  String get editTask;

  /// No description provided for @taskTitle.
  ///
  /// In ar, this message translates to:
  /// **'عنوان المهمة'**
  String get taskTitle;

  /// No description provided for @taskDescription.
  ///
  /// In ar, this message translates to:
  /// **'الوصف'**
  String get taskDescription;

  /// No description provided for @dueDate.
  ///
  /// In ar, this message translates to:
  /// **'تاريخ الاستحقاق'**
  String get dueDate;

  /// No description provided for @priority.
  ///
  /// In ar, this message translates to:
  /// **'الأولوية'**
  String get priority;

  /// No description provided for @low.
  ///
  /// In ar, this message translates to:
  /// **'منخفضة'**
  String get low;

  /// No description provided for @medium.
  ///
  /// In ar, this message translates to:
  /// **'متوسطة'**
  String get medium;

  /// No description provided for @high.
  ///
  /// In ar, this message translates to:
  /// **'عالية'**
  String get high;

  /// No description provided for @completed.
  ///
  /// In ar, this message translates to:
  /// **'مكتملة'**
  String get completed;

  /// No description provided for @pending.
  ///
  /// In ar, this message translates to:
  /// **'قيد التنفيذ'**
  String get pending;

  /// No description provided for @completedTasks.
  ///
  /// In ar, this message translates to:
  /// **'المهام المكتملة'**
  String get completedTasks;

  /// No description provided for @profile.
  ///
  /// In ar, this message translates to:
  /// **'الملف الشخصي'**
  String get profile;

  /// No description provided for @darkMode.
  ///
  /// In ar, this message translates to:
  /// **'الوضع الداكن'**
  String get darkMode;

  /// No description provided for @language.
  ///
  /// In ar, this message translates to:
  /// **'اللغة'**
  String get language;

  /// No description provided for @english.
  ///
  /// In ar, this message translates to:
  /// **'الإنجليزية'**
  String get english;

  /// No description provided for @arabic.
  ///
  /// In ar, this message translates to:
  /// **'العربية'**
  String get arabic;

  /// No description provided for @logout.
  ///
  /// In ar, this message translates to:
  /// **'تسجيل الخروج'**
  String get logout;

  /// No description provided for @delete.
  ///
  /// In ar, this message translates to:
  /// **'حذف'**
  String get delete;

  /// No description provided for @edit.
  ///
  /// In ar, this message translates to:
  /// **'تعديل'**
  String get edit;

  /// No description provided for @save.
  ///
  /// In ar, this message translates to:
  /// **'حفظ'**
  String get save;

  /// No description provided for @noTasks.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد مهام. أضف مهمتك الأولى!'**
  String get noTasks;

  /// No description provided for @deleteConfirm.
  ///
  /// In ar, this message translates to:
  /// **'هل أنت متأكد من حذف هذه المهمة؟'**
  String get deleteConfirm;

  /// No description provided for @logoutConfirm.
  ///
  /// In ar, this message translates to:
  /// **'هل تريد تسجيل الخروج؟'**
  String get logoutConfirm;

  /// No description provided for @totalTasks.
  ///
  /// In ar, this message translates to:
  /// **'إجمالي المهام'**
  String get totalTasks;

  /// No description provided for @completedCount.
  ///
  /// In ar, this message translates to:
  /// **'المكتملة'**
  String get completedCount;

  /// No description provided for @pendingCount.
  ///
  /// In ar, this message translates to:
  /// **'المعلقة'**
  String get pendingCount;

  /// No description provided for @forgotPassword.
  ///
  /// In ar, this message translates to:
  /// **'نسيت كلمة المرور؟'**
  String get forgotPassword;

  /// No description provided for @dontHaveAccount.
  ///
  /// In ar, this message translates to:
  /// **'ليس لديك حساب؟'**
  String get dontHaveAccount;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In ar, this message translates to:
  /// **'لديك حساب؟ تسجيل الدخول'**
  String get alreadyHaveAccount;

  /// No description provided for @emailNotFound.
  ///
  /// In ar, this message translates to:
  /// **'البريد الإلكتروني غير مسجل'**
  String get emailNotFound;

  /// No description provided for @wrongPassword.
  ///
  /// In ar, this message translates to:
  /// **'كلمة المرور غير صحيحة'**
  String get wrongPassword;

  /// No description provided for @emailAlreadyInUse.
  ///
  /// In ar, this message translates to:
  /// **'البريد مستخدم بالفعل'**
  String get emailAlreadyInUse;

  /// No description provided for @passwordTooWeak.
  ///
  /// In ar, this message translates to:
  /// **'كلمة المرور ضعيفة جداً'**
  String get passwordTooWeak;

  /// No description provided for @checkInternet.
  ///
  /// In ar, this message translates to:
  /// **'تحقق من اتصال الإنترنت'**
  String get checkInternet;

  /// No description provided for @permissionDenied.
  ///
  /// In ar, this message translates to:
  /// **'ليس لديك صلاحية'**
  String get permissionDenied;

  /// No description provided for @aboutApp.
  ///
  /// In ar, this message translates to:
  /// **'حول التطبيق'**
  String get aboutApp;

  /// No description provided for @version.
  ///
  /// In ar, this message translates to:
  /// **'الإصدار'**
  String get version;

  /// No description provided for @developer.
  ///
  /// In ar, this message translates to:
  /// **'المطور'**
  String get developer;

  /// No description provided for @all.
  ///
  /// In ar, this message translates to:
  /// **'الكل'**
  String get all;

  /// No description provided for @forgotPasswordTitle.
  ///
  /// In ar, this message translates to:
  /// **'نسيت كلمة المرور'**
  String get forgotPasswordTitle;

  /// No description provided for @enterEmailToReset.
  ///
  /// In ar, this message translates to:
  /// **'أدخل بريدك الإلكتروني لاستقبال رابط إعادة تعيين كلمة المرور'**
  String get enterEmailToReset;

  /// No description provided for @sendResetLink.
  ///
  /// In ar, this message translates to:
  /// **'إرسال رابط إعادة التعيين'**
  String get sendResetLink;

  /// No description provided for @resetLinkSent.
  ///
  /// In ar, this message translates to:
  /// **'تم إرسال رابط إعادة تعيين كلمة المرور! تحقق من بريدك.'**
  String get resetLinkSent;

  /// No description provided for @editProfile.
  ///
  /// In ar, this message translates to:
  /// **'تعديل الملف الشخصي'**
  String get editProfile;

  /// No description provided for @profileUpdated.
  ///
  /// In ar, this message translates to:
  /// **'تم تحديث الملف الشخصي بنجاح'**
  String get profileUpdated;

  /// No description provided for @displayName.
  ///
  /// In ar, this message translates to:
  /// **'الإسم'**
  String get displayName;

  /// No description provided for @onboardingTitle1.
  ///
  /// In ar, this message translates to:
  /// **'نظم مهامك بسهولة'**
  String get onboardingTitle1;

  /// No description provided for @onboardingSubtitle1.
  ///
  /// In ar, this message translates to:
  /// **'تطبيق تاسك فلو يساعدك على ترتيب أولوياتك وإنجاز مهامك اليومية بكفاءة عالية.'**
  String get onboardingSubtitle1;

  /// No description provided for @onboardingTitle2.
  ///
  /// In ar, this message translates to:
  /// **'تابع تقدمك'**
  String get onboardingTitle2;

  /// No description provided for @onboardingSubtitle2.
  ///
  /// In ar, this message translates to:
  /// **'راقب مستوى إنجازك من خلال إحصائيات دقيقة لكل المهام المكتملة والمعلقة.'**
  String get onboardingSubtitle2;

  /// No description provided for @onboardingTitle3.
  ///
  /// In ar, this message translates to:
  /// **'لا تفوت أي موعد'**
  String get onboardingTitle3;

  /// No description provided for @onboardingSubtitle3.
  ///
  /// In ar, this message translates to:
  /// **'مع ميزة تاريخ الاستحقاق والتنبيهات، ستكون دائماً على علم بمواعيدك القادمة.'**
  String get onboardingSubtitle3;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
