import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  // Dummy data untuk profil pengguna. Dalam aplikasi nyata, ini akan dimuat dari backend.
  String _profileImageUrl = 'https://placehold.co/150x150/0056B3/FFFFFF?text=P';
  final TextEditingController _nameController = TextEditingController(
    text: 'Nama Pengguna Stratocloud',
  );
  final TextEditingController _emailController = TextEditingController(
    text: 'pengguna@stratocloud.com',
  );
  final TextEditingController _phoneController = TextEditingController(
    text: '+62 812-3456-7890',
  );

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _saveChanges() {
    // Logika penyimpanan perubahan (dummy). Dalam aplikasi nyata, ini akan mengirim data ke backend.
    final newName = _nameController.text;
    final newEmail = _emailController.text;
    final newPhone = _phoneController.text;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Perubahan profil disimpan untuk: $newName, $newEmail, $newPhone',
        ),
        backgroundColor: Colors.green,
      ),
    );
    Navigator.pop(context); // Kembali ke ProfileScreen
  }

  void _changeProfilePhoto() {
    // Logika untuk mengubah foto profil (dummy).
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Fitur ubah foto profil belum diimplementasikan.'),
      ),
    );
    // Di sini Anda akan mengimplementasikan image picker untuk memilih foto baru
    // dan kemudian memperbarui _profileImageUrl.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Profil')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 70,
                  backgroundImage: NetworkImage(_profileImageUrl),
                  backgroundColor: Theme.of(
                    context,
                  ).primaryColor.withOpacity(0.2),
                  onBackgroundImageError: (exception, stackTrace) {
                    // Fallback jika gambar profil tidak dapat dimuat
                    setState(() {
                      _profileImageUrl =
                          'https://placehold.co/150x150/0056B3/FFFFFF?text=P'; // Kembali ke placeholder
                    });
                  },
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
                      onTap: _changeProfilePhoto,
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 20,
                        ),
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
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'Nama Lengkap',
                        prefixIcon: Icon(Icons.person_outline),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'Alamat Email',
                        prefixIcon: Icon(Icons.email_outlined),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _phoneController,
                      decoration: const InputDecoration(
                        labelText: 'Nomor Ponsel',
                        prefixIcon: Icon(Icons.phone_outlined),
                      ),
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
                onPressed: _saveChanges,
                child: const Text('SIMPAN PERUBAHAN'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
