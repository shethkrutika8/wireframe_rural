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
import 'home_screen_v4.dart';
import 'home_screen_v5.dart';

class HomeScreenV3 extends StatefulWidget {
  const HomeScreenV3({super.key});

  @override
  State<HomeScreenV3> createState() => _HomeScreenV3State();
}

class _HomeScreenV3State extends State<HomeScreenV3> {
  int _navIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFDF9),
      drawer: const AppDrawer(activeRoute: 'home_v3'),
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
              // Greeting + Landscape Artwork
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 6,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
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
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        'assets/images/illus_landscape_windmill.png',
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

              // Weather Row with Refresh
              WeatherCard(
                location: 'રાજકોટ, ગુજરાત',
                updateTime: 'અપડેટ: આજે 07:30 AM',
                temperature: '28°C',
                condition: 'આંશિક વાદળછાયું',
                humidity: '65%',
                windSpeed: '12 km/h',
                onRefresh: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('હવામાન માહિતી તાજી થઈ રહી છે...')),
                  );
                },
              ),

              const SizedBox(height: 20),

              // Farm Summary (ખેતરનો સારાંશ) with 4 Stat Cards
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'ખેતરનો સારાંશ',
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

              // 4 Stat Cards Row
              Row(
                children: [
                  Expanded(
                    child: _buildMetricCard(
                      icon: Icons.yard_outlined,
                      iconColor: AppColors.primary,
                      count: '3',
                      label: 'ખેતર',
                      subLabel: 'કુલ',
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildMetricCard(
                      icon: Icons.eco_outlined,
                      iconColor: const Color(0xFF16A34A),
                      count: '4',
                      label: 'પાક',
                      subLabel: 'ચાલુ',
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildMetricCard(
                      icon: Icons.water_drop_outlined,
                      iconColor: const Color(0xFF0284C7),
                      count: '2',
                      label: 'સિંચાઈ',
                      subLabel: 'આજે માટે',
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildMetricCard(
                      icon: Icons.assignment_outlined,
                      iconColor: const Color(0xFF7C3AED),
                      count: '5',
                      label: 'કાર્યસૂચિ',
                      subLabel: 'બાકી',
                    ),
                  ),
                ],
              ),

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

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildCircleFeatureItem(Icons.menu_book_outlined, 'પાક માર્ગદર્શન', const Color(0xFFE8F5E9), AppColors.primary),
                  _buildCircleFeatureItem(Icons.water, 'સિંચાઈ યોજના', const Color(0xFFE0F2FE), const Color(0xFF0284C7)),
                  _buildCircleFeatureItem(Icons.storefront_outlined, 'બજાર ભાવ', const Color(0xFFFEF3C7), const Color(0xFFD97706)),
                  _buildCircleFeatureItem(Icons.analytics_outlined, 'ખેતર રિપોર્ટ', const Color(0xFFE8F5E9), const Color(0xFF16A34A)),
                  _buildCircleFeatureItem(Icons.headset_mic_outlined, 'સહાય કેન્દ્ર', const Color(0xFFF3E8FF), const Color(0xFF7C3AED)),
                ],
              ),

              const SizedBox(height: 24),

              // Section: આજની કાર્યસૂચિ (Daily To-Do List)
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

              // Task 1
              _buildTaskCard(
                icon: Icons.eco_outlined,
                iconColor: AppColors.primary,
                bgColor: const Color(0xFFE8F5E9),
                title: 'ડ્રીપ સિંચાઈ તપાસો - ખેતર 1',
                time: 'સવારે 8:00 AM',
                statusText: 'પૂર્ણ કરો',
                statusBg: AppColors.badgeGreenBg,
                statusColor: AppColors.badgeGreenText,
              ),

              const SizedBox(height: 10),

              // Task 2
              _buildTaskCard(
                icon: Icons.assignment_outlined,
                iconColor: const Color(0xFFD97706),
                bgColor: const Color(0xFFFEF3C7),
                title: 'ખાતર નાંખવું - ખેતર 2',
                time: 'સવારે 10:30 AM',
                statusText: 'ચાલુ છે',
                statusBg: AppColors.badgeOrangeBg,
                statusColor: AppColors.badgeOrangeText,
              ),

              const SizedBox(height: 10),

              // Task 3
              _buildTaskCard(
                icon: Icons.pest_control_outlined,
                iconColor: const Color(0xFF7C3AED),
                bgColor: const Color(0xFFF3E8FF),
                title: 'કીટ નિયંત્રણ - ખેતર 3',
                time: 'સાંજે 5:00 PM',
                statusText: 'આજે માટે',
                statusBg: AppColors.badgeBlueBg,
                statusColor: AppColors.badgeBlueText,
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

  Widget _buildMetricCard({
    required IconData icon,
    required Color iconColor,
    required String count,
    required String label,
    required String subLabel,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5EDE3)),
      ),
      child: Column(
        children: [
          Icon(icon, size: 26, color: iconColor),
          const SizedBox(height: 6),
          Text(
            count,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
          ),
          Text(
            label,
            style: GoogleFonts.hindVadodara(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.textDark,
            ),
          ),
          Text(
            subLabel,
            style: GoogleFonts.hindVadodara(
              fontSize: 10,
              color: AppColors.textLight,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCircleFeatureItem(IconData icon, String title, Color bg, Color iconColor) {
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

  Widget _buildTaskCard({
    required IconData icon,
    required Color iconColor,
    required Color bgColor,
    required String title,
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
            padding: const EdgeInsets.all(10),
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
                  time,
                  style: GoogleFonts.hindVadodara(
                    fontSize: 11,
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
          const SizedBox(width: 6),
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
                _variantChip('વેરિઅન્ટ ૩', isCurrent: true),
                const SizedBox(width: 8),
                _variantChip('વેરિઅન્ટ ૪', onTap: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeScreenV4()));
                }),
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
