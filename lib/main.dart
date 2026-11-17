import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'navigation/app_routes.dart';
import 'services/app_store.dart';
import 'screens/splash_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/register_screen.dart';
import 'screens/auth/forgot_password_screen.dart';
import 'screens/auth/profile_screen.dart';
import 'screens/auth/settings_screen.dart';
import 'screens/home/home_screen_v1.dart';
import 'screens/home/home_screen_v2.dart';
import 'screens/home/home_screen_v3.dart';
import 'screens/home/home_screen_v4.dart';
import 'screens/home/home_screen_v5.dart';
import 'screens/summary/summary_screen.dart';
import 'screens/summary/farm_management_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppStore.instance.initialize();
  runApp(const AgriConnectApp());
}

class AgriConnectApp extends StatelessWidget {
  const AgriConnectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AgriConnect - ખેડૂતનો સાથી',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: AppRoutes.splash,
      onGenerateRoute: _generateRoute,
      onUnknownRoute: (_) => MaterialPageRoute<void>(
        builder: (_) => const SplashScreen(),
        settings: const RouteSettings(name: AppRoutes.splash),
      ),
    );
  }

  Route<void> _generateRoute(RouteSettings settings) {
    final requestedRoute = settings.name ?? AppRoutes.splash;
    final route = AppRoutes.protectedRoutes.contains(requestedRoute) &&
            AppStore.instance.currentAccount == null
        ? AppRoutes.login
        : requestedRoute;

    final Widget page = switch (route) {
      AppRoutes.splash => const SplashScreen(),
      AppRoutes.login => const LoginScreen(),
      AppRoutes.register => const RegisterScreen(),
      AppRoutes.forgotPassword => const ForgotPasswordScreen(),
      AppRoutes.profile => const ProfileScreen(),
      AppRoutes.settings => const SettingsScreen(),
      AppRoutes.farms => const FarmManagementScreen(section: FarmSection.farms),
      AppRoutes.crops => const FarmManagementScreen(section: FarmSection.crops),
      AppRoutes.irrigation =>
        const FarmManagementScreen(section: FarmSection.irrigation),
      AppRoutes.summary => const SummaryScreen(),
      AppRoutes.homeV1 => const HomeScreenV1(),
      AppRoutes.homeV2 => const HomeScreenV2(),
      AppRoutes.homeV3 => const HomeScreenV3(),
      AppRoutes.homeV4 => const HomeScreenV4(),
      AppRoutes.homeV5 => const HomeScreenV5(),
      _ => const SplashScreen(),
    };

    return MaterialPageRoute<void>(
      builder: (_) => page,
      settings: RouteSettings(name: route),
    );
  }
}
