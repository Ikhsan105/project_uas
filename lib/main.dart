import 'package:flutter/material.dart';
import 'package:project_ambtron/router/app_router.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:project_ambtron/utils/constants.dart';
import 'package:project_ambtron/theme_provider.dart';

// Import Theme/Utils
import 'theme_provider.dart';
import 'app_themes.dart';

// Import Screens
import 'profile_screen.dart';
import 'home_screen.dart';
import 'about_screen.dart';
import 'notes_screen.dart';
import 'note_editor_screen.dart';
import 'photos_screen.dart';
import 'profile_screen.dart';
import 'settings_screen.dart';
import 'login_screen.dart';
import 'search_screen.dart';
import 'splash_screen.dart';
import 'permissions_consent_screen.dart';
import 'typed_content_list_screen.dart';
import 'privacy_policy_screen.dart';
import 'contact_us_screen.dart';
import 'edit_profile_screen.dart';

void main() async {
  // Pastikan semua binding siap sebelum menjalankan aplikasi
  WidgetsFlutterBinding.ensureInitialized();

  // Inisialisasi Supabase menggunakan URL dan Key dari file constants.dart
  await Supabase.initialize(
    url: supabaseUrl, // <-- Mengambil nilai dari constants.dart
    anonKey: supabaseAnonKey,
  );

  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

// Buat variabel global agar mudah diakses di mana saja, terutama di router
final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Ganti MaterialApp biasa menjadi MaterialApp.router
    return MaterialApp.router(
      title: 'Stratocloud',
      debugShowCheckedModeBanner: false,
      // Tema masih sama seperti sebelumnya
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      themeMode: Provider.of<ThemeProvider>(context).themeMode,
      // Beritahu MaterialApp untuk menggunakan konfigurasi dari router kita
      routerConfig: AppRouter.router,
    );
  }
}
