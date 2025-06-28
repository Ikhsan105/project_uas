import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    print('SplashScreen: initState dipanggil.'); // Debug print
    // Setelah 3 detik, navigasi ke layar LoginScreen
    Future.delayed(const Duration(seconds: 3), () {
      print(
        'SplashScreen: Future.delayed selesai, mencoba navigasi.',
      ); // Debug print
      // Pastikan '/login' adalah nama rute yang benar dan terdaftar di main.dart
      Navigator.pushReplacementNamed(context, '/login');
      print('SplashScreen: Navigasi ke /login dipanggil.'); // Debug print
    });
  }

  @override
  Widget build(BuildContext context) {
    print('SplashScreen: build dipanggil.'); // Debug print
    return Scaffold(
      backgroundColor:
          Theme.of(
            context,
          ).primaryColor, // Menggunakan warna primer tema sebagai latar belakang
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.cloud_queue_rounded, // Ikon cloud untuk logo
              size: 150, // Ukuran ikon yang lebih besar
              color:
                  Colors
                      .white, // Warna ikon putih agar kontras dengan latar belakang
            ),
            const SizedBox(height: 20),
            Text(
              'Stratocloud',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.white, // Warna teks putih
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Penyimpanan Cerdas Anda', // Tagline
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
