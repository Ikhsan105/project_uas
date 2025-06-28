import 'package:flutter/material.dart';

// Kelas ini bertanggung jawab untuk mengelola dan memberi tahu perubahan tema
class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light; // Tema default: terang

  ThemeMode get themeMode => _themeMode;

  // Fungsi untuk beralih tema antara terang dan gelap
  void toggleTheme() {
    _themeMode =
        _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners(); // Memberi tahu semua widget yang mendengarkan bahwa tema telah berubah
  }
}
