import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kebijakan Privasi')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Kebijakan Privasi Stratocloud',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              'Terakhir diperbarui: 27 Juni 2025',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(
                  context,
                ).textTheme.bodySmall?.color?.withOpacity(0.7),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Pengantar',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Stratocloud ("kami", "milik kami", atau "kami") mengoperasikan aplikasi seluler Stratocloud (selanjutnya disebut sebagai "Layanan"). Halaman ini memberitahu Anda tentang kebijakan kami mengenai pengumpulan, penggunaan, dan pengungkapan data pribadi saat Anda menggunakan Layanan kami dan pilihan yang Anda miliki terkait data tersebut.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            Text(
              'Pengumpulan dan Penggunaan Informasi',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Kami mengumpulkan beberapa jenis informasi untuk berbagai tujuan guna menyediakan dan meningkatkan Layanan kami kepada Anda. Jenis informasi yang dikumpulkan mungkin termasuk, namun tidak terbatas pada:',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            _buildPrivacyPoint(
              context,
              'Data Pribadi:',
              'Saat menggunakan Layanan kami, kami mungkin meminta Anda untuk memberikan kami informasi pengenal pribadi tertentu yang dapat digunakan untuk menghubungi atau mengidentifikasi Anda ("Data Pribadi"). Informasi pengenal pribadi mungkin termasuk, namun tidak terbatas pada: Alamat email, Nama depan dan nama belakang, Nomor telepon, Alamat, Negara, Kota, Cookies dan Data Penggunaan.',
            ),
            _buildPrivacyPoint(
              context,
              'Data Penggunaan:',
              'Kami juga dapat mengumpulkan informasi tentang bagaimana Layanan diakses dan digunakan ("Data Penggunaan"). Data Penggunaan ini dapat mencakup informasi seperti alamat Protokol Internet komputer Anda (misalnya alamat IP), jenis browser, versi browser, halaman Layanan kami yang Anda kunjungi, waktu dan tanggal kunjungan Anda, waktu yang dihabiskan di halaman-halaman tersebut, pengenal perangkat unik dan data diagnostik lainnya.',
            ),
            _buildPrivacyPoint(
              context,
              'Data yang Dikumpulkan dari Penyimpanan Cloud:',
              'Layanan Stratocloud adalah aplikasi penyimpanan cloud. Oleh karena itu, kami akan menyimpan file, foto, video, catatan, dan dokumen lain yang Anda unggah ke Layanan kami. Data ini disimpan dengan aman di server cloud pihak ketiga kami. Kami tidak akan mengakses, melihat, atau membagikan data Anda tanpa izin eksplisit Anda atau kecuali diwajibkan oleh hukum.',
            ),
            const SizedBox(height: 24),
            Text(
              'Penggunaan Data',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Stratocloud menggunakan data yang dikumpulkan untuk berbagai tujuan:',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            _buildPrivacyPoint(
              context,
              '- Untuk menyediakan dan memelihara Layanan.',
              null,
            ),
            _buildPrivacyPoint(
              context,
              '- Untuk memberi tahu Anda tentang perubahan pada Layanan kami.',
              null,
            ),
            _buildPrivacyPoint(
              context,
              '- Untuk memungkinkan Anda berpartisipasi dalam fitur interaktif Layanan kami saat Anda memilih untuk melakukannya.',
              null,
            ),
            _buildPrivacyPoint(
              context,
              '- Untuk memberikan dukungan pelanggan.',
              null,
            ),
            _buildPrivacyPoint(
              context,
              '- Untuk memantau penggunaan Layanan.',
              null,
            ),
            _buildPrivacyPoint(
              context,
              '- Untuk mendeteksi, mencegah, dan mengatasi masalah teknis.',
              null,
            ),
            const SizedBox(height: 24),
            Text(
              'Keamanan Data',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Keamanan data Anda penting bagi kami, tetapi ingat bahwa tidak ada metode transmisi melalui Internet, atau metode penyimpanan elektronik yang 100% aman. Meskipun kami berusaha untuk menggunakan cara yang dapat diterima secara komersial untuk melindungi Data Pribadi Anda, kami tidak dapat menjamin keamanan mutlaknya.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            Text(
              'Perubahan pada Kebijakan Privasi Ini',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Kami dapat memperbarui Kebijakan Privasi kami dari waktu ke waktu. Kami akan memberi tahu Anda tentang setiap perubahan dengan memposting Kebijakan Privasi baru di halaman ini. Anda disarankan untuk meninjau Kebijakan Privasi ini secara berkala untuk setiap perubahan. Perubahan pada Kebijakan Privasi ini efektif saat diposting di halaman ini.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            Text(
              'Hubungi Kami',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Jika Anda memiliki pertanyaan tentang Kebijakan Privasi ini, silakan hubungi kami melalui email: support@stratocloud.com',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildPrivacyPoint(
    BuildContext context,
    String title,
    String? content,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          if (content != null)
            Text(content, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}
