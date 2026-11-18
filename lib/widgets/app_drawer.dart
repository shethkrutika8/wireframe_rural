import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../navigation/app_routes.dart';
import '../services/app_store.dart';
import '../theme/app_theme.dart';

class AppDrawer extends StatelessWidget {
  final String activeRoute;

  const AppDrawer({super.key, this.activeRoute = ''});

  @override
  Widget build(BuildContext context) => Drawer(
    backgroundColor: Colors.white,
    child: SafeArea(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          _header(),
          _sectionHeader('ખેતી વ્યવસ્થાપન'),
          _item(
            context,
            'ડેશબોર્ડ',
            Icons.dashboard_outlined,
            AppRoutes.homeV1,
          ),
          _item(context, 'મારા ખેતરો', Icons.yard_outlined, AppRoutes.farms),
          _item(context, 'પાક', Icons.eco_outlined, AppRoutes.crops),
          _item(
            context,
            'સિંચાઈ આયોજન',
            Icons.water_drop_outlined,
            AppRoutes.irrigation,
          ),
          _item(
            context,
            'ખેતરનો સારાંશ',
            Icons.analytics_outlined,
            AppRoutes.summary,
          ),
          const Divider(),
          _sectionHeader('ખાતું'),
          if (AppStore.instance.currentAccount != null) ...[
            _item(
              context,
              'મારી પ્રોફાઇલ',
              Icons.person_outline,
              AppRoutes.profile,
            ),
            _item(
              context,
              'સેટિંગ્સ',
              Icons.settings_outlined,
              AppRoutes.settings,
            ),
            ListTile(
              leading: const Icon(Icons.logout, color: AppColors.primary),
              title: const Text('લૉગઆઉટ'),
              onTap: () async {
                Navigator.pop(context);
                await AppStore.instance.logout();
                if (context.mounted) {
                  AppRoutes.replaceAll(context, AppRoutes.login);
                }
              },
            ),
          ] else ...[
            _item(context, 'લૉગિન', Icons.login, AppRoutes.login),
            _item(
              context,
              'નોંધણી',
              Icons.person_add_alt_1,
              AppRoutes.register,
            ),
          ],
          const Divider(),
          _sectionHeader('ડેશબોર્ડ ડિઝાઇન'),
          _item(
            context,
            'વેરિઅન્ટ ૧',
            Icons.dashboard_outlined,
            AppRoutes.homeV1,
          ),
          _item(
            context,
            'વેરિઅન્ટ ૨',
            Icons.view_list_outlined,
            AppRoutes.homeV2,
          ),
          _item(
            context,
            'વેરિઅન્ટ ૩',
            Icons.wb_sunny_outlined,
            AppRoutes.homeV3,
          ),
          _item(
            context,
            'વેરિઅન્ટ ૪',
            Icons.analytics_outlined,
            AppRoutes.homeV4,
          ),
          _item(
            context,
            'વેરિઅન્ટ ૫',
            Icons.agriculture_outlined,
            AppRoutes.homeV5,
          ),
        ],
      ),
    ),
  );

  Widget _header() {
    final account = AppStore.instance.currentAccount;
    return DrawerHeader(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF16542A), Color(0xFF2E8B4E)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            children: [
              ClipOval(
                child: Image.asset(
                  'assets/images/farmer_circle_logo.png',
                  width: 48,
                  height: 48,
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) => const CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(Icons.eco, color: AppColors.primary),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      account?.name ?? 'AgriConnect',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.hindVadodara(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      account == null ? '(એગ્રી કનેક્ટ)' : account.mobile,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.hindVadodara(
                        color: Colors.white70,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'ખેડૂતનો સાથી, સમૃદ્ધિનો રસ્તો',
            style: GoogleFonts.hindVadodara(
              color: Colors.white.withValues(alpha: 0.9),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionHeader(String title) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: Text(
      title,
      style: GoogleFonts.hindVadodara(
        fontSize: 11,
        fontWeight: FontWeight.bold,
        color: AppColors.textLight,
        letterSpacing: 0.5,
      ),
    ),
  );

  Widget _item(
    BuildContext context,
    String title,
    IconData icon,
    String route,
  ) => ListTile(
    selected: activeRoute == route,
    selectedTileColor: AppColors.primarySurface,
    leading: Icon(
      icon,
      color: activeRoute == route ? AppColors.primary : AppColors.textMedium,
      size: 22,
    ),
    title: Text(
      title,
      style: GoogleFonts.hindVadodara(
        fontSize: 14,
        fontWeight: activeRoute == route ? FontWeight.bold : FontWeight.w500,
        color: AppColors.textDark,
      ),
    ),
    dense: true,
    onTap: () {
      Navigator.pop(context);
      if (route != activeRoute) AppRoutes.replace(context, route);
    },
  );
}
