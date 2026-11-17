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
import 'home_screen_v4.dart';

class HomeScreenV5 extends StatefulWidget {
  const HomeScreenV5({super.key});

  @override
  State<HomeScreenV5> createState() => _HomeScreenV5State();
}

class _HomeScreenV5State extends State<HomeScreenV5> {
  int _navIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFDF9),
      drawer: const AppDrawer(activeRoute: 'home_v5'),
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
                    '3',
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
              // Greeting + Tractor Landscape Artwork
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
                          'તમારા પાક, ખેતર અને સિંચાઈનું\nસ્માર્ટ સંચાલન કરો એક જગ્યાએ.',
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
                        'assets/images/illus_landscape_tractor.png',
                        height: 90,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => const Icon(
                          Icons.agriculture,
                          size: 70,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Weather Card
              WeatherCard(
                location: 'રાજકોટ, ગુજરાત',
                updateTime: 'આજે, 07:30 AM',
                temperature: '29°C',
                condition: 'આંશિક વાદળછાયું',
                humidity: '62%',
                windSpeed: '14 km/h',
                onRefresh: () {},
              ),

              const SizedBox(height: 20),

              // Farm Summary (મારા ફાર્મનો સારાંશ)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'મારા ફાર્મનો સારાંશ',
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

              // 4 Stat Cards in a 4-column row
              Row(
                children: [
                  Expanded(
                    child: _buildSummaryBox(
                      icon: Icons.yard_outlined,
                      iconColor: AppColors.primary,
                      count: '4',
                      title: 'કુલ ખેતરો',
                      subtitle: '12.6 એકર\nકુલ વિસ્તાર',
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildSummaryBox(
                      icon: Icons.eco_outlined,
                      iconColor: const Color(0xFF16A34A),
                      count: '5',
                      title: 'પાક ઉગાડી રહ્યા છે',
                      subtitle: 'કપાસ, મગફળી,\nઘઉં, જીરૂ, ચણા',
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildSummaryBox(
                      icon: Icons.water_drop_outlined,
                      iconColor: const Color(0xFF0284C7),
                      count: '2',
                      title: 'સિંચાઈ આજે',
                      subtitle: 'ટપક સિંચાઈ\nચાલુ છે',
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildSummaryBox(
                      icon: Icons.assignment_outlined,
                      iconColor: const Color(0xFF7C3AED),
                      count: '3',
                      title: 'બાકી કામ',
                      subtitle: 'દવાં છંટાવ\nખાતર આપવું',
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 22),

              // Quick Access 5 Icons
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
                  _buildQuickActionSquare(Icons.menu_book_outlined, 'પાક માર્ગદર્શિકા', const Color(0xFFE8F5E9), AppColors.primary),
                  _buildQuickActionSquare(Icons.water_damage_outlined, 'સિંચાઈ આયોજન', const Color(0xFFE0F2FE), const Color(0xFF0284C7)),
                  _buildQuickActionSquare(Icons.storefront_outlined, 'બજાર ભાવ', const Color(0xFFFEF3C7), const Color(0xFFD97706)),
                  _buildQuickActionSquare(Icons.analytics_outlined, 'ફાર્મ રિપોર્ટ', const Color(0xFFE8F5E9), const Color(0xFF16A34A)),
                  _buildQuickActionSquare(Icons.headset_mic_outlined, 'સહાય કેન્દ્ર', const Color(0xFFF3E8FF), const Color(0xFF7C3AED)),
                ],
              ),

              const SizedBox(height: 24),

              // Activities Section (આજની પ્રવૃત્તિઓ)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'આજની પ્રવૃત્તિઓ',
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

              // Activity 1
              _buildActivityTile(
                icon: Icons.eco_outlined,
                iconColor: AppColors.primary,
                bgColor: const Color(0xFFE8F5E9),
                title: 'દવાં છંટાવ – કપાસ',
                time: 'સવારે 8:00 AM',
                statusText: 'પૂર્ણ કરો',
                statusBg: AppColors.badgeGreenBg,
                statusColor: AppColors.badgeGreenText,
              ),

              const SizedBox(height: 10),

              // Activity 2
              _buildActivityTile(
                icon: Icons.water_drop_outlined,
                iconColor: const Color(0xFF0284C7),
                bgColor: const Color(0xFFE0F2FE),
                title: 'ટપક સિંચાઈ',
                time: 'સવારે 10:30 AM',
                statusText: 'ચાલુ છે',
                statusBg: AppColors.badgeOrangeBg,
                statusColor: AppColors.badgeOrangeText,
              ),

              const SizedBox(height: 10),

              // Activity 3
              _buildActivityTile(
                icon: Icons.shopping_bag_outlined,
                iconColor: const Color(0xFFD97706),
                bgColor: const Color(0xFFFEF3C7),
                title: 'ખાતર આપવું – ઘઉં',
                time: 'બપોરે 3:00 PM',
                statusText: 'આજે માટે',
                statusBg: AppColors.badgeBlueBg,
                statusColor: AppColors.badgeBlueText,
              ),

              const SizedBox(height: 10),

              // Activity 4
              _buildActivityTile(
                icon: Icons.assignment_outlined,
                iconColor: const Color(0xFF7C3AED),
                bgColor: const Color(0xFFF3E8FF),
                title: 'ફાર્મ નોંધ અપડેટ',
                time: 'સાંજે 6:00 PM',
                statusText: 'બાકી',
                statusBg: AppColors.badgeGrayBg,
                statusColor: AppColors.badgeGrayText,
              ),

              const SizedBox(height: 16),

              // Weather Forecast Alert (આગાહી સૂચના)
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFFF7FAF6),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFD4EAD0)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.thunderstorm_outlined, color: Color(0xFF0284C7), size: 24),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'આગાહી સૂચના',
                            style: GoogleFonts.hindVadodara(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textDark,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'આવતા 2 દિવસ વરસાદની શક્યતા છે.\nખેડૂત મિત્રો, સમયસર સિંચાઈ અને દવાઓનું આયોજન કરો.',
                            style: GoogleFonts.hindVadodara(
                              fontSize: 11,
                              color: AppColors.textMedium,
                              height: 1.25,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('વિગતવાર હવામાન આગાહી વિગતો ખૂલી રહી છે...')),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'વધુ જાણો',
                        style: GoogleFonts.hindVadodara(fontSize: 11, fontWeight: FontWeight.bold),
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
          setState(() => _navIndex = index);
          if (index != 0) {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const SummaryScreen()));
          }
        },
      ),
    );
  }

  Widget _buildSummaryBox({
    required IconData icon,
    required Color iconColor,
    required String count,
    required String title,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5EDE3)),
      ),
      child: Column(
        children: [
          Icon(icon, size: 24, color: iconColor),
          const SizedBox(height: 4),
          Text(
            count,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            maxLines: 2,
            style: GoogleFonts.hindVadodara(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            maxLines: 2,
            style: GoogleFonts.hindVadodara(
              fontSize: 9,
              color: AppColors.textLight,
              height: 1.1,
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

  Widget _buildActivityTile({
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
                _variantChip('વેરિઅન્ટ ૩', onTap: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeScreenV3()));
                }),
                const SizedBox(width: 8),
                _variantChip('વેરિઅન્ટ ૪', onTap: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeScreenV4()));
                }),
                const SizedBox(width: 8),
                _variantChip('વેરિઅન્ટ ૫', isCurrent: true),
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
