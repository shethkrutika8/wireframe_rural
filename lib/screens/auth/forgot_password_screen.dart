import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_theme.dart';
import 'login_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _controller = TextEditingController();
  bool _isMobileTab = true;
  bool _otpSent = false;
  final _otpController = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    _otpController.dispose();
    super.dispose();
  }

  void _sendOtp() {
    if (_controller.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(_isMobileTab ? 'મોબાઇલ નંબર દાખલ કરો' : 'ઈમેઈલ ID દાખલ કરો')),
      );
      return;
    }

    setState(() => _otpSent = true);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('OTP સફળતાપૂર્વક મોકલવામાં આવ્યો છે!')),
    );
  }

  void _verifyOtp() {
    if (_otpController.text.trim().length < 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('કૃપા કરીને 4 અંકનો OTP દાખલ કરો')),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'ચકાસણી સફળ!',
          style: GoogleFonts.hindVadodara(fontWeight: FontWeight.bold, color: AppColors.primary),
        ),
        content: Text(
          'તમારો OTP માન્ય રહ્યો છે. હવે તમે નવો પાસવર્ડ બનાવી શકો છો.',
          style: GoogleFonts.hindVadodara(),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
              );
            },
            child: const Text('લૉગિન પર જાઓ'),
          ),
        ],
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
          onPressed: () => Navigator.pop(context),
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
                      errorBuilder: (_, __, ___) => const Icon(
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
                          color: _isMobileTab ? const Color(0xFFF0FDF4) : Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: _isMobileTab ? AppColors.primary : const Color(0xFFE2E8F0),
                            width: _isMobileTab ? 1.5 : 1,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.phone_outlined,
                              size: 18,
                              color: _isMobileTab ? AppColors.primary : AppColors.textLight,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'મોબાઇલ દ્વારા',
                              style: GoogleFonts.hindVadodara(
                                fontSize: 13,
                                fontWeight: _isMobileTab ? FontWeight.bold : FontWeight.w500,
                                color: _isMobileTab ? AppColors.primary : AppColors.textMedium,
                              ),
                            ),
                          ],
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
                          color: !_isMobileTab ? const Color(0xFFF0FDF4) : Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: !_isMobileTab ? AppColors.primary : const Color(0xFFE2E8F0),
                            width: !_isMobileTab ? 1.5 : 1,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.mail_outline,
                              size: 18,
                              color: !_isMobileTab ? AppColors.primary : AppColors.textLight,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'ઈમેઈલ દ્વારા',
                              style: GoogleFonts.hindVadodara(
                                fontSize: 13,
                                fontWeight: !_isMobileTab ? FontWeight.bold : FontWeight.w500,
                                color: !_isMobileTab ? AppColors.primary : AppColors.textMedium,
                              ),
                            ),
                          ],
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
                keyboardType: _isMobileTab ? TextInputType.phone : TextInputType.emailAddress,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    _isMobileTab ? Icons.phone_outlined : Icons.mail_outline,
                    color: AppColors.primary,
                    size: 20,
                  ),
                  hintText: _isMobileTab ? '10 અંકોનો મોબાઇલ નંબર દાખલ કરો' : 'ઈમેઈલ ID દાખલ કરો',
                ),
              ),

              // OTP field if sent
              if (_otpSent) ...[
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'OTP દાખલ કરો *',
                    style: GoogleFonts.hindVadodara(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textDark,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                TextField(
                  controller: _otpController,
                  keyboardType: TextInputType.number,
                  maxLength: 6,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.pin, color: AppColors.primary, size: 20),
                    hintText: '4 અથવા 6 અંકનો OTP દાખલ કરો',
                  ),
                ),
              ],

              const SizedBox(height: 20),

              // Action Button (OTP મોકલો / OTP ચકાસો)
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _otpSent ? _verifyOtp : _sendOtp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1B5E20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    _otpSent ? 'OTP ચકાસો અને આગળ વધો' : 'OTP મોકલો',
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
                    const Icon(Icons.verified_user_outlined, color: AppColors.primary, size: 22),
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
                            'તમારો OTP માત્ર થોડી ક્ષણો માટે માન્ય રહેશે.',
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
                onTap: () => Navigator.pop(context),
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
