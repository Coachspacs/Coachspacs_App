import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/auth/guest_session.dart';
import 'core/di/injection_container.dart';
import 'core/routing/app_router.dart';
import 'core/routing/routes.dart';
import 'core/theming/app_theme.dart';
import 'features/auth/logic/auth_routing.dart';
import 'features/auth/logic/cubit/auth_cubit.dart';
import 'features/auth/logic/cubit/auth_state.dart';
import 'l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setupLocator();

  unawaited(getIt<AuthCubit>().restoreSession());

  runApp(const CoachSpaceApp());
}

class CoachSpaceApp extends StatelessWidget {
  const CoachSpaceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<AuthCubit>(),
      child: MaterialApp(
        title: 'Coach Space',
        navigatorKey: _navigatorKey,
        theme: AppTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        onGenerateRoute: AppRouter().generateRoute,

        // Keep the authentication flow as the app entry point.
        initialRoute: AppRoutes.splash,
        // App language
        locale: const Locale('en'),

        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],

        supportedLocales: AppLocalizations.supportedLocales,

        builder: (context, child) {
          return BlocListener<AuthCubit, AuthState>(
            listener: _onAuthStateChanged,
            child: child ?? const SizedBox.shrink(),
          );
        },
      ),
    );
  }
}

/// Owned by the app root so the auth gate can navigate from above the
/// `MaterialApp` (the `BlocListener` sits above the `Navigator`).
final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

void _onAuthStateChanged(BuildContext context, AuthState state) {
  if (state is AuthAuthenticated || state is AuthPendingApproval) {
    // A real (non-guest) session clears the static guest flag so protected
    // navigation no longer shows the login prompt.
    GuestSession.login();
  }

  final String? target = switch (state) {
    AuthAuthenticated(:final session) => routeForSession(session),
    AuthPendingApproval(:final session) => routeForSession(session),
    // No persisted session: stay in the onboarding/auth flow instead of
    // dumping the user into the home screen.
    AuthUnauthenticated() => AppRoutes.login,
    _ => null,
  };

  if (target == null) return;

  final navigator = _navigatorKey.currentState;

  if (navigator == null) return;

  // Avoid re-pushing the same route when the state re-emits.
  final currentContext = _navigatorKey.currentContext;

  if (currentContext != null) {
    final currentName = ModalRoute.of(currentContext)?.settings.name;

    // Never bounce the user out of the onboarding/auth flow while they are
    // already inside it (e.g. a fresh install showing the onboarding pages).
    if (state is AuthUnauthenticated && _isAuthRoute(currentName)) {
      return;
    }

    if (currentName == target) return;
  }

  navigator.pushNamedAndRemoveUntil(target, (route) => false);
}

/// Routes that belong to the onboarding/auth flow. While the user is here an
/// `AuthUnauthenticated` state (e.g. from a brand-new install) must not yank
/// them into another screen.
bool _isAuthRoute(String? name) => switch (name) {
  AppRoutes.onboarding ||
  AppRoutes.splash ||
  AppRoutes.login ||
  AppRoutes.signup ||
  AppRoutes.forgotPassword ||
  AppRoutes.resetPassword ||
  AppRoutes.emailVerification ||
  AppRoutes.emailVerificationSuccess ||
  AppRoutes.emailAlreadyVerified ||
  AppRoutes.pendingApproval => true,
  _ => false,
};
