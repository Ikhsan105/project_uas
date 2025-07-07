// lib/router/app_router.dart

import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:project_ambtron/home_screen.dart';
import 'package:project_ambtron/login_screen.dart';
import 'package:project_ambtron/note_editor_screen.dart';
import 'package:project_ambtron/profile_screen.dart';
import 'package:project_ambtron/photos_screen.dart';
import 'package:project_ambtron/splash_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:project_ambtron/about_screen.dart';
import 'package:project_ambtron/contact_us_screen.dart';
import 'package:project_ambtron/settings_screen.dart';
import 'package:project_ambtron/edit_profile_screen.dart';
import 'package:project_ambtron/photo_view_screen.dart';
import 'package:project_ambtron/note_detail_screen.dart';
import 'package:project_ambtron/privacy_policy_screen.dart';

// --- TAMBAHKAN IMPORT UNTUK HALAMAN DAFTAR KONTEN ---
import 'package:project_ambtron/typed_content_list_screen.dart';


class AppRouter {
  static final router = GoRouter(
    refreshListenable: GoRouterRefreshStream(
      Supabase.instance.client.auth.onAuthStateChange,
    ),
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
      GoRoute(
        path: '/note-editor',
        builder: (context, state) => const NoteEditorScreen(),
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: '/photos',
        builder: (context, state) => const PhotosScreen(),
      ),
      GoRoute(
        path: '/about',
        name: 'about',
        builder: (context, state) => const AboutScreen(),
      ),
      GoRoute(
        path: '/contact-us',
        name: 'contact-us',
        builder: (context, state) => const ContactUsScreen(),
      ),
      GoRoute(
        path: '/settings',
        name: 'settings',
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: '/edit-profile',
        builder: (context, state) => const EditProfileScreen(),
      ),
      GoRoute(
        path: '/privacy-policy',
        name: 'privacy-policy',
        builder: (context, state) => const PrivacyPolicyScreen(),
      ),
      GoRoute(
        path: '/photo-view',
        name: 'photo-view',
        builder: (context, state) {
          final imageUrl = state.extra as String;
          return PhotoViewScreen(imageUrl: imageUrl);
        },
      ),
      GoRoute(
        path: '/note-detail',
        name: 'note-detail',
        builder: (context, state) {
          final note = state.extra as Map<String, dynamic>;
          return NoteDetailScreen(note: note);
        },
      ),
      
      // --- RUTE BARU UNTUK HALAMAN DAFTAR KONTEN BERDASARKAN TIPE ---
      GoRoute(
        path: '/typed-content',
        name: 'typed-content',
        builder: (context, state) {
          // Ambil argumen yang dikirim dari halaman profil
          final args = state.extra as Map<String, String>;
          final contentType = args['contentType']!;
          final appBarTitle = args['appBarTitle']!;
          
          return TypedContentListScreen(
            contentType: contentType,
            appBarTitle: appBarTitle,
          );
        },
      ),
    ],
    redirect: (context, state) {
      final loggedIn = Supabase.instance.client.auth.currentSession != null;
      final loggingIn = state.matchedLocation == '/login';
      if (!loggedIn) return loggingIn ? null : '/login';
      if (loggingIn) return '/home';
      return null;
    },
  );
}

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    stream.asBroadcastStream().listen((_) => notifyListeners());
  }
}