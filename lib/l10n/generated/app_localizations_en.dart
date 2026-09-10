// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'ZarVilla';

  @override
  String get appTagline => 'Design • Decor • Renovate';

  @override
  String get welcomeTitle => 'Welcome to ZarVilla';

  @override
  String get welcomeSubtitle => 'Find, design, and renovate your dream home.';

  @override
  String get chooseLanguage => 'Choose your language';

  @override
  String get continueButton => 'Continue';

  @override
  String get browseListings => 'Browse Listings';

  @override
  String get getStarted => 'Get Started';

  @override
  String get search => 'Search';

  @override
  String get errorNetwork =>
      'No internet connection. Please check your network and try again.';

  @override
  String get errorTimeout => 'The request timed out. Please try again.';

  @override
  String get errorUnknown => 'Something went wrong. Please try again.';
}
