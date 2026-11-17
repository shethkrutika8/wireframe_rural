import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_drawer.dart';
import '../home/home_screen_v1.dart';
import 'register_screen.dart';
import 'forgot_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _identifierController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _identifierController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() => _isLoading = true);
      Future.delayed(const Duration(milliseconds: 600), () {
        if (!mounted) return;
        setState(() => _isLoading = false);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomeScreenV1()),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: const AppDrawer(activeRoute: 'login'),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Top Bar with Drawer & Brand
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    Builder(
                      builder: (ctx) => IconButton(
                        icon: const Icon(Icons.menu, color: AppColors.textDark),
                        onPressed: () => Scaffold.of(ctx).openDrawer(),
                      ),
                    ),
                    const Spacer(),
                    Column(
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.eco, color: Color(0xFF4CAF50), size: 20),
                            const SizedBox(width: 4),
                            Text(
                              'AgriConnect',
                              style: GoogleFonts.poppins(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF16542A),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          'ખેડૂતનો સાથી, ખેતીમાં પ્રગતિ સાથે',
                          style: GoogleFonts.hindVadodara(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textMedium,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    const SizedBox(width: 48), // balance drawer icon
                  ],
                ),
              ),

              const SizedBox(height: 6),

              // Farmhouse & Windmill landscape illustration
              Container(
                height: 160,
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    'assets/images/illus_login.png',
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Image.asset(
                      'assets/images/illus_landscape_tractor.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),

              // Login Form Card
              Container(
                padding: const EdgeInsets.fromLTRB(24, 20, 24, 28),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'લૉગિન કરો',
                        style: GoogleFonts.hindVadodara(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textDark,
                        ),
                      ),
                      Text(
                        'તમારા ખાતામાં લૉગિન કરો',
                        style: GoogleFonts.hindVadodara(
                          fontSize: 14,
                          color: AppColors.textLight,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Identifier field
                      _buildFieldLabel('મોબાઇલ નંબર અથવા ઈમેઇલ ID *'),
                      TextFormField(
                        controller: _identifierController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.person_outline, color: AppColors.primary, size: 20),
                          hintText: 'મોબાઇલ નંબર અથવા ઈમેઇલ ID દાખલ કરો',
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'કૃપા કરીને મોબાઇલ નંબર અથવા ઈમેઇલ દાખલ કરો';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 16),

                      // Password field
                      _buildFieldLabel('પાસવર્ડ *'),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock_outline, color: AppColors.primary, size: 20),
                          hintText: 'પાસવર્ડ દાખલ કરો',
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                              color: AppColors.textLight,
                              size: 20,
                            ),
                            onPressed: () {
                              setState(() => _obscurePassword = !_obscurePassword);
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'કૃપા કરીને પાસવર્ડ દાખલ કરો';
                          }
                          return null;
                        },
                      ),

                      // Forgot password link
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => const ForgotPasswordScreen()),
                            );
                          },
                          child: Text(
                            'પાસવર્ડ ભૂલી ગયા છો?',
                            style: GoogleFonts.hindVadodara(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 8),

                      // Login Button
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _handleLogin,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1B5E20),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: _isLoading
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                                )
                              : Text(
                                  'લૉગિન કરો',
                                  style: GoogleFonts.hindVadodara(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                      ),

                      const SizedBox(height: 18),

                      // "અથવા" Divider
                      Row(
                        children: [
                          const Expanded(child: Divider(color: Color(0xFFE2EDE0))),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Text(
                              'અથવા',
                              style: GoogleFonts.hindVadodara(
                                fontSize: 13,
                                color: AppColors.textLight,
                              ),
                            ),
                          ),
                          const Expanded(child: Divider(color: Color(0xFFE2EDE0))),
                        ],
                      ),

                      const SizedBox(height: 18),

                      // Google Login Button
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: OutlinedButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Google સાથે લૉગિન સફળ રહ્યું!')),
                            );
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (_) => const HomeScreenV1()),
                            );
                          },
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Color(0xFFD0D7DE)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            backgroundColor: Colors.white,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.network(
                                'https://fonts.gstatic.com/s/i/productlogos/googleg/v6/24px.svg',
                                width: 20,
                                height: 20,
                                errorBuilder: (_, __, ___) => const Icon(Icons.g_mobiledata, color: Colors.blue, size: 26),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                'Google સાથે લૉગિન કરો',
                                style: GoogleFonts.hindVadodara(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textDark,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Registration Link
                      Center(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => const RegisterScreen()),
                            );
                          },
                          child: RichText(
                            text: TextSpan(
                              text: 'નવું ખાતું બનાવવું છે? ',
                              style: GoogleFonts.hindVadodara(
                                fontSize: 13,
                                color: AppColors.textMedium,
                              ),
                              children: [
                                TextSpan(
                                  text: 'અહીં રજીસ્ટ્રેશન કરો',
                                  style: GoogleFonts.hindVadodara(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFieldLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        label,
        style: GoogleFonts.hindVadodara(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: AppColors.textDark,
        ),
      ),
    );
  }
}
