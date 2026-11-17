import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_drawer.dart';
import '../../widgets/app_bottom_nav.dart';
import '../../widgets/weather_card.dart';
import '../../widgets/status_badge.dart';
import '../summary/summary_screen.dart';
import 'home_screen_v1.dart';
import 'home_screen_v2.dart';
import 'home_screen_v3.dart';
import 'home_screen_v5.dart';

class HomeScreenV4 extends StatefulWidget {
  const HomeScreenV4({super.key});

  @override
  State<HomeScreenV4> createState() => _HomeScreenV4State();
}

class _HomeScreenV4State extends State<HomeScreenV4> {
  int _navIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFDF9),
      drawer: const AppDrawer(activeRoute: 'home_v4'),
      appBar: AppBar(
        leading: Builder(
          builder: (ctx) => IconButton(
            icon: const Icon(Icons.menu, color: AppColors.textDark, size: 28),
            onPressed: () => Scaffold.of(ctx).openDrawer(),
          ),
        ),
        title: Row(
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
        centerTitle: true,
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.notifications_outlined, color: AppColors.textDark, size: 26),
                onPressed: () {},
              ),
              Positioned(
                right: 10,
                top: 8,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: const Text(
                    '2',
                    style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
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
              // Greeting Row
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 6,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'જય સ્વાગત છે!',
                          style: GoogleFonts.hindVadodara(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textDark,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'તમારા પાક, ખેતર અને સિંચાઈનું\nવ્યવસ્થાપન સરળ બનાવીએ.',
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
                    flex: 5,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        'assets/images/illus_landscape_farm.png',
                        height: 90,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Image.asset(
                          'assets/images/illus_landscape_tractor.png',
                          height: 90,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Weather Row
              WeatherCard(
                location: 'રાજકોટ, ગુજરાત',
                updateTime: 'આજે, 07:30 AM',
                temperature: '28°C',
                condition: 'આંશિક વાદળછાયું',
                humidity: '65%',
                windSpeed: '12 km/h',
                onRefresh: () {},
              ),

              const SizedBox(height: 20),

              // Farm Status Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'મારા ખેતરની સ્થિતિ',
                    style: GoogleFonts.hindVadodara(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const SummaryScreen()));
                    },
                    child: Text(
                      'બધા ખેતરો જુઓ >',
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

              // 3 Status Cards Row
              Row(
                children: [
                  Expanded(
                    child: _buildStatusColumnCard(
                      iconWidget: Container(
                        width: 38,
                        height: 38,
                        decoration: const BoxDecoration(
                          color: Color(0xFFE8F5E9),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.yard_outlined, color: AppColors.primary, size: 20),
                      ),
                      countText: '3',
                      mainLabel: 'સક્રિય ખેતર',
                      subDetails: 'કુલ વિસ્તાર\n10.4 એકર',
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildStatusColumnCard(
                      iconWidget: Container(
                        width: 38,
                        height: 38,
                        decoration: const BoxDecoration(
                          color: Color(0xFFDCFCE7),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.eco_outlined, color: Color(0xFF16A34A), size: 20),
                      ),
                      countText: '4',
                      mainLabel: 'પાક ઉગડી રહ્યા છે',
                      subDetails: 'આ સીઝનમાં\nકપાસ, મગફળી, ઘઉં, જીરુ',
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildStatusColumnCard(
                      iconWidget: Container(
                        width: 38,
                        height: 38,
                        decoration: const BoxDecoration(
                          color: Color(0xFFE0F2FE),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.water_drop_outlined, color: Color(0xFF0284C7), size: 20),
                      ),
                      countText: '2',
                      mainLabel: 'સિંચાઈ આજે',
                      subDetails: 'આપોઆપ સિંચાઈ\n1 ખેતરમાં ચાલુ',
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 22),

              // Quick Access
              Text(
                'ઝડપી ઍક્સેસ',
                style: GoogleFonts.hindVadodara(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),

              const SizedBox(height: 12),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildQuickActionSquare(Icons.menu_book_outlined, 'પાક માર્ગદર્શન', const Color(0xFFE8F5E9), AppColors.primary),
                  _buildQuickActionSquare(Icons.water_damage_outlined, 'સિંચાઈ આયોજન', const Color(0xFFE0F2FE), const Color(0xFF0284C7)),
                  _buildQuickActionSquare(Icons.shopping_bag_outlined, 'બજાર ભાવ', const Color(0xFFFEF3C7), const Color(0xFFD97706)),
                  _buildQuickActionSquare(Icons.analytics_outlined, 'ખેતર રિપોર્ટ', const Color(0xFFE8F5E9), const Color(0xFF16A34A)),
                  _buildQuickActionSquare(Icons.headset_mic_outlined, 'સહાય કેન્દ્ર', const Color(0xFFF3E8FF), const Color(0xFF7C3AED)),
                ],
              ),

              const SizedBox(height: 24),

              // Today's Agenda (આજની કાર્યસૂચિ)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'આજની કાર્યસૂચિ',
                    style: GoogleFonts.hindVadodara(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const SummaryScreen()));
                    },
                    child: Text(
                      'બધી જુઓ >',
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

              // Item 1
              _buildAgendaItem(
                icon: Icons.eco_outlined,
                iconColor: AppColors.primary,
                bgColor: const Color(0xFFE8F5E9),
                title: 'કપાસ - ખેતર 1',
                activity: 'દવા છંટકાવ',
                time: '8:00 AM',
                statusText: 'પૂર્ણ કરો',
                statusBg: AppColors.badgeGreenBg,
                statusColor: AppColors.badgeGreenText,
              ),

              const SizedBox(height: 10),

              // Item 2
              _buildAgendaItem(
                icon: Icons.science_outlined,
                iconColor: const Color(0xFFD97706),
                bgColor: const Color(0xFFFEF3C7),
                title: 'મગફળી - ખેતર 2',
                activity: 'સિંચાઈ ચાલુ કરવી',
                time: '10:30 AM',
                statusText: 'ચાલુ છે',
                statusBg: AppColors.badgeOrangeBg,
                statusColor: AppColors.badgeOrangeText,
              ),

              const SizedBox(height: 10),

              // Item 3
              _buildAgendaItem(
                icon: Icons.assignment_outlined,
                iconColor: const Color(0xFF7C3AED),
                bgColor: const Color(0xFFF3E8FF),
                title: 'ઘઉં - ખેતર 3',
                activity: 'ખાતર નાખવું',
                time: '5:00 PM',
                statusText: 'આજે માટે',
                statusBg: AppColors.badgeBlueBg,
                statusColor: AppColors.badgeBlueText,
              ),

              const SizedBox(height: 16),

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
                      child: const Icon(Icons.campaign_outlined, color: AppColors.primary, size: 24),
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
                            'આગામી 2 દિવસ સુધી હળવો વરસાદની શક્યતા છે. પાકની સુરક્ષા માટે યોગ્ય વ્યવસ્થા કરો.',
                            style: GoogleFonts.hindVadodara(
                              fontSize: 11,
                              color: AppColors.textMedium,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.arrow_forward, color: AppColors.primary, size: 20),
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
          setState(() => _navIndex = index);
          if (index != 0) {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const SummaryScreen()));
          }
        },
      ),
    );
  }

  Widget _buildStatusColumnCard({
    required Widget iconWidget,
    required String countText,
    required String mainLabel,
    required String subDetails,
  }) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5EDE3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              iconWidget,
              const SizedBox(width: 6),
              Text(
                countText,
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            mainLabel,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.hindVadodara(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            subDetails,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.hindVadodara(
              fontSize: 10,
              color: AppColors.textLight,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionSquare(IconData icon, String title, Color bg, Color iconColor) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => const SummaryScreen()));
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

  Widget _buildAgendaItem({
    required IconData icon,
    required Color iconColor,
    required Color bgColor,
    required String title,
    required String activity,
    required String time,
    required String statusText,
    required Color statusBg,
    required Color statusColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5EDE3)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: iconColor, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.hindVadodara(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                ),
                Text(
                  activity,
                  style: GoogleFonts.hindVadodara(
                    fontSize: 11,
                    color: AppColors.textMedium,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              const Icon(Icons.access_time, size: 14, color: AppColors.textLight),
              const SizedBox(width: 4),
              Text(
                time,
                style: GoogleFonts.hindVadodara(
                  fontSize: 11,
                  color: AppColors.textLight,
                ),
              ),
            ],
          ),
          const SizedBox(width: 10),
          StatusBadge(
            text: statusText,
            backgroundColor: statusBg,
            textColor: statusColor,
          ),
          const SizedBox(width: 4),
          const Icon(Icons.chevron_right, size: 18, color: AppColors.textLight),
        ],
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
                _variantChip('વેરિઅન્ટ ૧', onTap: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeScreenV1()));
                }),
                const SizedBox(width: 8),
                _variantChip('વેરિઅન્ટ ૨', onTap: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeScreenV2()));
                }),
                const SizedBox(width: 8),
                _variantChip('વેરિઅન્ટ ૩', onTap: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeScreenV3()));
                }),
                const SizedBox(width: 8),
                _variantChip('વેરિઅન્ટ ૪', isCurrent: true),
                const SizedBox(width: 8),
                _variantChip('વેરિઅન્ટ ૫', onTap: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeScreenV5()));
                }),
                const SizedBox(width: 8),
                _variantChip('સારાંશ (Summary)', onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const SummaryScreen()));
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _variantChip(String label, {bool isCurrent = false, VoidCallback? onTap}) {
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
      side: BorderSide(color: isCurrent ? AppColors.primary : const Color(0xFFCBD5E1)),
      onPressed: onTap,
    );
  }
}
