// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Persian (`fa`).
class AppLocalizationsFa extends AppLocalizations {
  AppLocalizationsFa([String locale = 'fa']) : super(locale);

  @override
  String get appName => 'زرویلا';

  @override
  String get appTagline => 'طراحی • دیزاین داخلی • بازسازی';

  @override
  String get welcomeTitle => 'به زرویلا خوش آمدید';

  @override
  String get welcomeSubtitle =>
      'خانه رویایی خود را پیدا کنید، طراحی کنید و بازسازی کنید.';

  @override
  String get chooseLanguage => 'زبان خود را انتخاب کنید';

  @override
  String get continueButton => 'ادامه';

  @override
  String get browseListings => 'فهرست‌ها را مرور کنید';

  @override
  String get getStarted => 'شروع کنید';

  @override
  String get search => 'جستجو';

  @override
  String get errorNetwork =>
      'اتصال انترنت وجود ندارد. لطفاً شبکه خود را بررسی کرده و دوباره کوشش کنید.';

  @override
  String get errorTimeout => 'درخواست به پایان رسید. لطفاً دوباره کوشش کنید.';

  @override
  String get errorUnknown => 'مشکلی رخ داد. لطفاً دوباره کوشش کنید.';
}
