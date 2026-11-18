import 'package:flutter/material.dart';

import '../navigation/app_routes.dart';
import '../theme/app_theme.dart';
import '../widgets/app_bottom_nav.dart';
import '../widgets/app_drawer.dart';

class FeatureNoticeScreen extends StatelessWidget {
  const FeatureNoticeScreen({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
  });

  final String title;
  final String description;
  final IconData icon;

  @override
  Widget build(BuildContext context) => Scaffold(
    drawer: const AppDrawer(),
    appBar: AppBar(title: Text(title)),
    body: SafeArea(
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      radius: 32,
                      backgroundColor: AppColors.primarySurface,
                      child: Icon(icon, size: 32, color: AppColors.primary),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleLarge,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(description, textAlign: TextAlign.center),
                    const SizedBox(height: 14),
                    const Text(
                      'આ પ્રોજેક્ટમાં આ સેવા માટે જરૂરી ડેટા પ્રદાતા અથવા API ગોઠવાયેલ નથી. '
                      'અહીં કોઈ નકલી માહિતી બતાવવામાં આવતી નથી.',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 18),
                    FilledButton.icon(
                      onPressed: () =>
                          AppRoutes.replace(context, AppRoutes.homeV1),
                      icon: const Icon(Icons.home_outlined),
                      label: const Text('ડેશબોર્ડ પર પાછા જાઓ'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ),
    bottomNavigationBar: AppBottomNav(
      currentIndex: 0,
      onTap: (index) => AppRoutes.selectBottomNavigation(context, index),
    ),
  );
}
