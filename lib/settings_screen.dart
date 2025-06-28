import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme_provider.dart';

// Import ThemeProvider
import 'theme_provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // Dummy state untuk bahasa yang dipilih.
  // Dalam implementasi nyata, ini akan disimpan secara persisten
  // dan diakses oleh semua bagian aplikasi.
  String _selectedLanguage = 'Indonesia'; // Default language

  void _changeLanguage(String language) {
    setState(() {
      _selectedLanguage = language;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Bahasa diatur ke: $language')));
      // Di sini, dalam aplikasi nyata, Anda akan memuat resource bahasa baru
      // dan mungkin memicu rebuild seluruh aplikasi jika diperlukan.
    });
  }

  @override
  Widget build(BuildContext context) {
    // Mendapatkan ThemeProvider dari konteks
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Pengaturan')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Material(
            // Membungkus dengan Material untuk elevation
            elevation: 4,
            borderRadius: BorderRadius.circular(16),
            color: Theme.of(context).cardColor,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Align(
                    // Menggunakan Align untuk memastikan teks rata kiri
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Tampilan',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const Divider(height: 0, indent: 16, endIndent: 16),
                ListTile(
                  title: const Text('Mode Gelap'),
                  trailing: Switch(
                    value:
                        themeProvider.themeMode ==
                        ThemeMode.dark, // Cek apakah tema saat ini gelap
                    onChanged: (bool value) {
                      themeProvider.toggleTheme(); // Panggil fungsi toggleTheme
                    },
                    activeColor: Theme.of(context).primaryColor,
                  ),
                  leading: const Icon(Icons.dark_mode_outlined),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Bagian Pengaturan Bahasa
          Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(16),
            color: Theme.of(context).cardColor,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Bahasa',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const Divider(height: 0, indent: 16, endIndent: 16),
                _buildLanguageTile(
                  'Indonesia',
                  'Indonesia',
                  _selectedLanguage,
                  _changeLanguage,
                ),
                const Divider(indent: 16, endIndent: 16, height: 0),
                _buildLanguageTile(
                  'English',
                  'Inggris',
                  _selectedLanguage,
                  _changeLanguage,
                ),
                const Divider(indent: 16, endIndent: 16, height: 0),
                _buildLanguageTile(
                  '简体中文',
                  'China (Sederhana)',
                  _selectedLanguage,
                  _changeLanguage,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          Material(
            // Membungkus dengan Material untuk elevation
            elevation: 4,
            borderRadius: BorderRadius.circular(16),
            color: Theme.of(context).cardColor,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Align(
                    // Menggunakan Align untuk memastikan teks rata kiri
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Akun',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const Divider(height: 0, indent: 16, endIndent: 16),
                ListTile(
                  leading: const Icon(Icons.lock_outline),
                  title: const Text('Ubah Kata Sandi'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Fitur ubah kata sandi belum diimplementasikan.',
                        ),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.storage_outlined),
                  title: const Text('Manajemen Penyimpanan'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Manajemen penyimpanan belum diimplementasikan.',
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Material(
            // Membungkus dengan Material untuk elevation
            elevation: 4,
            borderRadius: BorderRadius.circular(16),
            color: Theme.of(context).cardColor,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Align(
                    // Menggunakan Align untuk memastikan teks rata kiri
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Lain-lain',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const Divider(height: 0, indent: 16, endIndent: 16),
                ListTile(
                  leading: const Icon(Icons.info_outline),
                  title: const Text('Tentang Aplikasi'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    Navigator.pushNamed(context, '/about');
                  },
                ),
                // Mengubah onTap untuk menavigasi ke PrivacyPolicyScreen
                ListTile(
                  leading: const Icon(Icons.privacy_tip_outlined),
                  title: const Text('Kebijakan Privasi'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/privacy_policy',
                    ); // Navigasi ke rute baru
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper widget untuk membuat tile pilihan bahasa
  Widget _buildLanguageTile(
    String displayLanguage,
    String value,
    String selectedValue,
    Function(String) onChanged,
  ) {
    return ListTile(
      title: Text(displayLanguage),
      trailing:
          selectedValue == value
              ? Icon(Icons.check_circle, color: Theme.of(context).primaryColor)
              : null,
      onTap: () => onChanged(value),
    );
  }
}
