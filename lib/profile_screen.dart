import 'package:flutter/material.dart';
import 'dart:math' as math; // Import math untuk perhitungan lingkaran
import 'typed_content_list_screen.dart';
import 'permissions_consent_screen.dart';

class ProfileScreen extends StatefulWidget {
  // Mengubah menjadi StatefulWidget
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Dummy data untuk profil pengguna. Dalam aplikasi nyata, ini akan dimuat dari backend.
  final String _userName = 'Nama Pengguna Stratocloud';
  final String _userEmail = 'pengguna@stratocloud.com';
  final String _profileImageUrl =
      'https://placehold.co/150x150/0056B3/FFFFFF?text=P';

  // Data dummy untuk penggunaan penyimpanan per tipe
  // Menggunakan const di sini agar tidak perlu final di dalam build method.
  static const double totalStorageGB = 100.0;
  static const double photosStorageGB = 20.0;
  static const double videosStorageGB = 10.0;
  static const double notesStorageGB = 5.0;
  static const double trashStorageGB = 0.5;
  static final double usedStorageGB =
      photosStorageGB + videosStorageGB + notesStorageGB + trashStorageGB;
  static final double availableStorageGB = totalStorageGB - usedStorageGB;
  static final double usedPercentage = (usedStorageGB / totalStorageGB);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        // Menggunakan CustomScrollView
        slivers: [
          SliverAppBar(
            expandedHeight: 220.0, // Diperkecil lagi agar lebih ringkas
            pinned: true, // AppBar akan tetap di atas saat digulir ke atas
            floating: false, // Tidak akan mengambang saat digulir ke bawah
            snap: false, // Tidak ada snap effect
            centerTitle: true, // Memusatkan judul saat collapsed
            backgroundColor:
                Theme.of(
                  context,
                ).scaffoldBackgroundColor, // Latar belakang AppBar transparan/scaffold color
            elevation: 0, // Menghilangkan bayangan AppBar default
            // Judul AppBar yang akan terlihat saat collapsed
            title: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                // Mendeteksi tinggi AppBar yang fleksibel
                double currentAppBarHeight = constraints.maxHeight;
                // Tinggi AppBar saat collapsed (tinggi default AppBar + padding atas)
                double collapsedAppBarHeight =
                    kToolbarHeight + MediaQuery.of(context).padding.top;

                // Tentukan opasitas berdasarkan seberapa dekat AppBar ke keadaan collapsed
                // 1.0 jika collapsed, 0.0 jika expanded
                double opacity =
                    1.0 -
                    ((currentAppBarHeight - collapsedAppBarHeight) /
                        (220.0 -
                            collapsedAppBarHeight)); // Sesuaikan dengan expandedHeight baru
                if (opacity < 0.0) opacity = 0.0;
                if (opacity > 1.0) opacity = 1.0;

                return Opacity(
                  opacity: opacity,
                  child: Container(
                    // Membungkus teks dengan Container untuk border
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ), // Padding lebih kecil
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).appBarTheme.foregroundColor!,
                        width: 1,
                      ), // Border dengan warna teks AppBar
                      borderRadius: BorderRadius.circular(20), // Sudut membulat
                    ),
                    child: Text(
                      'Profil Saya', // Hanya teks "Profil Saya" saat collapsed
                      style: Theme.of(
                        context,
                      ).appBarTheme.titleTextStyle?.copyWith(
                        color:
                            Theme.of(context)
                                .appBarTheme
                                .foregroundColor, // Sesuaikan warna teks AppBar
                        fontSize:
                            16, // Ukuran font disesuaikan agar cocok dengan border
                      ),
                    ),
                  ),
                );
              },
            ),

            // Menambahkan ikon panah kembali - Penyesuaian: Menggunakan BackButton
            leading: BackButton(
              // BackButton akan secara otomatis menangani pop dan styling
              color:
                  Theme.of(context)
                      .appBarTheme
                      .foregroundColor, // Warna ikon agar konsisten dengan tema
            ),

            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true, // Memusatkan konten di flexibleSpaceBar
              background: Container(
                // Background keseluruhan FlexibleSpaceBar
                color:
                    Theme.of(
                      context,
                    ).scaffoldBackgroundColor, // Latar belakang mengikuti warna scaffold
                child: Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top + 20,
                  ), // Padding dari atas
                  child: Center(
                    // Memusatkan konten kartu profil
                    child: Material(
                      // Kartu profil
                      elevation: 4, // Bayangan untuk kesan 3D
                      borderRadius: BorderRadius.circular(16), // Sudut membulat
                      color: Theme.of(context).cardColor, // Warna kartu
                      clipBehavior: Clip.antiAlias,
                      child: Container(
                        // Kontainer internal untuk padding dan konten profil
                        padding: const EdgeInsets.symmetric(
                          vertical: 20.0,
                          horizontal: 20.0,
                        ),
                        width:
                            MediaQuery.of(context).size.width *
                            0.8, // Lebar kartu profil (80% dari lebar layar)
                        child: Column(
                          mainAxisSize:
                              MainAxisSize
                                  .min, // Sesuaikan ukuran kolom dengan konten
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              // Membungkus CircleAvatar dengan Container untuk bingkai
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Theme.of(context).primaryColor,
                                  width: 2,
                                ), // Bingkai dengan warna primer
                              ),
                              child: CircleAvatar(
                                radius: 40,
                                backgroundImage: NetworkImage(_profileImageUrl),
                                backgroundColor:
                                    Colors
                                        .transparent, // Latar belakang transparan
                              ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              // Membungkus nama pengguna dengan Container untuk border
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Theme.of(context).primaryColor,
                                  width: 1,
                                ), // Border dengan warna primer
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                _userName,
                                style: Theme.of(
                                  context,
                                ).textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.color, // Menggunakan warna teks utama
                                  fontSize: 18,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              _userEmail,
                              style: Theme.of(
                                context,
                              ).textTheme.bodyMedium?.copyWith(
                                color: Theme.of(
                                  context,
                                ).textTheme.bodyMedium?.color?.withOpacity(
                                  0.8,
                                ), // Menggunakan warna teks sekunder
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            // Membungkus konten gulir lainnya
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 16.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Bagian ini adalah sisa konten dari ProfileScreen sebelumnya
                  Material(
                    // Menggunakan Material untuk elevasi dan bentuk yang konsisten dengan card
                    elevation: 4,
                    borderRadius: BorderRadius.circular(16),
                    color: Theme.of(context).cardColor,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Penyimpanan Anda',
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 20),
                          Center(
                            child: Container(
                              width: 200, // Ukuran total container lingkaran
                              height: 200,
                              alignment: Alignment.center,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  // Backing ring (lapisan paling belakang untuk kedalaman)
                                  Container(
                                    width: 180, // Ukuran lingkaran dalam
                                    height: 180,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color:
                                          Theme.of(context)
                                              .colorScheme
                                              .surfaceVariant, // Warna latar belakang abu-abu
                                      boxShadow: [
                                        BoxShadow(
                                          color:
                                              Theme.of(context).brightness ==
                                                      Brightness.light
                                                  ? Colors.grey.withOpacity(0.2)
                                                  : Colors.black.withOpacity(
                                                    0.5,
                                                  ),
                                          spreadRadius: 2,
                                          blurRadius: 5,
                                          offset: const Offset(
                                            0,
                                            3,
                                          ), // Bayangan ke bawah
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Progress bar (di atas backing ring)
                                  SizedBox(
                                    width: 180,
                                    height: 180,
                                    child: CircularProgressIndicator(
                                      value:
                                          usedPercentage, // Progres dari 0.0 sampai 1.0
                                      strokeWidth: 20.0, // Ketebalan lingkaran
                                      backgroundColor:
                                          Colors
                                              .transparent, // Latar belakang transparan, agar backing ring terlihat
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        Theme.of(context).primaryColor,
                                      ), // Warna progres utama
                                      strokeCap: StrokeCap.round, // Ujung bulat
                                    ),
                                  ),
                                  // Teks di tengah lingkaran
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '${usedStorageGB.toStringAsFixed(1)} GB',
                                        style: Theme.of(
                                          context,
                                        ).textTheme.headlineMedium?.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        'Tersedia', // Mengubah 'dari 100 GB' menjadi 'Tersedia'
                                        style: Theme.of(
                                          context,
                                        ).textTheme.titleSmall?.copyWith(
                                          color: Theme.of(context)
                                              .textTheme
                                              .bodySmall
                                              ?.color
                                              ?.withOpacity(0.7),
                                        ),
                                      ),
                                      const SizedBox(height: 4), // Spasi kecil
                                      Text(
                                        'Total ${totalStorageGB.toStringAsFixed(0)} GB', // Menambahkan total di bawahnya
                                        style: Theme.of(
                                          context,
                                        ).textTheme.bodySmall?.copyWith(
                                          color: Theme.of(context)
                                              .textTheme
                                              .bodySmall
                                              ?.color
                                              ?.withOpacity(0.6),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          // Rincian penggunaan per tipe
                          // Menambahkan onTap untuk navigasi
                          _buildStorageDetailRow(
                            context,
                            'Foto',
                            photosStorageGB,
                            Icons.photo_library,
                            Colors.purple,
                            'photo',
                            'Foto Anda',
                          ),
                          _buildStorageDetailRow(
                            context,
                            'Video',
                            videosStorageGB,
                            Icons.videocam,
                            Colors.green,
                            'video',
                            'Video Anda',
                          ),
                          _buildStorageDetailRow(
                            context,
                            'Catatan',
                            notesStorageGB,
                            Icons.note_alt,
                            Colors.orange,
                            'note',
                            'Catatan Anda',
                          ),
                          _buildStorageDetailRow(
                            context,
                            'Sampah',
                            trashStorageGB,
                            Icons.delete,
                            Colors.red,
                            'trash',
                            'Item Dihapus',
                          ),
                          const Divider(height: 20),
                          _buildStorageDetailRow(
                            context,
                            'Semua',
                            totalStorageGB,
                            Icons.folder_open,
                            Theme.of(context).disabledColor,
                            'all',
                            'Semua Item Anda',
                          ), // Opsi semua item
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Opsi Profil
                  Material(
                    elevation: 4,
                    borderRadius: BorderRadius.circular(16),
                    color: Theme.of(context).cardColor,
                    child: Column(
                      children: [
                        _buildProfileListTile(
                          context,
                          Icons.edit_outlined,
                          'Edit Profil',
                          () {
                            // Mengubah onTap untuk menavigasi ke EditProfileScreen
                            Navigator.pushNamed(
                              context,
                              '/edit_profile',
                            ); // Navigasi ke rute baru
                          },
                        ),
                        _buildProfileListTile(
                          context,
                          Icons.lock_outline,
                          'Ubah Kata Sandi',
                          () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Fitur ubah kata sandi belum diimplementasikan.',
                                ),
                              ),
                            );
                          },
                        ),
                        _buildProfileListTile(
                          context,
                          Icons.settings_outlined,
                          'Pengaturan',
                          () {
                            Navigator.pushNamed(context, '/settings');
                          },
                        ),
                        // Menambahkan opsi Izin & Privasi
                        _buildProfileListTile(
                          context,
                          Icons.privacy_tip_outlined,
                          'Izin & Privasi',
                          () {
                            Navigator.pushNamed(
                              context,
                              '/permissions_consent',
                            );
                          },
                        ),
                        _buildProfileListTile(
                          context,
                          Icons.info_outline,
                          'Tentang Aplikasi',
                          () {
                            Navigator.pushNamed(context, '/about');
                          },
                        ),
                        _buildProfileListTile(
                          context,
                          Icons.logout,
                          'Keluar',
                          () {
                            // Logika keluar aplikasi
                            Navigator.pushReplacementNamed(
                              context,
                              '/',
                            ); // Kembali ke layar login
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Anda telah keluar dari aplikasi.',
                                ),
                              ),
                            );
                          },
                          isDestructive: true,
                        ), // Tandai sebagai destruktif untuk warna merah
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper widget untuk baris detail penggunaan penyimpanan
  // Dibuat static agar bisa dipanggil dari StatelessWidget
  static Widget _buildStorageDetailRow(
    BuildContext context,
    String typeName,
    double amountGB,
    IconData icon,
    Color color,
    String contentType,
    String appBarTitle,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        // Menggunakan InkWell agar bisa diklik
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) => TypedContentListScreen(
                    contentType: contentType,
                    appBarTitle: appBarTitle,
                  ),
            ),
          );
        },
        borderRadius: BorderRadius.circular(
          8,
        ), // Memberikan rounded corners pada efek tap
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 4.0,
          ), // Padding internal InkWell
          child: Row(
            children: [
              Icon(icon, color: color, size: 24),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  typeName,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              Text(
                '${amountGB.toStringAsFixed(1)} GB',
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 8), // Spasi sebelum ikon panah
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Theme.of(context).iconTheme.color?.withOpacity(0.6),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper widget untuk ListTile opsi profil yang lebih bersih
  // Dibuat static agar bisa dipanggil dari StatelessWidget
  static Widget _buildProfileListTile(
    BuildContext context,
    IconData icon,
    String title,
    VoidCallback onTap, {
    bool isDestructive = false,
  }) {
    return Column(
      children: [
        ListTile(
          leading: Icon(
            icon,
            color:
                isDestructive ? Colors.red : Theme.of(context).iconTheme.color,
          ),
          title: Text(
            title,
            style: TextStyle(
              color:
                  isDestructive
                      ? Colors.red
                      : Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: onTap,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ), // Bentuk bulat untuk feedback tap
        ),
        const Divider(
          indent: 16,
          endIndent: 16,
          height: 0,
        ), // Pembatas yang lebih tipis dan rapi
      ],
    );
  }
}
