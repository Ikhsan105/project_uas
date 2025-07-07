import 'package:flutter/material.dart';
import 'package:project_ambtron/api/auth_service.dart'; // <-- Pastikan path ini benar

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Controller untuk input field, tidak ada perubahan
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // --- PENAMBAHAN ---
  // 1. Buat instance dari AuthService untuk mengakses fungsi login
  final AuthService _authService = AuthService();
  // 2. State untuk menampilkan loading saat tombol ditekan
  bool _isLoading = false;
  // --- AKHIR PENAMBAHAN ---

  // Fungsi SnackBar, tidak ada perubahan
  void _showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // --- PERUBAHAN PADA FUNGSI _login ---
  void _login() async {
    // 3. Jadikan fungsi ini 'async'
    if (_isLoading) return; // Mencegah klik ganda

    // 4. Tampilkan loading indicator
    setState(() {
      _isLoading = true;
    });

    // Ambil input dan hapus spasi yang tidak perlu
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isNotEmpty && password.isNotEmpty) {
      // 5. Panggil fungsi signIn dari service yang akan berinteraksi dengan Supabase
      await _authService.signIn(context, email: email, password: password);
    } else {
      _showSnackBar('Email dan Kata Sandi tidak boleh kosong.', isError: true);
    }

    // 6. Sembunyikan loading indicator setelah selesai
    // Pengecekan 'mounted' adalah praktik yang aman
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }
  // --- AKHIR PERUBAHAN FUNGSI _login ---

  // --- PENAMBAHAN ---
  // Menambahkan dispose untuk membersihkan controller saat halaman ditutup
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  // --- AKHIR PENAMBAHAN ---

  @override
  Widget build(BuildContext context) {
    // Seluruh bagian build widget di bawah ini TIDAK ADA YANG DIUBAH,
    // kecuali pada bagian ElevatedButton
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.cloud_queue_rounded,
                size: 120,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(height: 20),
              Text(
                'Stratocloud',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
              const SizedBox(height: 30),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  hintText: 'Masukkan email Anda',
                  prefixIcon: Icon(Icons.email),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Kata Sandi',
                  hintText: 'Masukkan kata sandi Anda',
                  prefixIcon: Icon(Icons.lock),
                ),
              ),
              const SizedBox(height: 15),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    _showSnackBar(
                      'Fitur lupa kata sandi belum diimplementasikan.',
                    );
                  },
                  child: const Text('Lupa Kata Sandi?'),
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  // Gunakan fungsi _login yang sudah diubah
                  onPressed: _login,
                  // --- PERUBAHAN KECIL PADA TOMBOL ---
                  // 7. Tampilkan loading atau teks 'MASUK'
                  child:
                      _isLoading
                          ? const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          )
                          : const Text('MASUK'),
                  // --- AKHIR PERUBAHAN TOMBOL ---
                ),
              ),
              const SizedBox(height: 20),
              const Text('Atau masuk dengan', style: TextStyle(fontSize: 16)),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      _showSnackBar('Google Sign-In belum diimplementasikan.');
                    },
                    child: CircleAvatar(
                      radius: 25,
                      backgroundColor: Theme.of(context).cardColor,
                      child: Image.network(
                        'https://img.icons8.com/color/48/000000/google-logo.png',
                        width: 30,
                        height: 30,
                        errorBuilder:
                            (context, error, stackTrace) =>
                                const Icon(Icons.g_mobiledata),
                      ),
                    ),
                  ),
                  const SizedBox(width: 30),
                  GestureDetector(
                    onTap: () {
                      _showSnackBar('Apple Sign-In belum diimplementasikan.');
                    },
                    child: CircleAvatar(
                      radius: 25,
                      backgroundColor: Theme.of(context).cardColor,
                      child: Icon(
                        Icons.apple,
                        size: 30,
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Belum punya akun?'),
                  TextButton(
                    onPressed: () {
                      _showSnackBar(
                        'Fitur pendaftaran belum diimplementasikan.',
                      );
                    },
                    child: const Text('Daftar Sekarang'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
