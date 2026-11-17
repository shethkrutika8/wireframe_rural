import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'screens/splash_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/register_screen.dart';
import 'screens/auth/forgot_password_screen.dart';
import 'screens/home/home_screen_v1.dart';
import 'screens/home/home_screen_v2.dart';
import 'screens/home/home_screen_v3.dart';
import 'screens/home/home_screen_v4.dart';
import 'screens/home/home_screen_v5.dart';
import 'screens/summary/summary_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/forgot_password': (context) => const ForgotPasswordScreen(),
        '/home_v1': (context) => const HomeScreenV1(),
        '/home_v2': (context) => const HomeScreenV2(),
        '/home_v3': (context) => const HomeScreenV3(),
        '/home_v4': (context) => const HomeScreenV4(),
        '/home_v5': (context) => const HomeScreenV5(),
        '/summary': (context) => const SummaryScreen(),
      },
    );
  }
}
