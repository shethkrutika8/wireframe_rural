import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../navigation/app_routes.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_drawer.dart';
import '../../widgets/app_bottom_nav.dart';
import '../../widgets/weather_card.dart';
import '../../widgets/farm_dashboard_sections.dart';

class HomeScreenV3 extends StatefulWidget {
  const HomeScreenV3({super.key});

  @override
  State<HomeScreenV3> createState() => _HomeScreenV3State();
}

class _HomeScreenV3State extends State<HomeScreenV3> {
  final int _navIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFDF9),
      drawer: const AppDrawer(activeRoute: AppRoutes.homeV3),
      appBar: AppBar(
        leading: Builder(
          builder: (ctx) => IconButton(
            icon: const Icon(Icons.menu, color: AppColors.textDark, size: 28),
            onPressed: () => Scaffold.of(ctx).openDrawer(),
          ),
        ),
        title: FittedBox(
          fit: BoxFit.scaleDown,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.eco, color: Color(0xFF4CAF50), size: 20),
              const SizedBox(width: 4),
              Text(
                'AgriConnect',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF16542A),
                ),
              ),
            ],
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            tooltip: 'સહાય',
            icon: const Icon(
              Icons.notifications_outlined,
              color: AppColors.textDark,
              size: 26,
            ),
            onPressed: () => AppRoutes.open(context, AppRoutes.support),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              LayoutBuilder(
                builder: (context, constraints) {
                  final greeting = Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'સુપ્રભાત!',
                            style: GoogleFonts.hindVadodara(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textDark,
                            ),
                          ),
                          const SizedBox(width: 4),
                          const Text('☀️', style: TextStyle(fontSize: 20)),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'તમારા ખેતરની માહિતી અને\nકાર્યક્ષમતા એક નજરમાં જુઓ.',
                        style: GoogleFonts.hindVadodara(
                          fontSize: 13,
                          color: AppColors.textMedium,
                          height: 1.3,
                        ),
                      ),
                    ],
                  );
                  final illustration = ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      'assets/images/illus_landscape_windmill.png',
                      height: 90,
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) => Image.asset(
                        'assets/images/illus_landscape_tractor.png',
                        height: 90,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                  if (constraints.maxWidth < 360) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        greeting,
                        const SizedBox(height: 12),
                        illustration,
                      ],
                    );
                  }
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 6, child: greeting),
                      const SizedBox(width: 8),
                      Expanded(flex: 5, child: illustration),
                    ],
                  );
                },
              ),

              const SizedBox(height: 16),

              // Weather Row with Refresh
              WeatherCard(
                location: 'રાજકોટ, ગુજરાત',
                updateTime: 'અપડેટ: આજે 07:30 AM',
                temperature: '28°C',
                condition: 'આંશિક વાદળછાયું',
                humidity: '65%',
                windSpeed: '12 km/h',
                onMoreTap: () => AppRoutes.open(context, AppRoutes.weather),
              ),

              const SizedBox(height: 20),

              // Farm Summary (ખેતરનો સારાંશ) with 4 Stat Cards
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'ખેતરનો સારાંશ',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.hindVadodara(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      AppRoutes.open(context, AppRoutes.summary);
                    },
                    child: Text(
                      'બધું જુઓ >',
                      style: GoogleFonts.hindVadodara(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              const FarmDashboardMetrics(),

              const SizedBox(height: 22),

              // Quick Access (ઝડપી ઍક્સેસ) 5 Icons Row
              Text(
                'ઝડપી ઍક્સેસ',
                style: GoogleFonts.hindVadodara(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),

              const SizedBox(height: 12),

              Wrap(
                alignment: WrapAlignment.spaceBetween,
                spacing: 8,
                runSpacing: 12,
                children: [
                  _buildCircleFeatureItem(
                    Icons.menu_book_outlined,
                    'પાક માર્ગદર્શન',
                    const Color(0xFFE8F5E9),
                    AppColors.primary,
                    AppRoutes.cropAdvisory,
                  ),
                  _buildCircleFeatureItem(
                    Icons.water,
                    'સિંચાઈ યોજના',
                    const Color(0xFFE0F2FE),
                    const Color(0xFF0284C7),
                    AppRoutes.irrigation,
                  ),
                  _buildCircleFeatureItem(
                    Icons.storefront_outlined,
                    'બજાર ભાવ',
                    const Color(0xFFFEF3C7),
                    const Color(0xFFD97706),
                    AppRoutes.market,
                  ),
                  _buildCircleFeatureItem(
                    Icons.analytics_outlined,
                    'ખેતર રિપોર્ટ',
                    const Color(0xFFE8F5E9),
                    const Color(0xFF16A34A),
                    AppRoutes.summary,
                  ),
                  _buildCircleFeatureItem(
                    Icons.headset_mic_outlined,
                    'સહાય કેન્દ્ર',
                    const Color(0xFFF3E8FF),
                    const Color(0xFF7C3AED),
                    AppRoutes.support,
                  ),
                ],
              ),

              const SizedBox(height: 24),

              const FarmDashboardList(title: 'મારા ખેતરો'),

              const SizedBox(height: 20),

              _buildVariantSwitcher(),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: AppBottomNav(
        currentIndex: _navIndex,
        onTap: (index) {
          AppRoutes.selectBottomNavigation(context, index);
        },
      ),
    );
  }

  Widget _buildCircleFeatureItem(
    IconData icon,
    String title,
    Color bg,
    Color iconColor,
    String route,
  ) {
    return InkWell(
      onTap: () {
        AppRoutes.open(context, route);
      },
      child: SizedBox(
        width: 62,
        child: Column(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: bg,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, color: iconColor, size: 24),
            ),
            const SizedBox(height: 6),
            Text(
              title,
              textAlign: TextAlign.center,
              maxLines: 2,
              style: GoogleFonts.hindVadodara(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: AppColors.textDark,
                height: 1.1,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVariantSwitcher() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'હોમ પેજ વેરિઅન્ટ્સ બદલો:',
            style: GoogleFonts.hindVadodara(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 8),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _variantChip(
                  'વેરિઅન્ટ ૧',
                  onTap: () {
                    AppRoutes.replace(context, AppRoutes.homeV1);
                  },
                ),
                const SizedBox(width: 8),
                _variantChip(
                  'વેરિઅન્ટ ૨',
                  onTap: () {
                    AppRoutes.replace(context, AppRoutes.homeV2);
                  },
                ),
                const SizedBox(width: 8),
                _variantChip('વેરિઅન્ટ ૩', isCurrent: true),
                const SizedBox(width: 8),
                _variantChip(
                  'વેરિઅન્ટ ૪',
                  onTap: () {
                    AppRoutes.replace(context, AppRoutes.homeV4);
                  },
                ),
                const SizedBox(width: 8),
                _variantChip(
                  'વેરિઅન્ટ ૫',
                  onTap: () {
                    AppRoutes.replace(context, AppRoutes.homeV5);
                  },
                ),
                const SizedBox(width: 8),
                _variantChip(
                  'સારાંશ (Summary)',
                  onTap: () {
                    AppRoutes.open(context, AppRoutes.summary);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _variantChip(
    String label, {
    bool isCurrent = false,
    VoidCallback? onTap,
  }) {
    return ActionChip(
      label: Text(
        label,
        style: GoogleFonts.hindVadodara(
          fontSize: 11,
          fontWeight: isCurrent ? FontWeight.bold : FontWeight.w500,
          color: isCurrent ? Colors.white : AppColors.textDark,
        ),
      ),
      backgroundColor: isCurrent ? AppColors.primary : Colors.white,
      side: BorderSide(
        color: isCurrent ? AppColors.primary : const Color(0xFFCBD5E1),
      ),
      onPressed: onTap,
    );
  }
}
