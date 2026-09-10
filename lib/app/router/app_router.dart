import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:state_app/app/localization/locale_controller.dart';
import 'package:state_app/app/localization/locale_preference.dart';
import 'package:state_app/app/router/app_routes.dart';
import 'package:state_app/features/authentication/domain/auth_state.dart';
import 'package:state_app/features/authentication/presentation/session_controller.dart';
import 'package:state_app/features/home/presentation/home_screen.dart';
import 'package:state_app/features/language/presentation/language_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final refreshNotifier = ValueNotifier<int>(0);

  ref
    ..listen<AuthState>(
      sessionControllerProvider,
      (_, _) => refreshNotifier.value++,
    )
    ..listen<LocalePreference>(localeControllerProvider, (previous, next) {
      if (previous?.hasSelected != next.hasSelected) refreshNotifier.value++;
    });
  final rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: AppRoutes.homePath,
    refreshListenable: refreshNotifier,
    debugLogDiagnostics: kDebugMode,
    routes: [
      GoRoute(
        path: AppRoutes.splashPath,
        name: AppRoutes.splashName,
        builder: (context, state) => const _SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.languagePath,
        name: AppRoutes.languageName,
        builder: (context, state) => const LanguageScreen(),
      ),
      GoRoute(
        path: AppRoutes.homePath,
        name: AppRoutes.homeName,
        builder: (context, state) => const HomeScreen(),
      ),
    ],
    redirect: (context, state) {
      final localePreference = ref.read(localeControllerProvider);
      final location = state.matchedLocation;

      if (!localePreference.hasSelected &&
          location != AppRoutes.languagePath) {
        return AppRoutes.languagePath;
      }

      final authState = ref.read(sessionControllerProvider);

      return switch (authState){
        AuthStateUnknown() => location == AppRoutes.splashPath ? null : AppRoutes.splashPath,
        AuthStateUnauthenticated() => AppRoutes.unauthenticatedPaths.contains(location) ? null : AppRoutes.signInPath,
        AuthStateAuthenticated() => AppRoutes.unauthenticatedPaths.contains(location) ? AppRoutes.homePath : null,
      };
    },
  );
});

class _SplashScreen extends StatelessWidget {
  const _SplashScreen();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
