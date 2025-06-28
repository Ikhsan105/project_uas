import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'Stratocloud',
          debugShowCheckedModeBanner: false,
          theme: AppThemes.lightTheme,
          darkTheme: AppThemes.darkTheme,
          themeMode: themeProvider.themeMode,
          home: const SplashScreen(),
          routes: {
            '/login': (context) => const LoginScreen(),
            '/home': (context) => const HomeScreen(),
            '/settings': (context) => const SettingsScreen(),
            '/profile': (context) => const ProfileScreen(),
            '/about': (context) => const AboutScreen(),
            '/note_editor': (context) => const NoteEditorScreen(),
            '/permissions_consent':
                (context) => const PermissionsConsentScreen(),
            '/privacy_policy': (context) => const PrivacyPolicyScreen(),
            '/contact_us': (context) => const ContactUsScreen(),
            '/edit_profile':
                (context) =>
                    const EditProfileScreen(), // Rute baru untuk Edit Profil
          },
        );
      },
    );
  }
}
