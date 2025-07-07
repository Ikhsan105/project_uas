// lib/edit_profile_screen.dart

import 'package:flutter/material.dart';
import 'package:project_ambtron/api/auth_service.dart';
import 'package:project_ambtron/api/database_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  // Semua controller dan variabel state Anda dipertahankan
  String _profileImageUrl = 'https://placehold.co/150x150/0056B3/FFFFFF?text=P';
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController(
    text: '‪+62 812-3456-7890‬', // Nomor telepon dummy tetap ada
  );

  // Variabel baru yang dibutuhkan
  final DatabaseService _dbService = DatabaseService();
  final AuthService _authService = AuthService();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  // --- FUNGSI BARU: Memuat data dari Supabase ---
  Future<void> _loadProfileData() async {
    try {
      final user = Supabase.instance.client.auth.currentUser;
      final profile = await _dbService.getProfile();
      if (mounted) {
        setState(() {
          _nameController.text = profile?['username'] ?? '';
          _emailController.text = user?.email ?? '';
          final avatarUrl = profile?['avatar_url'];
          if (avatarUrl != null && avatarUrl.isNotEmpty) {
            _profileImageUrl = avatarUrl;
          }
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Gagal memuat data: ${e.toString()}'),
          backgroundColor: Colors.red,
        ));
        setState(() => _isLoading = false);
      }
    }
  }

  // --- FUNGSI LAMA 'saveChanges' DIGANTI DENGAN LOGIKA BARU ---
  void _saveChanges() async {
    if (!mounted) return;
    setState(() => _isLoading = true);

    final newName = _nameController.text.trim();
    final newEmail = _emailController.text.trim();
    final currentEmail = Supabase.instance.client.auth.currentUser?.email;

    try {
      await _dbService.updateProfile(username: newName);

      if (newEmail.isNotEmpty && newEmail != currentEmail) {
        await _authService.updateUserEmail(context, newEmail);
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Profil berhasil diperbarui!'),
          backgroundColor: Colors.green,
        ));
        Navigator.of(context).pop(true); // Mengirim 'true' menandakan sukses
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Gagal menyimpan: ${e.toString()}'),
          backgroundColor: Colors.red,
        ));
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  // --- FUNGSI LAMA 'changeProfilePhoto' ANDA TETAP ADA ---
  void _changeProfilePhoto() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Fitur ubah foto profil belum diimplementasikan.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Profil')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // --- STRUKTUR UI ANDA TIDAK DIUBAH SAMA SEKALI ---
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 70,
                        backgroundImage: NetworkImage(_profileImageUrl),
                        backgroundColor: Theme.of(context).primaryColor.withOpacity(0.2),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Material(
                          elevation: 4,
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(20),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(20),
                            onTap: _changeProfilePhoto, // Memanggil fungsi lama Anda
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(Icons.camera_alt, color: Colors.white, size: 20),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Material(
                    elevation: 4,
                    borderRadius: BorderRadius.circular(16),
                    color: Theme.of(context).cardColor,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          TextField(
                            controller: _nameController, // Controller sekarang berisi data asli
                            decoration: const InputDecoration(labelText: 'Nama Lengkap', prefixIcon: Icon(Icons.person_outline)),
                          ),
                          const SizedBox(height: 20),
                          TextField(
                            controller: _emailController, // Controller sekarang berisi data asli
                            decoration: const InputDecoration(labelText: 'Alamat Email', prefixIcon: Icon(Icons.email_outlined)),
                            keyboardType: TextInputType.emailAddress,
                          ),
                          const SizedBox(height: 20),
                          TextField(
                            controller: _phoneController, // Controller dummy Anda tetap ada
                            decoration: const InputDecoration(labelText: 'Nomor Ponsel', prefixIcon: Icon(Icons.phone_outlined)),
                            keyboardType: TextInputType.phone,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _saveChanges,
                      child: _isLoading ? const CircularProgressIndicator(color: Colors.white) : const Text('SIMPAN PERUBAHAN'),
                    ),
                  ),
                ],
              ),
           ),
);
}
}