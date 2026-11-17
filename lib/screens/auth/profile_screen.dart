import 'package:flutter/material.dart';

import '../../navigation/app_routes.dart';
import '../../services/app_store.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_bottom_nav.dart';
import '../../widgets/app_drawer.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Future<void> _editProfile(BuildContext context, FarmerAccount account) async {
    final name = TextEditingController(text: account.name);
    final mobile = TextEditingController(text: account.mobile);
    final email = TextEditingController(text: account.email);
    final district = TextEditingController(text: account.district);
    final taluka = TextEditingController(text: account.taluka);
    final formKey = GlobalKey<FormState>();
    var language = account.language;

    final saved = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('પ્રોફાઇલ સંપાદિત કરો'),
          content: SizedBox(
            width: 420,
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _profileField(name, 'પૂરું નામ', required: true),
                    _profileField(mobile, 'મોબાઇલ નંબર',
                        required: true, keyboardType: TextInputType.phone),
                    _profileField(email, 'ઈમેઈલ',
                        keyboardType: TextInputType.emailAddress),
                    _profileField(district, 'જિલ્લો'),
                    _profileField(taluka, 'તાલુકો'),
                    DropdownButtonFormField<String>(
                      initialValue: language,
                      decoration: const InputDecoration(labelText: 'ભાષા'),
                      items: const [
                        DropdownMenuItem(value: 'ગુજરાતી', child: Text('ગુજરાતી')),
                        DropdownMenuItem(value: 'English', child: Text('English')),
                        DropdownMenuItem(value: 'हिन्दी', child: Text('हिन्दी')),
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          setDialogState(() => language = value);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: const Text('રદ કરો'),
            ),
            FilledButton(
              onPressed: () {
                if (formKey.currentState?.validate() ?? false) {
                  Navigator.pop(dialogContext, true);
                }
              },
              child: const Text('સાચવો'),
            ),
          ],
        ),
      ),
    );

    if (saved == true) {
      try {
        await AppStore.instance.updateProfile(
          name: name.text,
          mobile: mobile.text,
          email: email.text,
          district: district.text,
          taluka: taluka.text,
          language: language,
        );
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('પ્રોફાઇલ સાચવાઈ ગઈ.')),
          );
        }
      } on AppStoreException catch (error) {
        if (context.mounted) _showError(context, error.message);
      }
    }

    name.dispose();
    mobile.dispose();
    email.dispose();
    district.dispose();
    taluka.dispose();
  }

  Widget _profileField(
    TextEditingController controller,
    String label, {
    bool required = false,
    TextInputType? keyboardType,
  }) =>
      Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(labelText: label),
          validator: required
              ? (value) =>
                  value == null || value.trim().isEmpty ? 'આ માહિતી જરૂરી છે' : null
              : null,
        ),
      );

  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
        animation: AppStore.instance,
        builder: (context, _) {
          final account = AppStore.instance.currentAccount;
          if (account == null) {
            return const Scaffold(body: Center(child: CircularProgressIndicator()));
          }
          return Scaffold(
            drawer: const AppDrawer(activeRoute: AppRoutes.profile),
            appBar: AppBar(
              title: const Text('મારી પ્રોફાઇલ'),
              actions: [
                IconButton(
                  tooltip: 'પ્રોફાઇલ સંપાદિત કરો',
                  onPressed: () => _editProfile(context, account),
                  icon: const Icon(Icons.edit_outlined),
                ),
              ],
            ),
            body: SafeArea(
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  Center(
                    child: CircleAvatar(
                      radius: 42,
                      backgroundColor: AppColors.primarySurface,
                      child: Text(
                        account.name.isEmpty ? '?' : account.name.characters.first,
                        style: const TextStyle(
                          color: AppColors.primary,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Center(
                    child: Text(
                      account.name,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _detailTile(Icons.phone_outlined, 'મોબાઇલ', account.mobile),
                  _detailTile(
                    Icons.email_outlined,
                    'ઈમેઈલ',
                    account.email.isEmpty ? 'ઉમેરેલ નથી' : account.email,
                  ),
                  _detailTile(Icons.location_city_outlined, 'જિલ્લો', account.district),
                  _detailTile(Icons.map_outlined, 'તાલુકો', account.taluka),
                  _detailTile(Icons.language_outlined, 'ભાષા', account.language),
                  const SizedBox(height: 12),
                  OutlinedButton.icon(
                    onPressed: () => AppRoutes.open(context, AppRoutes.settings),
                    icon: const Icon(Icons.settings_outlined),
                    label: const Text('સેટિંગ્સ ખોલો'),
                  ),
                ],
              ),
            ),
            bottomNavigationBar: AppBottomNav(
              currentIndex: 4,
              onTap: (index) => AppRoutes.selectBottomNavigation(context, index),
            ),
          );
        },
      );

  Widget _detailTile(IconData icon, String title, String value) => Card(
        child: ListTile(
          leading: Icon(icon, color: AppColors.primary),
          title: Text(title),
          subtitle: Text(value.isEmpty ? 'ઉમેરેલ નથી' : value),
        ),
      );
}
