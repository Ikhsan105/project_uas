import 'package:flutter/material.dart';

class PermissionsConsentScreen extends StatefulWidget {
  const PermissionsConsentScreen({super.key});

  @override
  State<PermissionsConsentScreen> createState() =>
      _PermissionsConsentScreenState();
}

class _PermissionsConsentScreenState extends State<PermissionsConsentScreen> {
  // Dummy state for permissions
  bool _isStorageGranted = true;
  bool _isNotificationsEnabled = true;
  bool _isLocationGranted = false; // Contoh izin yang mungkin belum disetujui

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Izin & Privasi')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Kelola Izin Aplikasi',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Material(
              elevation: 4,
              borderRadius: BorderRadius.circular(16),
              color: Theme.of(context).cardColor,
              child: Column(
                children: [
                  SwitchListTile(
                    title: const Text('Akses Penyimpanan'),
                    subtitle: const Text(
                      'Izinkan aplikasi mengakses foto dan file Anda.',
                    ),
                    value: _isStorageGranted,
                    onChanged: (bool value) {
                      setState(() {
                        _isStorageGranted = value;
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Akses Penyimpanan: ${value ? 'Diberikan' : 'Ditolak'}',
                            ),
                          ),
                        );
                      });
                    },
                    secondary: Icon(
                      Icons.folder_shared_outlined,
                      color: Theme.of(context).iconTheme.color,
                    ),
                  ),
                  const Divider(indent: 16, endIndent: 16, height: 0),
                  SwitchListTile(
                    title: const Text('Notifikasi'),
                    subtitle: const Text('Dapatkan pembaruan dan pengingat.'),
                    value: _isNotificationsEnabled,
                    onChanged: (bool value) {
                      setState(() {
                        _isNotificationsEnabled = value;
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Notifikasi: ${value ? 'Aktif' : 'Nonaktif'}',
                            ),
                          ),
                        );
                      });
                    },
                    secondary: Icon(
                      Icons.notifications_outlined,
                      color: Theme.of(context).iconTheme.color,
                    ),
                  ),
                  const Divider(indent: 16, endIndent: 16, height: 0),
                  SwitchListTile(
                    title: const Text('Akses Lokasi'),
                    subtitle: const Text(
                      'Izinkan aplikasi mengakses lokasi Anda untuk fitur tertentu.',
                    ),
                    value: _isLocationGranted,
                    onChanged: (bool value) {
                      setState(() {
                        _isLocationGranted = value;
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Akses Lokasi: ${value ? 'Diberikan' : 'Ditolak'}',
                            ),
                          ),
                        );
                      });
                    },
                    secondary: Icon(
                      Icons.location_on_outlined,
                      color: Theme.of(context).iconTheme.color,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Text(
              'Persetujuan Kebijakan',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Material(
              elevation: 4,
              borderRadius: BorderRadius.circular(16),
              color: Theme.of(context).cardColor,
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(
                      Icons.privacy_tip_outlined,
                      color: Theme.of(context).iconTheme.color,
                    ),
                    title: const Text('Kebijakan Privasi'),
                    subtitle: const Text(
                      'Tinjau bagaimana data Anda dikumpulkan dan digunakan.',
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Membuka Kebijakan Privasi.'),
                        ),
                      );
                    },
                  ),
                  const Divider(indent: 16, endIndent: 16, height: 0),
                  ListTile(
                    leading: Icon(
                      Icons.description_outlined,
                      color: Theme.of(context).iconTheme.color,
                    ),
                    title: const Text('Ketentuan Layanan'),
                    subtitle: const Text(
                      'Baca syarat dan ketentuan penggunaan aplikasi.',
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Membuka Ketentuan Layanan.'),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Pengaturan izin dan privasi disimpan.'),
                    ),
                  );
                  Navigator.pop(context); // Kembali ke layar sebelumnya
                },
                child: const Text('Simpan Pengaturan'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
