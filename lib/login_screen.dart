import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Fungsi untuk menampilkan SnackBar (pengganti alert)
  void _showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _login() {
    final email = _emailController.text;
    final password = _passwordController.text;

    // Logika login sederhana (tanpa backend)
    if (email.isNotEmpty && password.isNotEmpty) {
      _showSnackBar('Login berhasil! Selamat datang, $email');
      Navigator.pushReplacementNamed(
        context,
        '/home',
      ); // Navigasi ke HomeScreen
    } else {
      _showSnackBar('Email dan Kata Sandi tidak boleh kosong.', isError: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo Aplikasi (contoh: ikon cloud)
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
                  onPressed: _login,
                  child: const Text('MASUK'),
                ),
              ),
              const SizedBox(height: 20),
              const Text('Atau masuk dengan', style: TextStyle(fontSize: 16)),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Tombol Google Sign-In
                  GestureDetector(
                    onTap: () {
                      _showSnackBar('Google Sign-In belum diimplementasikan.');
                    },
                    child: CircleAvatar(
                      radius: 25,
                      backgroundColor: Theme.of(context).cardColor,
                      child: Image.network(
                        'https://img.icons8.com/color/48/000000/google-logo.png', // Placeholder Google icon
                        width: 30,
                        height: 30,
                        errorBuilder:
                            (context, error, stackTrace) =>
                                const Icon(Icons.g_mobiledata), // Fallback
                      ),
                    ),
                  ),
                  const SizedBox(width: 30),
                  // Tombol Apple Sign-In
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
