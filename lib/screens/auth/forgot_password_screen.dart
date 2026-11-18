import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../navigation/app_routes.dart';
import '../../theme/app_theme.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _controller = TextEditingController();
  bool _isMobileTab = true;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _sendOtp() {
    final identifier = _controller.text.trim();
    if (identifier.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _isMobileTab ? 'મોબાઇલ નંબર દાખલ કરો' : 'ઈમેઈલ ID દાખલ કરો',
          ),
        ),
      );
      return;
    }
    if (_isMobileTab && !RegExp(r'^\d{10}$').hasMatch(identifier)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('માન્ય 10 અંકનો મોબાઇલ નંબર દાખલ કરો')),
      );
      return;
    }
    if (!_isMobileTab &&
        !RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(identifier)) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('માન્ય ઈમેઈલ દાખલ કરો')));
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'પાસવર્ડ રીકવરી સેવા ગોઠવાયેલ નથી; કોઈ OTP મોકલવામાં આવ્યો નથી.',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primary),
          onPressed: () => AppRoutes.replace(context, AppRoutes.login),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Lock Illustration in Circle
              Container(
                width: 150,
                height: 150,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFE8F5E9),
                ),
                child: Center(
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/illus_forgot.png',
                      width: 140,
                      height: 140,
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) => const Icon(
                        Icons.lock_reset,
                        size: 70,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Title & Subtitle
              Text(
                'પાસવર્ડ ભૂલી ગયા છો?',
                style: GoogleFonts.hindVadodara(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'તમારો રજીસ્ટર્ડ મોબાઇલ નંબર અથવા ઈમેઈલ ID દાખલ કરો.',
                textAlign: TextAlign.center,
                style: GoogleFonts.hindVadodara(
                  fontSize: 13,
                  color: AppColors.textLight,
                ),
              ),

              const SizedBox(height: 24),

              // Segmented Tabs: મોબાઇલ દ્વારા | ઈમેઈલ દ્વારા
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _isMobileTab = true;
                          _controller.clear();
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: _isMobileTab
                              ? const Color(0xFFF0FDF4)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: _isMobileTab
                                ? AppColors.primary
                                : const Color(0xFFE2E8F0),
                            width: _isMobileTab ? 1.5 : 1,
                          ),
                        ),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.phone_outlined,
                                size: 18,
                                color: _isMobileTab
                                    ? AppColors.primary
                                    : AppColors.textLight,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'મોબાઇલ દ્વારા',
                                style: GoogleFonts.hindVadodara(
                                  fontSize: 13,
                                  fontWeight: _isMobileTab
                                      ? FontWeight.bold
                                      : FontWeight.w500,
                                  color: _isMobileTab
                                      ? AppColors.primary
                                      : AppColors.textMedium,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _isMobileTab = false;
                          _controller.clear();
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: !_isMobileTab
                              ? const Color(0xFFF0FDF4)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: !_isMobileTab
                                ? AppColors.primary
                                : const Color(0xFFE2E8F0),
                            width: !_isMobileTab ? 1.5 : 1,
                          ),
                        ),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.mail_outline,
                                size: 18,
                                color: !_isMobileTab
                                    ? AppColors.primary
                                    : AppColors.textLight,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'ઈમેઈલ દ્વારા',
                                style: GoogleFonts.hindVadodara(
                                  fontSize: 13,
                                  fontWeight: !_isMobileTab
                                      ? FontWeight.bold
                                      : FontWeight.w500,
                                  color: !_isMobileTab
                                      ? AppColors.primary
                                      : AppColors.textMedium,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Input Field
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  _isMobileTab ? 'મોબાઇલ નંબર *' : 'ઈમેઈલ ID *',
                  style: GoogleFonts.hindVadodara(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textDark,
                  ),
                ),
              ),
              const SizedBox(height: 6),
              TextField(
                controller: _controller,
                keyboardType: _isMobileTab
                    ? TextInputType.phone
                    : TextInputType.emailAddress,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    _isMobileTab ? Icons.phone_outlined : Icons.mail_outline,
                    color: AppColors.primary,
                    size: 20,
                  ),
                  hintText: _isMobileTab
                      ? '10 અંકોનો મોબાઇલ નંબર દાખલ કરો'
                      : 'ઈમેઈલ ID દાખલ કરો',
                ),
              ),

              const SizedBox(height: 20),

              // Recovery provider is intentionally not simulated.
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _sendOtp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1B5E20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'રીકવરી વિકલ્પ તપાસો',
                    style: GoogleFonts.hindVadodara(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Security Info Box
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFFF7FAF6),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFD4EAD0)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.verified_user_outlined,
                      color: AppColors.primary,
                      size: 22,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'સુરક્ષા માહિતી',
                            style: GoogleFonts.hindVadodara(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textDark,
                            ),
                          ),
                          Text(
                            'રીકવરી સેવા જોડાયેલી નથી; કોઈ OTP મોકલવામાં આવશે નહીં.',
                            style: GoogleFonts.hindVadodara(
                              fontSize: 12,
                              color: AppColors.textMedium,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Return to login link
              InkWell(
                onTap: () => AppRoutes.replace(context, AppRoutes.login),
                child: Text(
                  'લૉગિન પેજ પર પાછા જાઓ',
                  style: GoogleFonts.hindVadodara(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
