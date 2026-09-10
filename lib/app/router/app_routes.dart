abstract final class AppRoutes {
  static const String splashPath = '/splash';
  static const String splashName = 'splash';

  static const String languagePath = '/language';
  static const String languageName = 'language';

  static const String signInPath = '/sign-in';
  static const String signInName = 'sign-in';

  static const String registerPath = '/register';
  static const String registerName = 'register';

  static const String homePath = '/';
  static const String homeName = 'home';

  static const String favoritesPath = '/favorites';
  static const String favoritesName = 'favorites';

  static const String profilePath = '/profile';
  static const String profileName = 'profile';

  static const String propertyDetailPath = '/home/property/:id';
  static const String propertyDetailName = 'property-detail';

  static const Set<String> unauthenticatedPaths = <String>{
    languagePath,
    signInPath,
    registerPath,
  };
}