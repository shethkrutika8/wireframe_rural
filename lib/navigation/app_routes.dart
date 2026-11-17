import 'package:flutter/material.dart';

class AppRoutes {
  AppRoutes._();

  static const splash = '/';
  static const login = '/login';
  static const register = '/register';
  static const forgotPassword = '/forgot_password';
  static const profile = '/profile';
  static const settings = '/settings';
  static const farms = '/farms';
  static const crops = '/crops';
  static const irrigation = '/irrigation';
  static const summary = '/summary';
  static const homeV1 = '/home_v1';
  static const homeV2 = '/home_v2';
  static const homeV3 = '/home_v3';
  static const homeV4 = '/home_v4';
  static const homeV5 = '/home_v5';

  static const protectedRoutes = {
    profile,
    settings,
    farms,
    crops,
    irrigation,
    summary,
    homeV1,
    homeV2,
    homeV3,
    homeV4,
    homeV5,
  };

  static const bottomNavigationRoutes = [
    homeV1,
    crops,
    irrigation,
    farms,
    profile,
  ];

  static void selectBottomNavigation(BuildContext context, int index) {
    if (index < 0 || index >= bottomNavigationRoutes.length) return;
    Navigator.pushReplacementNamed(context, bottomNavigationRoutes[index]);
  }

  static void open(BuildContext context, String route) {
    Navigator.pushNamed(context, route);
  }

  static void replace(BuildContext context, String route) {
    Navigator.pushReplacementNamed(context, route);
  }

  static void replaceAll(BuildContext context, String route) {
    Navigator.pushNamedAndRemoveUntil(context, route, (_) => false);
  }
}
