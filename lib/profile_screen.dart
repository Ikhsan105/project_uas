// lib/profile_screen.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_ambtron/api/auth_service.dart';
import 'package:project_ambtron/api/database_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final DatabaseService _dbService = DatabaseService();
  final AuthService _authService = AuthService();

  // Data dummy untuk penyimpanan dikembalikan
  static const double totalStorageGB = 100.0;
  static const double photosStorageGB = 20.0;
  static const double videosStorageGB = 10.0;
  static const double notesStorageGB = 5.0;
  static const double trashStorageGB = 0.5;
  static final double usedStorageGB =
      photosStorageGB + videosStorageGB + notesStorageGB + trashStorageGB;
  static final double usedPercentage = (usedStorageGB / totalStorageGB);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>?>(
      future: _dbService.getProfile(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError || !snapshot.hasData || snapshot.data == null) {
          return const Center(
            child: Text('Gagal memuat profil.', textAlign: TextAlign.center),
          );
        }

        final profileData = snapshot.data!;
        final username = profileData['username'] ?? 'Nama Pengguna';
        final avatarUrl = profileData['avatar_url'];
        final userEmail =
            Supabase.instance.client.auth.currentUser?.email ??
            'Tidak ada email';

        return ListView(
          padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 80.0),
          children: [
            // --- KARTU PROFIL PENGGUNA ---
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey.shade200,
                      backgroundImage:
                          avatarUrl != null ? NetworkImage(avatarUrl) : null,
                      child:
                          avatarUrl == null
                              ? const Icon(
                                Icons.person,
                                size: 50,
                                color: Colors.grey,
                              )
                              : null,
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Theme.of(context).primaryColor,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        username,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      userEmail,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // --- KARTU PENYIMPANAN ANDA (DIKEMBALIKAN) ---
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Penyimpanan Anda',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: SizedBox(
                        width: 180,
                        height: 180,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            SizedBox(
                              width: 180,
                              height: 180,
                              child: CircularProgressIndicator(
                                value: usedPercentage,
                                strokeWidth: 20.0,
                                backgroundColor:
                                    Theme.of(
                                      context,
                                    ).colorScheme.surfaceVariant,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Theme.of(context).primaryColor,
                                ),
                                strokeCap: StrokeCap.round,
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${usedStorageGB.toStringAsFixed(1)} GB',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Terpakai',
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Total ${totalStorageGB.toStringAsFixed(0)} GB',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildStorageDetailRow(
                      context,
                      'Foto',
                      Icons.photo_library,
                      Colors.purple,
                    ),
                    _buildStorageDetailRow(
                      context,
                      'Video',
                      Icons.videocam,
                      Colors.green,
                    ),
                    _buildStorageDetailRow(
                      context,
                      'Catatan',
                      Icons.note_alt,
                      Colors.orange,
                    ),
                    _buildStorageDetailRow(
                      context,
                      'Sampah',
                      Icons.delete,
                      Colors.red,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // --- KARTU MENU OPSI (DENGAN TAMBAHAN) ---
            Card(
              elevation: 4,
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  _buildMenuOption(
                    context,
                    Icons.edit_outlined,
                    'Edit Profil',
                    () => context.push('/edit-profile'),
                  ),
                  const Divider(height: 1),
                  _buildMenuOption(
                    context,
                    Icons.lock_outline,
                    'Ubah Kata Sandi',
                    () {
                        // Logika untuk ubah kata sandi
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Fitur ubah kata sandi belum diimplementasikan.',
                            ),
                          ),
                        );
                    },
                  ),
                  const Divider(height: 1),
                  _buildMenuOption(
                    context,
                    Icons.settings_outlined,
                    'Pengaturan',
                    () => context.push('/settings'),
                  ),
                  const Divider(height: 1),
                  _buildMenuOption(
                    context,
                    Icons.privacy_tip_outlined,
                    'Izin & Privasi',
                     // --- PERUBAHAN DI SINI ---
                    () => context.push('/privacy-policy'),
                  ),
                  const Divider(height: 1),
                  _buildMenuOption(
                    context,
                    Icons.info_outline,
                    'Tentang Aplikasi',
                    () => context.push('/about'),
                  ),
                  const Divider(height: 1),
                  _buildMenuOption(
                    context,
                    Icons.logout,
                    'Keluar',
                    () => _authService.signOut(context),
                    isDestructive: true,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  // Helper widget untuk detail penyimpanan
  Widget _buildStorageDetailRow(
    BuildContext context,
    String typeName,
    IconData icon,
    Color color,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: () {},
        child: Row(
          children: [
            Icon(icon, color: color),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                typeName,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  // Helper widget untuk opsi menu
  Widget _buildMenuOption(
    BuildContext context,
    IconData icon,
    String title,
    VoidCallback onTap, {
    bool isDestructive = false,
  }) {
    final color =
        isDestructive
            ? Colors.red
            : Theme.of(context).textTheme.bodyLarge?.color;
    final iconColor =
        isDestructive ? Colors.red : Theme.of(context).primaryColor;

    return ListTile(
      leading: Icon(icon, color: iconColor),
      title: Text(title, style: TextStyle(color: color)),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: Colors.grey,
      ),
      onTap: onTap,
    );
  }
}