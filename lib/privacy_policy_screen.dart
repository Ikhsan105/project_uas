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
              'Privacy Policy',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              'Terakhir diperbarui: 30 Juni 2025',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(
                  context,
                ).textTheme.bodySmall?.color?.withOpacity(0.7),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Aplikasi StratoCloud ("kami", "aplikasi", atau "layanan") menghargai dan melindungi privasi pengguna kami ("Anda"). Kebijakan privasi ini menjelaskan bagaimana kami mengumpulkan, menggunakan, menyimpan, dan melindungi data pribadi Anda saat menggunakan aplikasi kami.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            _buildPrivacySection(
              context,
              '1. Informasi yang Kami Kumpulkan',
              'Saat Anda menggunakan StratoCloud, kami dapat mengumpulkan beberapa jenis informasi, termasuk:',
              [
                _buildPrivacyPoint(context, 'Informasi Pribadi:', 'seperti nama, alamat email (misalnya: 230103031@mhs.id), dan detail login.'),
                _buildPrivacyPoint(context, 'Informasi File/Media:', 'seperti nama file, ukuran, dan jenis file yang Anda simpan di aplikasi.'),
                _buildPrivacyPoint(context, 'Data Teknis:', 'seperti jenis perangkat, sistem operasi, alamat IP, waktu akses, dan aktivitas di aplikasi.'),
              ],
            ),
            _buildPrivacySection(
              context,
              '2. Cara Kami Menggunakan Informasi Anda',
              'Informasi yang kami kumpulkan digunakan untuk:',
              [
                _buildPrivacyPoint(context, null, 'Memberikan dan mengelola akses ke layanan penyimpanan file.'),
                _buildPrivacyPoint(context, null, 'Meningkatkan performa dan keamanan aplikasi.'),
                _buildPrivacyPoint(context, null, 'Memberikan dukungan atau respon jika Anda menghubungi kami melalui email.'),
                _buildPrivacyPoint(context, null, 'Mengirimkan pembaruan layanan atau informasi penting lainnya (jika diperlukan).'),
              ],
            ),
            _buildPrivacySection(
              context,
              '3. Penyimpanan dan Keamanan Data',
              'Kami menyimpan data Anda dengan aman menggunakan sistem enkripsi dan prosedur perlindungan yang sesuai. Kami berkomitmen untuk:',
              [
                _buildPrivacyPoint(context, null, 'Tidak menjual atau membagikan data pribadi Anda kepada pihak ketiga tanpa izin Anda.'),
                _buildPrivacyPoint(context, null, 'Melindungi informasi Anda dari akses, perubahan, atau penghapusan yang tidak sah.'),
              ],
            ),
            _buildPrivacySection(
              context,
              '4. Hak Pengguna',
              'Sebagai pengguna, Anda memiliki hak untuk:',
              [
                _buildPrivacyPoint(context, null, 'Mengakses, memperbarui, atau menghapus data pribadi Anda.'),
                _buildPrivacyPoint(context, null, 'Menarik persetujuan atas pengumpulan data tertentu kapan saja.'),
                _buildPrivacyPoint(context, null, 'Menghubungi kami jika ada kekhawatiran terkait penggunaan data pribadi Anda.'),
              ],
            ),
            _buildPrivacySection(
              context,
              '5. Cookie dan Teknologi Pelacakan',
              'StratoCloud tidak menggunakan cookie untuk melacak pengguna. Namun, data teknis seperti log akses dapat dikumpulkan untuk keperluan analitik internal.',
              [],
            ),
            _buildPrivacySection(
              context,
              '6. Layanan Pihak Ketiga',
              'Jika aplikasi menggunakan layanan pihak ketiga (misalnya Google Drive, Firebase, dll), layanan tersebut memiliki kebijakan privasi tersendiri. Kami menyarankan Anda untuk membaca kebijakan privasi masing-masing layanan jika digunakan dalam aplikasi.',
              [],
            ),
            _buildPrivacySection(
              context,
              '7. Perubahan Kebijakan Privasi',
              'Kebijakan ini dapat diperbarui dari waktu ke waktu. Perubahan besar akan diinformasikan melalui aplikasi atau email yang Anda daftarkan.',
              [],
            ),
            _buildPrivacySection(
              context,
              '8. Hubungi Kami',
              'Jika Anda memiliki pertanyaan atau permintaan mengenai kebijakan privasi ini, silakan hubungi kami di:',
              [
                _buildPrivacyPoint(context, '📧 Email:', '230103031@mhs.udb.ac.id'),
              ],
            ),
             const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildPrivacySection(
    BuildContext context,
    String title,
    String? description,
    List<Widget> points,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        if (description != null)
        Text(
          description,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 8),
        ...points,
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildPrivacyPoint(
    BuildContext context,
    String? title,
    String? content,
  ) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, top: 4.0, bottom: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title == null)
            const Text("• ", style: TextStyle(fontWeight: FontWeight.bold)),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.bodyMedium,
                children: [
                  if (title != null)
                  TextSpan(
                    text: title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  if (content != null)
                  TextSpan(
                    text: ' $content',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}