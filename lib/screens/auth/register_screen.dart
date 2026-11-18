import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../navigation/app_routes.dart';
import '../../services/app_store.dart';
import '../../theme/app_theme.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _mobileController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _agreeTerms = false;
  bool _isLoading = false;

  String? _selectedDistrict = 'રાજકોટ';
  String? _selectedTaluka = 'રાજકોટ ગ્રામ્ય';
  String? _selectedLanguage = 'ગુજરાતી';

  final List<String> _districts = [
    'રાજકોટ',
    'અમદાવાદ',
    'જૂનાગઢ',
    'જામનગર',
    'ભાવનગર',
    'અમરેલી',
    'વડોદરા',
    'સુરત',
  ];
  final List<String> _talukas = [
    'રાજકોટ ગ્રામ્ય',
    'ગોંડલ',
    'જેતપુર',
    'ધોરાજી',
    'ઉપલેટા',
    'કોટડા સાંગાણી',
    'લોધિકા',
  ];
  final List<String> _languages = ['ગુજરાતી', 'English', 'हिन्दी'];

  @override
  void dispose() {
    _nameController.dispose();
    _mobileController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleRegister() async {
    if (!_agreeTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('કૃપા કરીને નિયમો અને શરતો સ્વીકારો')),
      );
      return;
    }

    if (!(_formKey.currentState?.validate() ?? false)) return;
    setState(() => _isLoading = true);
    try {
      await AppStore.instance.register(
        name: _nameController.text,
        mobile: _mobileController.text,
        email: _emailController.text,
        password: _passwordController.text,
        district: _selectedDistrict ?? '',
        taluka: _selectedTaluka ?? '',
        language: _selectedLanguage ?? 'ગુજરાતી',
      );
      if (mounted) AppRoutes.replaceAll(context, AppRoutes.homeV1);
    } on AppStoreException catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(error.message)));
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
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
        title: FittedBox(
          fit: BoxFit.scaleDown,
          child: Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.eco, color: Color(0xFF4CAF50), size: 18),
                  const SizedBox(width: 4),
                  Text(
                    'AgriConnect',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF16542A),
                    ),
                  ),
                ],
              ),
              Text(
                'ખેડૂતનો સાથી, ખેતીમાં પ્રગતિ સાથે',
                style: GoogleFonts.hindVadodara(
                  fontSize: 10,
                  color: AppColors.textMedium,
                ),
              ),
            ],
          ),
        ),
        centerTitle: true,
        actions: const [SizedBox(width: 48)],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Row: Registration Title + Farmer Artwork
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 6,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 12),
                          Text(
                            'રજીસ્ટ્રેશન કરો',
                            style: GoogleFonts.hindVadodara(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textDark,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'નવું એકાઉન્ટ બનાવો અને\nAgriConnect સાથે જોડાઓ.',
                            style: GoogleFonts.hindVadodara(
                              fontSize: 13,
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
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          'assets/images/illus_register.png',
                          height: 90,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(
                                Icons.person_pin,
                                size: 70,
                                color: AppColors.primary,
                              ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // 3 Step Indicator
                _buildStepIndicator(),

                const SizedBox(height: 20),

                // Full Name
                _buildFieldLabel('પૂર્ણ નામ *'),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Icons.person_outline,
                      color: AppColors.primary,
                      size: 20,
                    ),
                    hintText: 'તમારું પૂરું નામ દાખલ કરો',
                  ),
                  validator: (v) =>
                      (v == null || v.isEmpty) ? 'પૂરું નામ દાખલ કરો' : null,
                ),

                const SizedBox(height: 14),

                // Mobile Number
                _buildFieldLabel('મોબાઇલ નંબર *'),
                TextFormField(
                  controller: _mobileController,
                  keyboardType: TextInputType.phone,
                  maxLength: 10,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Icons.phone_outlined,
                      color: AppColors.primary,
                      size: 20,
                    ),
                    hintText: '10 અંકોનો મોબાઇલ નંબર',
                    counterText: '',
                  ),
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) {
                      return 'મોબાઇલ નંબર દાખલ કરો';
                    }
                    if (!RegExp(r'^\d{10}$').hasMatch(v.trim())) {
                      return 'માન્ય 10 અંકનો નંબર દાખલ કરો';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 14),

                // Email (Optional)
                _buildFieldLabel('ઈમેઈલ (વૈકલ્પિક)'),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Icons.mail_outline,
                      color: AppColors.primary,
                      size: 20,
                    ),
                    hintText: 'ઈમેઈલ ID દાખલ કરો',
                  ),
                  validator: (value) {
                    final email = value?.trim() ?? '';
                    if (email.isNotEmpty &&
                        !RegExp(
                          r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
                        ).hasMatch(email)) {
                      return 'માન્ય ઈમેઈલ દાખલ કરો';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 14),

                // Password
                _buildFieldLabel('પાસવર્ડ *'),
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.lock_outline,
                      color: AppColors.primary,
                      size: 20,
                    ),
                    hintText: 'પાસવર્ડ બનાવો',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: AppColors.textLight,
                        size: 20,
                      ),
                      onPressed: () =>
                          setState(() => _obscurePassword = !_obscurePassword),
                    ),
                  ),
                  validator: (v) => (v == null || v.length < 8)
                      ? 'ઓછામાં ઓછા 8 અક્ષર દાખલ કરો'
                      : null,
                ),

                const SizedBox(height: 14),

                // Confirm Password
                _buildFieldLabel('પાસવર્ડ ફરી દાખલ કરો *'),
                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: _obscureConfirmPassword,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.lock_outline,
                      color: AppColors.primary,
                      size: 20,
                    ),
                    hintText: 'પાસવર્ડ ફરી દાખલ કરો',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureConfirmPassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: AppColors.textLight,
                        size: 20,
                      ),
                      onPressed: () => setState(
                        () =>
                            _obscureConfirmPassword = !_obscureConfirmPassword,
                      ),
                    ),
                  ),
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'પાસવર્ડ ફરી દાખલ કરો';
                    if (v != _passwordController.text) {
                      return 'બંને પાસવર્ડ મેળ ખાતા નથી';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 14),

                // District and Taluka Dropdowns in a Row
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildFieldLabel('જિલ્લો *'),
                          DropdownButtonFormField<String>(
                            initialValue: _selectedDistrict,
                            isExpanded: true,
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 12,
                              ),
                            ),
                            items: _districts
                                .map(
                                  (d) => DropdownMenuItem(
                                    value: d,
                                    child: Text(
                                      d,
                                      style: GoogleFonts.hindVadodara(
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                            onChanged: (v) =>
                                setState(() => _selectedDistrict = v),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildFieldLabel('તાલુકો *'),
                          DropdownButtonFormField<String>(
                            initialValue: _selectedTaluka,
                            isExpanded: true,
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 12,
                              ),
                            ),
                            items: _talukas
                                .map(
                                  (t) => DropdownMenuItem(
                                    value: t,
                                    child: Text(
                                      t,
                                      style: GoogleFonts.hindVadodara(
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                            onChanged: (v) =>
                                setState(() => _selectedTaluka = v),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 14),

                // Language Dropdown
                _buildFieldLabel('ભાષા પસંદ કરો *'),
                DropdownButtonFormField<String>(
                  initialValue: _selectedLanguage,
                  isExpanded: true,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Icons.translate,
                      color: AppColors.primary,
                      size: 20,
                    ),
                  ),
                  items: _languages
                      .map(
                        (l) => DropdownMenuItem(
                          value: l,
                          child: Text(
                            l,
                            style: GoogleFonts.hindVadodara(fontSize: 14),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (v) => setState(() => _selectedLanguage = v),
                ),

                const SizedBox(height: 16),

                // Terms Checkbox
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 24,
                      width: 24,
                      child: Checkbox(
                        value: _agreeTerms,
                        activeColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        onChanged: (v) =>
                            setState(() => _agreeTerms = v ?? false),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'હું AgriConnect ના નિયમો અને શરતો સાથે સંમત છું.',
                        style: GoogleFonts.hindVadodara(
                          fontSize: 12,
                          color: AppColors.textMedium,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Submit Button: આગળ વધો ->
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _handleRegister,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1B5E20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            width: 22,
                            height: 22,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'આગળ વધો',
                                style: GoogleFonts.hindVadodara(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                                size: 18,
                              ),
                            ],
                          ),
                  ),
                ),

                const SizedBox(height: 20),

                // Bottom Login Link
                Center(
                  child: InkWell(
                    onTap: () => AppRoutes.replace(context, AppRoutes.login),
                    child: RichText(
                      text: TextSpan(
                        text: 'પહેલાથી ખાતું છે? ',
                        style: GoogleFonts.hindVadodara(
                          fontSize: 13,
                          color: AppColors.textMedium,
                        ),
                        children: [
                          TextSpan(
                            text: 'અહીં લૉગિન કરો',
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
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStepIndicator() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF7FAF6),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE5EDE3)),
      ),
      child: Row(
        children: [
          SizedBox(width: 68, child: _buildStepItem(1, 'મૂળ માહિતી', true)),
          _buildStepLine(),
          SizedBox(width: 68, child: _buildStepItem(2, 'ખેતર', false)),
          _buildStepLine(),
          SizedBox(width: 68, child: _buildStepItem(3, 'ચકાસણી', false)),
        ],
      ),
    );
  }

  Widget _buildStepItem(int stepNumber, String title, bool isActive) {
    return Column(
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive ? AppColors.primary : Colors.white,
            border: Border.all(
              color: isActive ? AppColors.primary : const Color(0xFFCBD5E1),
              width: 1.5,
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            '$stepNumber',
            style: GoogleFonts.hindVadodara(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: isActive ? Colors.white : AppColors.textLight,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.hindVadodara(
            fontSize: 11,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            color: isActive ? AppColors.primary : AppColors.textLight,
          ),
        ),
      ],
    );
  }

  Widget _buildStepLine() {
    return Expanded(
      child: Container(
        height: 1,
        color: const Color(0xFFCBD5E1),
        margin: const EdgeInsets.only(bottom: 18),
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
