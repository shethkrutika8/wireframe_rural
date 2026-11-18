import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../navigation/app_routes.dart';
import '../../services/app_store.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_drawer.dart';
import '../../widgets/app_bottom_nav.dart';
import '../../widgets/weather_card.dart';
import '../../widgets/status_badge.dart';

class HomeScreenV2 extends StatefulWidget {
  const HomeScreenV2({super.key});

  @override
  State<HomeScreenV2> createState() => _HomeScreenV2State();
}

class _HomeScreenV2State extends State<HomeScreenV2> {
  final int _navIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFDF9),
      drawer: const AppDrawer(activeRoute: AppRoutes.homeV2),
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
              LayoutBuilder(
                builder: (context, constraints) {
                  final greeting = Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'નમસ્તે!',
                            style: GoogleFonts.hindVadodara(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textDark,
                            ),
                          ),
                          const SizedBox(width: 6),
                          const Icon(
                            Icons.eco,
                            color: Color(0xFF4CAF50),
                            size: 24,
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'તમારા પાક, ખેતર અને\nસંચાલનને સરળ બનાવીએ.',
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
                      'assets/images/illus_landscape_hills.png',
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

              // Weather Card with "વધુ જુઓ >"
              WeatherCard(
                location: 'રાજકોટ, ગુજરાત',
                temperature: '28°C',
                condition: 'આંશિક વાદળછાયું',
                humidity: '65%',
                windSpeed: '12 km/h',
                onMoreTap: () => AppRoutes.open(context, AppRoutes.weather),
              ),

              const SizedBox(height: 20),

              // Quick Access (ઝડપી ઍક્સેસ) Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'ઝડપી ઍક્સેસ',
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

              const SizedBox(height: 10),

              // 3 Quick Action Cards
              Row(
                children: [
                  Expanded(
                    child: _buildActionCard(
                      icon: Icons.eco,
                      iconColor: AppColors.primary,
                      bgColor: const Color(0xFFE8F5E9),
                      title: 'પાક',
                      subtitle: 'પાકની માહિતી અને વ્યવસ્થાપન કરો',
                      onTap: () => AppRoutes.open(context, AppRoutes.crops),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildActionCard(
                      icon: Icons.water_drop,
                      iconColor: const Color(0xFF0284C7),
                      bgColor: const Color(0xFFE0F2FE),
                      title: 'સિંચાઈ',
                      subtitle: 'સિંચાઈ સમય અને ઑટોમેશન નિયંત્રિત કરો',
                      onTap: () =>
                          AppRoutes.open(context, AppRoutes.irrigation),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildActionCard(
                      icon: Icons.agriculture,
                      iconColor: const Color(0xFFD97706),
                      bgColor: const Color(0xFFFEF3C7),
                      title: 'ખેતર',
                      subtitle: 'ખેતરની વિગત અને નિરીક્ષણ કરો',
                      onTap: () => AppRoutes.open(context, AppRoutes.farms),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Section: મારા ખેતરનો સારાંશ
              Text(
                'મારા ખેતરનો સારાંશ',
                style: GoogleFonts.hindVadodara(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),

              const SizedBox(height: 12),

              AnimatedBuilder(
                animation: AppStore.instance,
                builder: (context, _) {
                  final farms = AppStore.instance.farms;
                  if (farms.isEmpty) {
                    return Card(
                      child: ListTile(
                        leading: const Icon(
                          Icons.yard_outlined,
                          color: AppColors.primary,
                        ),
                        title: const Text('હજુ કોઈ ખેતર ઉમેર્યું નથી'),
                        trailing: const Icon(Icons.add),
                        onTap: () => AppRoutes.open(context, AppRoutes.farms),
                      ),
                    );
                  }
                  return Column(
                    children: [
                      for (final farm in farms.take(3)) ...[
                        _buildFarmRow(
                          fieldNumber: farm.name,
                          acreage: '${farm.area} એકર',
                          cropIcon: Icons.eco_outlined,
                          cropName: farm.crop,
                          sowingDate: farm.sowingDate.isEmpty
                              ? 'વાવણી તારીખ ઉમેરેલ નથી'
                              : 'વાવણી: ${farm.sowingDate}',
                          statusText: 'સાચવ્યું',
                          statusColor: AppColors.badgeGreenText,
                          statusBg: AppColors.badgeGreenBg,
                        ),
                        const SizedBox(height: 8),
                      ],
                    ],
                  );
                },
              ),

              const SizedBox(height: 10),

              // Link: બધા ખેતર જુઓ >
              Center(
                child: TextButton(
                  onPressed: () {
                    AppRoutes.open(context, AppRoutes.farms);
                  },
                  child: Text(
                    'બધા ખેતર જુઓ >',
                    style: GoogleFonts.hindVadodara(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Alert Banner
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
                            'મહત્વપૂર્ણ સૂચના',
                            style: GoogleFonts.hindVadodara(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textDark,
                            ),
                          ),
                          Text(
                            'હવામાન અને સૂચના સેવા જોડાયેલી નથી; લાઇવ ચેતવણીઓ ઉપલબ્ધ નથી.',
                            style: GoogleFonts.hindVadodara(
                              fontSize: 11,
                              color: AppColors.textMedium,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      tooltip: 'હવામાન સેવા સ્થિતિ',
                      onPressed: () =>
                          AppRoutes.open(context, AppRoutes.weather),
                      icon: const Icon(
                        Icons.chevron_right,
                        color: AppColors.textLight,
                      ),
                    ),
                  ],
                ),
              ),

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

  Widget _buildActionCard({
    required IconData icon,
    required Color iconColor,
    required Color bgColor,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE5EDE3)),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
              child: Icon(icon, color: iconColor, size: 24),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: GoogleFonts.hindVadodara(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppColors.textDark,
              ),
            ),
            const SizedBox(height: 2),
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

  Widget _buildFarmRow({
    required String fieldNumber,
    required String acreage,
    required IconData cropIcon,
    required String cropName,
    required String sowingDate,
    required String statusText,
    required Color statusColor,
    required Color statusBg,
  }) {
    return InkWell(
      onTap: () => AppRoutes.open(context, AppRoutes.farms),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE5EDE3)),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFE8F5E9),
              ),
              child: const Icon(
                Icons.yard_outlined,
                color: AppColors.primary,
                size: 24,
              ),
            ),
            const SizedBox(width: 10),
            SizedBox(
              width: 75,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    fieldNumber,
                    style: GoogleFonts.hindVadodara(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),
                  Text(
                    acreage,
                    style: GoogleFonts.hindVadodara(
                      fontSize: 11,
                      color: AppColors.textLight,
                    ),
                  ),
                ],
              ),
            ),
            Icon(cropIcon, size: 18, color: const Color(0xFFD97706)),
            const SizedBox(width: 6),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cropName,
                    style: GoogleFonts.hindVadodara(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),
                  Text(
                    sowingDate,
                    style: GoogleFonts.hindVadodara(
                      fontSize: 10,
                      color: AppColors.textLight,
                    ),
                  ),
                ],
              ),
            ),
            StatusBadge(
              text: statusText,
              backgroundColor: statusBg,
              textColor: statusColor,
            ),
            const SizedBox(width: 4),
            const Icon(
              Icons.chevron_right,
              size: 18,
              color: AppColors.textLight,
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
                _variantChip('વેરિઅન્ટ ૨', isCurrent: true),
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
