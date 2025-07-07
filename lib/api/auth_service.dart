// lib/api/auth_service.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final _supabase = Supabase.instance.client;

  // --- FUNGSI UNTUK LOGIN ---
  Future<void> signIn(
    BuildContext context, {
    required String email,
    required String password,
  }) async {
    try {
      // Kirim permintaan login ke Supabase
      final response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      // Jika tidak ada error dan user ditemukan, arahkan ke halaman home
      if (response.user != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login Berhasil!'),
            backgroundColor: Colors.green,
          ),
        );
        // Gunakan go_router untuk navigasi
        context.go('/home');
      }
    } on AuthException catch (e) {
      // Jika Supabase memberikan error (misal: password salah), tampilkan pesannya
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message), backgroundColor: Colors.red),
      );
    }
  }

  // --- FUNGSI UNTUK LOGOUT ---
  Future<void> signOut(BuildContext context) async {
    await _supabase.auth.signOut();
    // Setelah logout, paksa kembali ke halaman login
    context.go('/login');
  }

  // Kamu bisa menambahkan fungsi untuk register (signUp) di sini nanti
  // Future<void> signUp(...) async { ... }
}
