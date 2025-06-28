import 'package:flutter/material.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hubungi Kami')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Kami Siap Membantu Anda',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              'Jangan ragu untuk menghubungi kami jika Anda memiliki pertanyaan, masukan, atau memerlukan dukungan.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 30),
            Material(
              elevation: 4,
              borderRadius: BorderRadius.circular(16),
              color: Theme.of(context).cardColor,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Informasi Kontak',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ListTile(
                      leading: Icon(
                        Icons.email_outlined,
                        color: Theme.of(context).primaryColor,
                      ),
                      title: const Text('Email Dukungan'),
                      subtitle: const Text('support@stratocloud.com'),
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Menyalin alamat email.'),
                          ),
                        );
                        // Implementasi untuk membuka aplikasi email bisa ditambahkan di sini
                      },
                    ),
                    const Divider(indent: 16, endIndent: 16),
                    ListTile(
                      leading: Icon(
                        Icons.phone_outlined,
                        color: Theme.of(context).primaryColor,
                      ),
                      title: const Text('Nomor Telepon'),
                      subtitle: const Text('+62 812-3456-7890'), // Nomor dummy
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Menyalin nomor telepon.'),
                          ),
                        );
                        // Implementasi untuk melakukan panggilan telepon bisa ditambahkan di sini
                      },
                    ),
                    const Divider(indent: 16, endIndent: 16),
                    ListTile(
                      leading: Icon(
                        Icons.public_outlined,
                        color: Theme.of(context).primaryColor,
                      ),
                      title: const Text('Situs Web Resmi'),
                      subtitle: const Text('www.stratocloud.com'), // URL dummy
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Membuka situs web.')),
                        );
                        // Implementasi untuk membuka browser bisa ditambahkan di sini
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            Text(
              'Kirim Pesan Langsung',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Material(
              elevation: 4,
              borderRadius: BorderRadius.circular(16),
              color: Theme.of(context).cardColor,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Nama Anda',
                        hintText: 'Masukkan nama lengkap Anda',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Email Anda',
                        hintText: 'Masukkan alamat email Anda',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      maxLines: 5,
                      decoration: InputDecoration(
                        labelText: 'Pesan Anda',
                        hintText: 'Tuliskan pesan Anda di sini...',
                        alignLabelWithHint: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      keyboardType: TextInputType.multiline,
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Pesan Anda telah terkirim. Terima kasih!',
                              ),
                            ),
                          );
                          // Implementasi pengiriman pesan ke backend bisa ditambahkan di sini
                        },
                        child: const Text('KIRIM PESAN'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
