import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tentang Stratocloud')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 24.0,
          vertical: 16.0,
        ), // Padding konsisten
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Icon(
              Icons.cloud_queue_rounded,
              size: 100,
              color: Theme.of(context).primaryColor,
            ),
            const SizedBox(height: 20),
            Text(
              'Stratocloud',
              style: Theme.of(
                context,
              ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'Versi 1.0.0',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Theme.of(
                  context,
                ).textTheme.titleMedium?.color?.withOpacity(0.7),
              ),
            ),
            const SizedBox(height: 30),
            Material(
              // Membungkus teks deskripsi dengan Material
              elevation: 4,
              borderRadius: BorderRadius.circular(16),
              color: Theme.of(context).cardColor,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'Stratocloud adalah aplikasi penyimpanan cloud terpadu yang dirancang untuk mengelola file, foto, video, dan catatan Anda secara efisien. Dengan antarmuka yang bersih dan intuitif, Stratocloud bertujuan untuk menyederhanakan kehidupan digital Anda.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ),
            const SizedBox(height: 30),
            Material(
              // Membungkus daftar opsi dengan Material
              elevation: 4,
              borderRadius: BorderRadius.circular(16),
              color: Theme.of(context).cardColor,
              child: Column(
                children: [
                  _buildAboutListTile(
                    context,
                    Icons.verified_user_outlined,
                    'Kebijakan Privasi',
                    () {
                      Navigator.pushNamed(context, '/privacy_policy');
                    },
                  ),
                  _buildAboutListTile(
                    context,
                    Icons.description_outlined,
                    'Ketentuan Layanan',
                    () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Membuka Ketentuan Layanan.'),
                        ),
                      );
                    },
                  ),
                  // Memperbarui onTap untuk menavigasi ke ContactUsScreen
                  _buildAboutListTile(
                    context,
                    Icons.mail_outline,
                    'Hubungi Kami',
                    () {
                      context.push('/contact-us');
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Text(
              '© 2024 Stratocloud. Semua hak dilindungi.',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(
                  context,
                ).textTheme.bodySmall?.color?.withOpacity(0.6),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper widget untuk ListTile opsi About
  Widget _buildAboutListTile(
    BuildContext context,
    IconData icon,
    String title,
    VoidCallback onTap,
  ) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, color: Theme.of(context).iconTheme.color),
          title: Text(title),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: onTap,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        const Divider(indent: 16, endIndent: 16, height: 0),
      ],
    );
  }
}
