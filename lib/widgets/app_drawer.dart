import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../screens/splash_screen.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/register_screen.dart';
import '../screens/auth/forgot_password_screen.dart';
import '../screens/home/home_screen_v1.dart';
import '../screens/home/home_screen_v2.dart';
import '../screens/home/home_screen_v3.dart';
import '../screens/home/home_screen_v4.dart';
import '../screens/home/home_screen_v5.dart';
import '../screens/summary/summary_screen.dart';

class AppDrawer extends StatelessWidget {
  final String activeRoute;

  const AppDrawer({super.key, this.activeRoute = ''});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
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
                    Container(
                      width: 48,
                      height: 48,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      padding: const EdgeInsets.all(4),
                      child: ClipOval(
                        child: Image.asset(
                          'assets/images/farmer_circle_logo.png',
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => const Icon(Icons.eco, color: AppColors.primary),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'AgriConnect',
                          style: GoogleFonts.hindVadodara(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '(એગ્રી કનેક્ટ)',
                          style: GoogleFonts.hindVadodara(
                            color: Colors.white70,
                            fontSize: 13,
                          ),
                        ),
                      ],
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
          ),
          _drawerSectionHeader('પ્રવેશ અને પ્રોફાઇલ (Auth)'),
          _drawerItem(
            context,
            title: 'વેલકમ / સ્પ્લેશ સ્ક્રીન',
            icon: Icons.flag_outlined,
            destination: const SplashScreen(),
          ),
          _drawerItem(
            context,
            title: 'લૉગિન પેજ (Login)',
            icon: Icons.login,
            destination: const LoginScreen(),
          ),
          _drawerItem(
            context,
            title: 'રજીસ્ટ્રેશન પેજ (Register)',
            icon: Icons.person_add_alt_1_outlined,
            destination: const RegisterScreen(),
          ),
          _drawerItem(
            context,
            title: 'પાસવર્ડ ભૂલી ગયા છો (Forgot)',
            icon: Icons.lock_reset_outlined,
            destination: const ForgotPasswordScreen(),
          ),
          const Divider(),
          _drawerSectionHeader('હોમ પેજ વેરિઅન્ટ્સ (Dashboard Variants)'),
          _drawerItem(
            context,
            title: 'હોમ વેરિઅન્ટ ૧ (Welcome Card)',
            icon: Icons.dashboard_outlined,
            destination: const HomeScreenV1(),
          ),
          _drawerItem(
            context,
            title: 'હોમ વેરિઅન્ટ ૨ (Crop Summary List)',
            icon: Icons.view_list_outlined,
            destination: const HomeScreenV2(),
          ),
          _drawerItem(
            context,
            title: 'હોમ વેરિઅન્ટ ૩ (Morning Dashboard)',
            icon: Icons.wb_sunny_outlined,
            destination: const HomeScreenV3(),
          ),
          _drawerItem(
            context,
            title: 'હોમ વેરિઅન્ટ ૪ (Farm Status)',
            icon: Icons.analytics_outlined,
            destination: const HomeScreenV4(),
          ),
          _drawerItem(
            context,
            title: 'હોમ વેરિઅન્ટ ૫ (Activities & Alerts)',
            icon: Icons.agriculture_outlined,
            destination: const HomeScreenV5(),
          ),
          const Divider(),
          _drawerSectionHeader('વિગતવાર રિપોર્ટ (Reports)'),
          _drawerItem(
            context,
            title: 'સારાંશ પેજ (Summary Page)',
            icon: Icons.fact_check_outlined,
            destination: const SummaryScreen(),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _drawerSectionHeader(String title) {
    return Padding(
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
  }

  Widget _drawerItem(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Widget destination,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary, size: 22),
      title: Text(
        title,
        style: GoogleFonts.hindVadodara(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: AppColors.textDark,
        ),
      ),
      dense: true,
      onTap: () {
        Navigator.pop(context);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => destination),
        );
      },
    );
  }
}
