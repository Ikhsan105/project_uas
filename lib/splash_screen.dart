// lib/splash_screen.dart

import 'dart:async'; // Import Timer
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; // Import GoRouter

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Pindah ke halaman login setelah 3 detik
    Timer(const Duration(seconds: 3), () {
      // Pengecekan 'mounted' untuk memastikan widget masih ada di tree
      if (mounted) {
        // Gunakan GoRouter untuk navigasi ke halaman login
        context.go('/login');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Tampilan UI tidak perlu diubah
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.cloud_queue_rounded,
              size: 150,
              color: Colors.white,
            ),
            const SizedBox(height: 20),
            const Text(
              'Stratocloud',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Penyimpanan Cerdas Anda',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white.withOpacity(0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}