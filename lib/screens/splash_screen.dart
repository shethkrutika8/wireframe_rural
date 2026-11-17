import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import 'auth/login_screen.dart';
import 'auth/register_screen.dart';
import 'home/home_screen_v1.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FBF8),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Top leaves & decorative bar
                Align(
                  alignment: Alignment.topRight,
                  child: TextButton.icon(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const HomeScreenV1()),
                      );
                    },
                    icon: const Icon(Icons.arrow_forward, size: 16, color: AppColors.primary),
                    label: Text(
                      'હોમ પર જાઓ',
                      style: GoogleFonts.hindVadodara(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                // Main Logo & Brand Box
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(32),
                    border: Border.all(color: const Color(0xFF2E8B4E), width: 1.5),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x0C000000),
                        blurRadius: 16,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // AgriConnect Title with leaf
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Agri',
                            style: GoogleFonts.poppins(
                              fontSize: 34,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF134E28),
                            ),
                          ),
                          const Icon(Icons.eco, color: Color(0xFF4CAF50), size: 30),
                          Text(
                            'connect',
                            style: GoogleFonts.poppins(
                              fontSize: 34,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF2E8B4E),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        '(એગ્રી કનેક્ટ)',
                        style: GoogleFonts.hindVadodara(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF134E28),
                        ),
                      ),
                      const SizedBox(height: 6),
                      // Slogan divider
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 30,
                            height: 1,
                            color: const Color(0xFF81C784),
                          ),
                          const SizedBox(width: 8),
                          const Icon(Icons.eco, size: 14, color: Color(0xFF4CAF50)),
                          const SizedBox(width: 8),
                          Text(
                            'farmer welfare application',
                            style: GoogleFonts.hindVadodara(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF4A5568),
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(Icons.eco, size: 14, color: Color(0xFF4CAF50)),
                          const SizedBox(width: 8),
                          Container(
                            width: 30,
                            height: 1,
                            color: const Color(0xFF81C784),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Center Farmer Portrait Badge from Wireframe
                Container(
                  width: 190,
                  height: 190,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    border: Border.all(color: const Color(0xFF7CB342), width: 3),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x18000000),
                        blurRadius: 18,
                        offset: Offset(0, 6),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(6),
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/farmer_circle_logo.png',
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => const Icon(
                        Icons.person,
                        size: 90,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Landscape background preview
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    'assets/images/illus_landscape_tractor.png',
                    height: 110,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => const SizedBox.shrink(),
                  ),
                ),

                const SizedBox(height: 24),

                // Bottom 5 Feature Icons from Wireframe
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.cardBorder),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildFeatureItem(Icons.eco_outlined, 'Crop\nAdvisory'),
                      _buildFeatureDivider(),
                      _buildFeatureItem(Icons.wb_sunny_outlined, 'Weather\nUpdates'),
                      _buildFeatureDivider(),
                      _buildFeatureItem(Icons.account_balance_outlined, 'Government\nSchemes'),
                      _buildFeatureDivider(),
                      _buildFeatureItem(Icons.trending_up, 'Market\nPrices'),
                      _buildFeatureDivider(),
                      _buildFeatureItem(Icons.headset_mic_outlined, 'Expert\nSupport'),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // Action Buttons (Login / Register)
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const LoginScreen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'લૉગિન કરો',
                          style: GoogleFonts.hindVadodara(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const RegisterScreen()),
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: AppColors.primary, width: 1.5),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'નવું એકાઉન્ટ',
                          style: GoogleFonts.hindVadodara(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureDivider() {
    return Container(
      width: 1,
      height: 36,
      color: const Color(0xFFE2EDE0),
    );
  }

  Widget _buildFeatureItem(IconData icon, String label) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 24, color: AppColors.primary),
          const SizedBox(height: 6),
          Text(
            label,
            textAlign: TextAlign.center,
            style: GoogleFonts.hindVadodara(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: AppColors.textMedium,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}
