import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_drawer.dart';
import '../../widgets/status_badge.dart';

class SummaryScreen extends StatefulWidget {
  const SummaryScreen({super.key});

  @override
  State<SummaryScreen> createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFDF9),
      drawer: const AppDrawer(activeRoute: 'summary'),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primary, size: 24),
          onPressed: () => Navigator.pop(context),
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
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header Row: Title + Checklist Artwork
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 6,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        Text(
                          'સારાંશ (Summary)',
                          style: GoogleFonts.hindVadodara(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textDark,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'તમારા ખેતરની તમામ માહિતી અને પ્રવૃતિઓનો સારાંશ અહીં જોવા મળી છે.',
                          style: GoogleFonts.hindVadodara(
                            fontSize: 12,
                            color: AppColors.textLight,
                            height: 1.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        'assets/images/illus_summary.png',
                        height: 95,
                        fit: BoxFit.contain,
                        errorBuilder: (_, __, ___) => const Icon(
                          Icons.checklist_rounded,
                          size: 70,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Section 1: પ્રવૃતિનો સંક્ષિપ્ત સારાંશ
              Text(
                'પ્રવૃતિનો સંક્ષિપ્ત સારાંશ',
                style: GoogleFonts.hindVadodara(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),

              const SizedBox(height: 10),

              // 4 Stat Cards Row
              Row(
                children: [
                  Expanded(
                    child: _buildStatTile(
                      icon: Icons.yard_outlined,
                      iconColor: AppColors.primary,
                      title: 'કુલ ખેતરો',
                      count: '4',
                      subtext: 'એક્ટિવ 3',
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildStatTile(
                      icon: Icons.eco_outlined,
                      iconColor: const Color(0xFF16A34A),
                      title: 'કુલ પાકો',
                      count: '5',
                      subtext: 'વિકાસમાન 5',
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildStatTile(
                      icon: Icons.water_drop_outlined,
                      iconColor: const Color(0xFF0284C7),
                      title: 'સિંચાઈ પ્રવૃતિ',
                      count: '2',
                      subtext: 'આજે કરવાની',
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildStatTile(
                      icon: Icons.assignment_outlined,
                      iconColor: const Color(0xFFD97706),
                      title: 'બાકી કામ',
                      count: '3',
                      subtext: 'પૂર્ણ કરવાનું',
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 22),

              // Section 2: પાકનું સારાંશ (Crop Summary Table)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'પાકનું સારાંશ',
                    style: GoogleFonts.hindVadodara(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Text(
                      'વધુ જુઓ >',
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

              // Crop Table Card
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFE5EDE3)),
                ),
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                child: Column(
                  children: [
                    // Table Header
                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Text(
                            'પાક',
                            style: GoogleFonts.hindVadodara(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.textLight),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            'ખેતર',
                            style: GoogleFonts.hindVadodara(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.textLight),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            'સ્થિતિ',
                            style: GoogleFonts.hindVadodara(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.textLight),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Text(
                            'અંદાજીત કાપણી',
                            textAlign: TextAlign.right,
                            style: GoogleFonts.hindVadodara(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.textLight),
                          ),
                        ),
                      ],
                    ),
                    const Divider(color: Color(0xFFE5EDE3), height: 16),
                    // Row 1: Cotton
                    _buildCropRow(
                      icon: Icons.grass,
                      iconColor: const Color(0xFF4CAF50),
                      crop: 'કપાસ',
                      farm: 'ખેતર 1',
                      status: 'સારો',
                      statusBg: AppColors.badgeGreenBg,
                      statusColor: AppColors.badgeGreenText,
                      date: '12 જૂન 2026',
                    ),
                    const Divider(color: Color(0xFFF1F5F9), height: 14),
                    // Row 2: Groundnut
                    _buildCropRow(
                      icon: Icons.scatter_plot,
                      iconColor: const Color(0xFFD97706),
                      crop: 'મગફળી',
                      farm: 'ખેતર 2',
                      status: 'વિકાસમાં',
                      statusBg: AppColors.badgeOrangeBg,
                      statusColor: AppColors.badgeOrangeText,
                      date: '05 જુલાઈ 2026',
                    ),
                    const Divider(color: Color(0xFFF1F5F9), height: 14),
                    // Row 3: Wheat
                    _buildCropRow(
                      icon: Icons.grain,
                      iconColor: const Color(0xFFD97706),
                      crop: 'ઘઉં',
                      farm: 'ખેતર 3',
                      status: 'સારો',
                      statusBg: AppColors.badgeGreenBg,
                      statusColor: AppColors.badgeGreenText,
                      date: '20 નવેમ્બર 2025',
                    ),
                    const Divider(color: Color(0xFFF1F5F9), height: 14),
                    // Row 4: Sorghum (Jowar)
                    _buildCropRow(
                      icon: Icons.eco,
                      iconColor: const Color(0xFF16A34A),
                      crop: 'જુવાર',
                      farm: 'ખેતર 4',
                      status: 'વિકાસમાં',
                      statusBg: AppColors.badgeOrangeBg,
                      statusColor: AppColors.badgeOrangeText,
                      date: '15 ઓગસ્ટ 2026',
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 22),

              // Section 3: સિંચાઈ સારાંશ
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'સિંચાઈ સારાંશ',
                    style: GoogleFonts.hindVadodara(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Text(
                      'વધુ જુઓ >',
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

              // 3 Irrigation Cards Row
              Row(
                children: [
                  Expanded(
                    child: _buildIrrigationCard(
                      icon: Icons.water_drop_outlined,
                      iconColor: const Color(0xFF0284C7),
                      title: 'આજે સિંચાઈ',
                      count: '2',
                      unit: 'ખેતર',
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildIrrigationCard(
                      icon: Icons.calendar_month_outlined,
                      iconColor: const Color(0xFF16A34A),
                      title: 'આવતીકાલે આયોજન',
                      count: '1',
                      unit: 'ખેતર',
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildIrrigationCard(
                      icon: Icons.pie_chart_outline,
                      iconColor: const Color(0xFFD97706),
                      title: 'કુલ પાણીનો વિસ્તાર',
                      count: '6.2',
                      unit: 'એકર',
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 22),

              // Section 4: ફાર્મ નોંધો (Recent Notes)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'ફાર્મ નોંધો (Recent Notes)',
                    style: GoogleFonts.hindVadodara(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Text(
                      'વધુ જુઓ >',
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

              // Note 1
              _buildNoteTile(
                icon: Icons.eco_outlined,
                iconColor: AppColors.primary,
                bgColor: const Color(0xFFE8F5E9),
                noteText: 'ખેતર 1 માં પીળીયું દેખાયું. નિરીક્ષણ ચાલુ છે.',
                dateText: '10 જૂન 2026',
              ),

              const SizedBox(height: 8),

              // Note 2
              _buildNoteTile(
                icon: Icons.water_drop_outlined,
                iconColor: const Color(0xFF0284C7),
                bgColor: const Color(0xFFE0F2FE),
                noteText: 'ખેતર 2 માં આગણી સિંચાઈ શરૂ કરવામાં આવી.',
                dateText: '09 જૂન 2026',
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatTile({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String count,
    required String subtext,
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
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.hindVadodara(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            count,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
          ),
          Text(
            subtext,
            textAlign: TextAlign.center,
            style: GoogleFonts.hindVadodara(
              fontSize: 10,
              color: AppColors.textLight,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCropRow({
    required IconData icon,
    required Color iconColor,
    required String crop,
    required String farm,
    required String status,
    required Color statusBg,
    required Color statusColor,
    required String date,
  }) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Row(
            children: [
              Icon(icon, size: 16, color: iconColor),
              const SizedBox(width: 4),
              Flexible(
                child: Text(
                  crop,
                  style: GoogleFonts.hindVadodara(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            farm,
            style: GoogleFonts.hindVadodara(
              fontSize: 12,
              color: AppColors.textMedium,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: StatusBadge(
            text: status,
            backgroundColor: statusBg,
            textColor: statusColor,
          ),
        ),
        Expanded(
          flex: 4,
          child: Text(
            date,
            textAlign: TextAlign.right,
            style: GoogleFonts.hindVadodara(
              fontSize: 11,
              color: AppColors.textMedium,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildIrrigationCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String count,
    required String unit,
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
          Icon(icon, size: 24, color: iconColor),
          const SizedBox(height: 6),
          Text(
            title,
            textAlign: TextAlign.center,
            maxLines: 2,
            style: GoogleFonts.hindVadodara(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                count,
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                unit,
                style: GoogleFonts.hindVadodara(
                  fontSize: 11,
                  color: AppColors.textLight,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNoteTile({
    required IconData icon,
    required Color iconColor,
    required Color bgColor,
    required String noteText,
    required String dateText,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE5EDE3)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: bgColor,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              noteText,
              style: GoogleFonts.hindVadodara(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.textDark,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            dateText,
            style: GoogleFonts.hindVadodara(
              fontSize: 11,
              color: AppColors.textLight,
            ),
          ),
        ],
      ),
    );
  }
}
