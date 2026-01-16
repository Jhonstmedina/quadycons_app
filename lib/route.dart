import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:quadycons/data/entities/attendance.dart';
import 'package:quadycons/domain/blocs/auth/auth_bloc.dart';
import 'package:quadycons/domain/blocs/projects/projects_bloc.dart';
import 'package:quadycons/domain/blocs/register_confirmation/register_confirmation_bloc.dart';
import 'package:quadycons/injection_container.dart';
import 'package:quadycons/ui/screens/id_code_scan_screen.dart';
import 'package:quadycons/ui/screens/login_screen.dart';
import 'package:quadycons/ui/screens/permissions_screen.dart';
import 'package:quadycons/ui/screens/register_confirmation_screen.dart';
import 'package:quadycons/ui/screens/scanner_screen.dart';
import 'package:quadycons/ui/screens/splash_screen.dart';

class GoRouterRefreshStream extends ChangeNotifier {
  late final StreamSubscription<dynamic> _subscription;

  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
      (dynamic _) => notifyListeners(),
    );
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

final GoRouter router = GoRouter(
  initialLocation: '/splash',
  refreshListenable: GoRouterRefreshStream(sl<AuthBloc>().stream),
  redirect: (context, state) {
    if(state.matchedLocation == '/splash') {
      final authBloc = sl<AuthBloc>();
      final authState = authBloc.state;
      if (authState is OnLogin) {
        return '/login';
      } else if (authState is OnAuthenticated) {
        sl<ProjectsBloc>().add(LoadProjects());
        return '/permissions';
      }
    }    
    return null;
  },
  routes: [
    GoRoute(
      path: '/splash',
      name: 'splash',
      builder: (context, state) => SplashScreen()
    ),
    GoRoute(
      path: '/id-code-scan',
      name: 'id-code-scan',
      builder: (context, state) => const IdCodeScanScreen(),
    ),
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => LoginScreen(),
    ),
    GoRoute(
      path: '/permissions',
      name: 'permissions',
      builder: (context, state) => const PermissionsScreen(),
    ),
    GoRoute(
      path: '/register-confirmation',
      name: 'register-confirmation',
      builder: (context, state) => BlocProvider<RegisterConfirmationBloc>(
        create: (_) => sl<RegisterConfirmationBloc>()
          ..add(
            InitRegistrationConfirmation(
              registration: state.extra as Attendance
            )
          ),
        child: RegisterConfirmationScreen(),
      )
    ),
    GoRoute(
      path: '/scanner',
      name: 'scanner',
      builder: (context, state) => ScannerScreen(),
    ),
  ],
);
