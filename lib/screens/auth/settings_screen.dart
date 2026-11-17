import 'package:flutter/material.dart';

import '../../navigation/app_routes.dart';
import '../../services/app_store.dart';
import '../../widgets/app_bottom_nav.dart';
import '../../widgets/app_drawer.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  Future<void> _logout(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('લૉગઆઉટ કરવું છે?'),
        content: const Text('તમારા ઉપકરણ પર સાચવેલો લૉગિન સેશન બંધ થશે.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('રદ કરો'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('લૉગઆઉટ'),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    await AppStore.instance.logout();
    if (context.mounted) AppRoutes.replaceAll(context, AppRoutes.login);
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
        animation: AppStore.instance,
        builder: (context, _) => Scaffold(
          drawer: const AppDrawer(activeRoute: AppRoutes.settings),
          appBar: AppBar(title: const Text('સેટિંગ્સ')),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              SwitchListTile(
                value: AppStore.instance.notificationsEnabled,
                title: const Text('સૂચનાઓ'),
                subtitle: const Text('આ ઉપકરણ પર સૂચનાઓ ચાલુ રાખો'),
                secondary: const Icon(Icons.notifications_outlined),
                onChanged: (value) async {
                  try {
                    await AppStore.instance.saveNotificationsEnabled(value);
                  } on AppStoreException catch (error) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(error.message)),
                      );
                    }
                  }
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.person_outline),
                title: const Text('પ્રોફાઇલ'),
                subtitle: const Text('તમારી વ્યક્તિગત માહિતી બદલો'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => AppRoutes.open(context, AppRoutes.profile),
              ),
              const SizedBox(height: 20),
              OutlinedButton.icon(
                onPressed: () => _logout(context),
                icon: const Icon(Icons.logout),
                label: const Text('લૉગઆઉટ'),
              ),
              const SizedBox(height: 16),
              const Text(
                'આ પ્રોટોટાઇપનું ખાતું અને માહિતી આ ઉપકરણના સ્થાનિક સ્ટોરેજમાં જ રહે છે. '
                'સુરક્ષિત બહુ-વપરાશકર્તા ખાતા માટે સર્વર કનેક્શન જરૂરી છે.',
                textAlign: TextAlign.center,
              ),
            ],
          ),
          bottomNavigationBar: AppBottomNav(
            currentIndex: 4,
            onTap: (index) => AppRoutes.selectBottomNavigation(context, index),
          ),
        ),
      );
}
