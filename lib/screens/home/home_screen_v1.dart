import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../navigation/app_routes.dart';
import '../../services/app_store.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_drawer.dart';
import '../../widgets/app_bottom_nav.dart';
import '../../widgets/weather_card.dart';

class HomeScreenV1 extends StatefulWidget {
  const HomeScreenV1({super.key});

  @override
  State<HomeScreenV1> createState() => _HomeScreenV1State();
}

class _HomeScreenV1State extends State<HomeScreenV1> {
  final int _navIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFDF9),
      drawer: const AppDrawer(activeRoute: AppRoutes.homeV1),
      appBar: AppBar(
        leading: Builder(
          builder: (ctx) => IconButton(
            icon: const Icon(Icons.menu, color: AppColors.textDark, size: 28),
            onPressed: () => Scaffold.of(ctx).openDrawer(),
          ),
        ),
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
              // AgriConnect Logo with Tagline
              Center(
                child: Column(
                  children: [
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.eco,
                            color: Color(0xFF4CAF50),
                            size: 24,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'Agriconnect',
                            style: GoogleFonts.poppins(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF134E28),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'ખેડૂતનો સાથી, સમૃદ્ધિનો રસ્તો',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.hindVadodara(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF2E8B4E),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 14),

              // Farm Landscape Banner with Sun & Fields
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  'assets/images/illus_landscape_sun.png',
                  height: 140,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) => Image.asset(
                    'assets/images/illus_landscape_tractor.png',
                    height: 140,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Welcome Card with Farmer Portrait
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFE5EDE3)),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x08000000),
                      blurRadius: 10,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 6,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'સ્વાગત છે!',
                            style: GoogleFonts.hindVadodara(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textDark,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'તમારા પાક, ખેતર અને સિંચાઈનું સ્માર્ટ સંચાલન કરો.',
                            style: GoogleFonts.hindVadodara(
                              fontSize: 13,
                              color: AppColors.textMedium,
                              height: 1.3,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          'assets/images/illus_farmer_portrait.png',
                          height: 100,
                          fit: BoxFit.contain,
                          errorBuilder: (_, _, _) => const Icon(
                            Icons.person,
                            size: 80,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              AnimatedBuilder(
                animation: AppStore.instance,
                builder: (context, _) {
                  final farms = AppStore.instance.farms;
                  final cropCount = farms
                      .map((farm) => farm.crop.trim().toLowerCase())
                      .where((crop) => crop.isNotEmpty)
                      .toSet()
                      .length;
                  final plannedIrrigation = farms
                      .where((farm) => farm.irrigationPlan.trim().isNotEmpty)
                      .length;
                  return Card(
                    child: InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: () => AppRoutes.open(context, AppRoutes.summary),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 14,
                          horizontal: 8,
                        ),
                        child: Row(
                          children: [
                            _dashboardMetric('ખેતરો', farms.length),
                            _dashboardMetric('પાક', cropCount),
                            _dashboardMetric('સિંચાઈ યોજના', plannedIrrigation),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 20),

              // Quick Access (ઝડપી ઍક્સેસ) Header
              Text(
                'ઝડપી ઍક્સેસ',
                style: GoogleFonts.hindVadodara(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),

              const SizedBox(height: 12),

              // 3 Quick Access Cards
              Row(
                children: [
                  Expanded(
                    child: _buildQuickCard(
                      iconWidget: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFFE8F5E9),
                        ),
                        child: const Icon(
                          Icons.eco,
                          color: AppColors.primary,
                          size: 28,
                        ),
                      ),
                      title: 'પાક',
                      subtitle: 'પાકની માહિતી અને આગળ આયોજન',
                      onTap: () {
                        AppRoutes.open(context, AppRoutes.crops);
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildQuickCard(
                      iconWidget: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFFE0F2FE),
                        ),
                        child: const Icon(
                          Icons.water_drop,
                          color: Color(0xFF0284C7),
                          size: 28,
                        ),
                      ),
                      title: 'સિંચાઈ',
                      subtitle: 'સિંચાઈ સમય અને વ્યવસ્થાપન કરો',
                      onTap: () {
                        AppRoutes.open(context, AppRoutes.irrigation);
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildQuickCard(
                      iconWidget: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFFFEF3C7),
                        ),
                        child: const Icon(
                          Icons.agriculture,
                          color: Color(0xFFD97706),
                          size: 28,
                        ),
                      ),
                      title: 'ખેતર',
                      subtitle: 'ખેતરની વિગત અને નિરીક્ષણ કરો',
                      onTap: () {
                        AppRoutes.open(context, AppRoutes.farms);
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Weather Card
              Text(
                'આજનું હવામાન',
                style: GoogleFonts.hindVadodara(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),
              const SizedBox(height: 8),
              WeatherCard(
                location: 'રાજકોટ, ગુજરાત',
                temperature: '28°C',
                condition: 'આંશિક વાદળછાયું',
                humidity: '65%',
                windSpeed: '12 km/h',
                onMoreTap: () => AppRoutes.open(context, AppRoutes.weather),
              ),

              const SizedBox(height: 16),

              // Alert Banner with Megaphone
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFFF7FAF6),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFD4EAD0)),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.campaign_outlined,
                        color: AppColors.primary,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'તાજી માહિતી અને સૂચનાઓ મેળવો',
                            style: GoogleFonts.hindVadodara(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textDark,
                            ),
                          ),
                          Text(
                            'મહત્વપૂર્ણ અપડેટ માટે સૂચનાઓ તપાસતા રહો.',
                            style: GoogleFonts.hindVadodara(
                              fontSize: 11,
                              color: AppColors.textMedium,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_forward,
                        color: AppColors.primary,
                        size: 20,
                      ),
                      onPressed: () {
                        AppRoutes.open(context, AppRoutes.summary);
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Variant Switcher Bar for testing all wireframes seamlessly
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

  Widget _buildQuickCard({
    required Widget iconWidget,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE5EDE3)),
        ),
        child: Column(
          children: [
            iconWidget,
            const SizedBox(height: 10),
            Text(
              title,
              style: GoogleFonts.hindVadodara(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: AppColors.textDark,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: GoogleFonts.hindVadodara(
                fontSize: 10,
                color: AppColors.textLight,
                height: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _dashboardMetric(String label, int value) => Expanded(
    child: Column(
      children: [
        Text(
          '$value',
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        Text(
          label,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.hindVadodara(
            fontSize: 11,
            color: AppColors.textMedium,
          ),
        ),
      ],
    ),
  );

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
                _variantChip('વેરિઅન્ટ ૧', isCurrent: true),
                const SizedBox(width: 8),
                _variantChip(
                  'વેરિઅન્ટ ૨',
                  onTap: () {
                    AppRoutes.replace(context, AppRoutes.homeV2);
                  },
                ),
                const SizedBox(width: 8),
                _variantChip(
                  'વેરિઅન્ટ ૩',
                  onTap: () {
                    AppRoutes.replace(context, AppRoutes.homeV3);
                  },
                ),
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
