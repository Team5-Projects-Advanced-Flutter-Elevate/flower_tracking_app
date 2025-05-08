// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get connectionTimeout => 'انتهت مهلة الاتصال بالخادم ⌛';

  @override
  String get sendTimeout => 'انتهت مهلة إرسال البيانات إلى الخادم ⏱';

  @override
  String get receiveTimeout => 'انتهت مهلة استلام البيانات من الخادم ⏰';

  @override
  String get cancel => 'تم إلغاء الطلب إلى الخادم ✖';

  @override
  String get connectionError => 'لا يوجد اتصال بالإنترنت 😑';

  @override
  String get unknown => 'حدث خطأ ما 🤔';

  @override
  String get badCertificate => 'شهادة الخادم غير صالحة 📑';

  @override
  String get somethingWentWrong => 'حدث خطأ ما 🤔';

  @override
  String get pleaseEnterName => 'يرجى إدخال الاسم.';

  @override
  String get pleaseEnterUserName => 'يرجى إدخال اسم المستخدم.';

  @override
  String get userNameLength => 'يجب أن يتراوح اسم المستخدم بين 3 و16 حرفًا.';

  @override
  String get userNameRules => 'يمكن أن يحتوي اسم المستخدم على أحرف وأرقام وشرطات سفلية فقط.';

  @override
  String get pleaseEnterFirstName => 'يرجى إدخال الاسم الأول.';

  @override
  String get pleaseEnterLastName => 'يرجى إدخال اسم العائلة.';

  @override
  String get namesRules => 'يجب أن تحتوي الأسماء على أحرف فقط.';

  @override
  String get pleaseEnterEmail => 'يرجى إدخال البريد الإلكتروني.';

  @override
  String get pleaseEnterValidEmail => 'يرجى إدخال بريد إلكتروني صالح.';

  @override
  String get pleaseEnterPhoneNumber => 'يرجى إدخال رقم الهاتف.';

  @override
  String get phoneNumberRules => 'يجب أن يبدأ الرقم بـ 010 أو 011 أو 012 أو 015 متبوعًا بـ 8 أرقام.';

  @override
  String get pleaseEnterPassword => 'يرجى إدخال كلمة المرور.';

  @override
  String get passwordLength => 'يجب أن تكون كلمة المرور 8 أحرف على الأقل.';

  @override
  String get uppercaseRulePassword => 'يجب أن تحتوي على حرف كبير واحد على الأقل.';

  @override
  String get lowercaseRulePassword => 'يجب أن تحتوي على حرف صغير واحد على الأقل.';

  @override
  String get digitRulePassword => 'يجب أن تحتوي على رقم واحد على الأقل.';

  @override
  String get specialCharactersRulePassword => 'يجب أن تحتوي على رمز خاص واحد على الأقل (مثل #?!@\$%^&*-).';

  @override
  String get pleaseConfirmPassword => 'يرجى تأكيد كلمة المرور.';

  @override
  String get namesLengthRule => 'يجب أن لا يقل الاسم عن ثلاثة أحرف.';

  @override
  String get noMatch => 'غير متطابق!';

  @override
  String get pleaseEnterAddress => 'يرجى إدخال العنوان';

  @override
  String get pleaseEnterValidAddress => 'يرجى إدخال عنوان صالح';

  @override
  String get removedImage => 'تمت إزالة الصورة';
}
