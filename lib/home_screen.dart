import 'package:flutter/material.dart';

// Import Screens yang dibutuhkan

import 'files_screen.dart';
import 'photos_screen.dart';
import 'notes_screen.dart';
import 'profile_screen.dart';
import 'search_screen.dart';
// import 'package:saifana/screens/note_editor_screen.dart'; // Baris ini dihapus karena tidak digunakan langsung di sini

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeDashboardController extends ChangeNotifier {
  final ValueNotifier<Set<String>> selectedItems = ValueNotifier({});
  final ValueNotifier<bool> isSelectionMode = ValueNotifier(false);

  void toggleSelection(String itemId) {
    if (selectedItems.value.contains(itemId)) {
      selectedItems.value.remove(itemId);
    } else {
      selectedItems.value.add(itemId);
    }
    selectedItems.notifyListeners();
    isSelectionMode.value = selectedItems.value.isNotEmpty;
    isSelectionMode.notifyListeners();
  }

  void selectAll(List<String> allItemIds) {
    selectedItems.value = Set<String>.from(allItemIds);
    selectedItems.notifyListeners();
    isSelectionMode.value = selectedItems.value.isNotEmpty;
    isSelectionMode.notifyListeners();
  }

  void clearSelection() {
    selectedItems.value.clear();
    selectedItems.notifyListeners();
    isSelectionMode.value = false;
    isSelectionMode.notifyListeners();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0; // Index untuk BottomNavigationBar, default ke 'Foto'
  String _currentTitle = 'Foto'; // Judul AppBar default untuk tab Foto

  final String _quote = 'Abadikan setiap momen indahmu.';

  // Controller untuk mengelola state seleksi di _HomeDashboard
  late final _HomeDashboardController _dashboardController;

  // GlobalKey untuk mengakses _HomeDashboardState dan mendapatkan daftar item
  final GlobalKey<_HomeDashboardState> _homeDashboardKey = GlobalKey();

  // Daftar widget untuk setiap tab navigasi
  late final List<Widget> _widgetOptions; // Deklarasikan sebagai late final

  @override
  void initState() {
    super.initState();
    _dashboardController = _HomeDashboardController();
    // Mendengarkan perubahan pada mode seleksi atau item terpilih untuk memperbarui AppBar
    _dashboardController.isSelectionMode.addListener(_updateAppBar);
    _dashboardController.selectedItems.addListener(_updateAppBar);

    // Inisialisasi _widgetOptions di initState
    _widgetOptions = <Widget>[
      _HomeDashboard(
        key: _homeDashboardKey, // Tetapkan GlobalKey di sini
        quote: _quote,
        controller: _dashboardController,
      ),
      const FilesScreen(), // Ini adalah tampilan Koleksi/File
      const ProfileScreen(), // Ini adalah tampilan Profil
    ];
  }

  @override
  void dispose() {
    _dashboardController.isSelectionMode.removeListener(_updateAppBar);
    _dashboardController.selectedItems.removeListener(_updateAppBar);
    _dashboardController.dispose();
    super.dispose();
  }

  void _updateAppBar() {
    setState(() {
      // Rebuild AppBar ketika mode seleksi atau jumlah item terpilih berubah
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch (index) {
        case 0:
          _currentTitle =
              'Foto'; // Meskipun tampilan di AppBar akan logo/nama app, _currentTitle tetap menyimpan label tab
          break;
        case 1:
          _currentTitle = 'Koleksi';
          break;
        case 2:
          _currentTitle = 'Profil';
          break;
        default:
          _currentTitle = 'Stratocloud'; // Fallback
          break;
      }
    });
  }

  // Fungsi untuk menampilkan dialog Buat Folder/Catatan/Unggah
  void _showCreateNewDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: const Text('Buat Baru'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.folder_outlined),
                title: const Text('Folder Baru'),
                onTap: () {
                  Navigator.pop(context); // Tutup dialog "Buat Baru"
                  _showCreateFolderDialog(
                    context,
                  ); // Tampilkan dialog "Buat Folder"
                },
              ),
              ListTile(
                leading: const Icon(Icons.note_alt_outlined),
                title: const Text('Catatan Baru'),
                onTap: () {
                  Navigator.pop(context); // Tutup dialog "Buat Baru"
                  Navigator.pushNamed(
                    context,
                    '/note_editor',
                  ); // Navigasi ke editor catatan
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera_outlined),
                title: const Text('Unggah Foto'),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Fitur unggah foto belum diimplementasikan.',
                      ),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.videocam_outlined),
                title: const Text('Unggah Video'),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Fitur unggah video belum diimplementasikan.',
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // Dialog untuk membuat folder baru
  void _showCreateFolderDialog(BuildContext context) {
    TextEditingController folderNameController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: const Text('Buat Folder Baru'),
          content: TextField(
            controller: folderNameController,
            decoration: const InputDecoration(
              hintText: 'Nama Folder',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Batal'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('Buat'),
              onPressed: () {
                if (folderNameController.text.isNotEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Folder "${folderNameController.text}" dibuat.',
                      ),
                    ),
                  );
                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Nama folder tidak boleh kosong.'),
                    ),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Judul AppBar berubah berdasarkan mode seleksi atau tab saat ini
        title: ValueListenableBuilder<bool>(
          valueListenable: _dashboardController.isSelectionMode,
          builder: (context, isSelectionMode, child) {
            if (isSelectionMode) {
              return ValueListenableBuilder<Set<String>>(
                valueListenable: _dashboardController.selectedItems,
                builder: (context, selectedItems, child) {
                  return Text('${selectedItems.length} Dipilih');
                },
              );
            } else {
              // Jika di tab Foto, tampilkan logo dan nama aplikasi
              if (_selectedIndex == 0) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.cloud_queue_rounded,
                      color: Theme.of(context).primaryColor,
                      size: 28,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Stratocloud',
                      style: Theme.of(context).appBarTheme.titleTextStyle,
                    ),
                  ],
                );
              } else {
                return Text(_currentTitle);
              }
            }
          },
        ),
        leading: ValueListenableBuilder<bool>(
          valueListenable: _dashboardController.isSelectionMode,
          builder: (context, isSelectionMode, child) {
            if (isSelectionMode) {
              return IconButton(
                icon: const Icon(
                  Icons.close,
                ), // Tombol silang untuk keluar mode seleksi
                onPressed: () {
                  _dashboardController.clearSelection();
                },
              );
            } else {
              return const SizedBox.shrink(); // Tidak ada leading icon di mode normal
            }
          },
        ),
        actions: [
          // Jika mode seleksi aktif di tab Foto
          ValueListenableBuilder<bool>(
            valueListenable: _dashboardController.isSelectionMode,
            builder: (context, isSelectionMode, child) {
              List<Widget> actions = [];

              if (isSelectionMode && _selectedIndex == 0) {
                // Tombol "Select All" / "Deselect All"
                actions.add(
                  ValueListenableBuilder<Set<String>>(
                    valueListenable: _dashboardController.selectedItems,
                    builder: (context, selectedItems, _) {
                      // Dapatkan semua ID item dari _HomeDashboard
                      final allItemIds =
                          _homeDashboardKey.currentState?._galleryItems
                              .map((item) => item['id'] as String)
                              .toSet();
                      final bool allSelected =
                          allItemIds != null &&
                          selectedItems.containsAll(allItemIds);

                      return IconButton(
                        icon: Icon(
                          allSelected
                              ? Icons.check_box
                              : Icons.check_box_outline_blank,
                        ),
                        onPressed: () {
                          if (allSelected) {
                            _dashboardController
                                .clearSelection(); // Deselect all
                          } else {
                            if (allItemIds != null) {
                              _dashboardController.selectAll(
                                allItemIds.toList(),
                              ); // Select all
                            }
                          }
                        },
                        tooltip:
                            allSelected
                                ? 'Batalkan Semua Pilihan'
                                : 'Pilih Semua',
                      );
                    },
                  ),
                );

                // Tombol tiga titik (Opsi Menu)
                actions.add(
                  PopupMenuButton<String>(
                    onSelected: (String result) {
                      _handleSelectionMenu(
                        context,
                        result,
                        _dashboardController.selectedItems.value,
                      );
                    },
                    itemBuilder:
                        (BuildContext context) => <PopupMenuEntry<String>>[
                          const PopupMenuItem<String>(
                            value: 'delete',
                            child: Text('Hapus'),
                          ),
                          const PopupMenuItem<String>(
                            value: 'group',
                            child: Text('Kelompokkan'),
                          ),
                        ],
                  ),
                );
              } else if (_selectedIndex == 0 || _selectedIndex == 1) {
                // Ikon untuk seleksi manual di mode normal (hanya visual, tekan lama untuk fungsionalitas)
                actions.add(
                  IconButton(
                    icon: const Icon(Icons.check_circle_outline),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Tekan lama untuk memulai seleksi.'),
                        ),
                      );
                    },
                  ),
                );
              }

              // Ikon profil mengambang di kanan atas (selalu ada)
              actions.add(
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/profile',
                      ); // Navigasi ke halaman profil
                    },
                    child: const CircleAvatar(
                      radius: 18,
                      backgroundImage: NetworkImage(
                        'https://placehold.co/100x100/0056B3/FFFFFF?text=P', // Placeholder Profil
                      ),
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                ),
              );
              return Row(
                children: actions,
              ); // Mengembalikan Row dari semua widget aksi
            },
          ),
        ],
      ),
      body: _widgetOptions.elementAt(
        _selectedIndex,
      ), // Menampilkan widget yang sesuai dengan tab terpilih
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.photo_library_outlined),
            label: 'Foto',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.folder_outlined,
            ), // Menggunakan ikon folder untuk Koleksi
            label: 'Koleksi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profil',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: (index) {
          // Bersihkan seleksi saat berpindah tab (hanya jika di tab Foto dan mode seleksi aktif)
          if (_selectedIndex == 0 &&
              _dashboardController.isSelectionMode.value) {
            _dashboardController.clearSelection();
          }
          _onItemTapped(index);
        },
      ),
      // FAB selalu tampil di Foto, Koleksi, dan Profil (index 0, 1, dan 2)
      floatingActionButton:
          (_selectedIndex == 0 || _selectedIndex == 1 || _selectedIndex == 2)
              ? FloatingActionButton(
                onPressed: _showCreateNewDialog,
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
                child: const Icon(Icons.add_rounded, size: 30),
              )
              : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  // Fungsi untuk menangani pilihan dari PopupMenuButton (titik tiga)
  void _handleSelectionMenu(
    BuildContext context,
    String result,
    Set<String> selectedItems,
  ) {
    if (selectedItems.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Pilih setidaknya satu item terlebih dahulu.'),
        ),
      );
      return;
    }

    switch (result) {
      case 'delete':
        _showDeleteOptionsDialog(context, selectedItems);
        break;
      case 'group':
        _showGroupOptionsDialog(context, selectedItems);
        break;
    }
  }

  void _showDeleteOptionsDialog(
    BuildContext context,
    Set<String> selectedItems,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Text('Hapus ${selectedItems.length} Item?'),
          content: const Text('Pilih cara Anda ingin menghapus item ini:'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      '${selectedItems.length} item dipindahkan ke sampah.',
                    ),
                  ),
                );
                _dashboardController.clearSelection();
              },
              child: const Text('Pindahkan ke Sampah'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      '${selectedItems.length} item dihapus permanen.',
                    ),
                  ),
                );
                _dashboardController.clearSelection();
              },
              child: const Text(
                'Hapus Permanen',
                style: TextStyle(color: Colors.red),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Batal'),
            ),
          ],
        );
      },
    );
  }

  void _showGroupOptionsDialog(
    BuildContext context,
    Set<String> selectedItems,
  ) {
    TextEditingController folderNameController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Text('Kelompokkan ${selectedItems.length} Item'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Buat folder baru untuk item yang dipilih:'),
              const SizedBox(height: 10),
              TextField(
                controller: folderNameController,
                decoration: const InputDecoration(
                  hintText: 'Nama Folder Baru',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                if (folderNameController.text.isNotEmpty) {
                  Navigator.pop(dialogContext);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        '${selectedItems.length} item dikelompokkan ke "${folderNameController.text}".',
                      ),
                    ),
                  );
                  _dashboardController.clearSelection();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Nama folder tidak boleh kosong.'),
                    ),
                  );
                }
              },
              child: const Text('Buat & Kelompokkan'),
            ),
          ],
        );
      },
    );
  }
}

// Widget Dashboard ini sekarang menjadi Tampilan Galeri ala Google Photos (tab 'Foto')
class _HomeDashboard extends StatefulWidget {
  // final String userName; // Dihapus penggunaannya di sini - SUDAH DIHAPUS
  final String quote;
  final _HomeDashboardController
  controller; // Menerima controller dari HomeScreen

  const _HomeDashboard({
    Key? key,
    // required this.userName, // Dihapus penggunaannya di sini - SUDAH DIHAPUS DARI KONSTRUKTOR
    required this.quote,
    required this.controller,
  }) : super(key: key);

  @override
  State<_HomeDashboard> createState() => _HomeDashboardState();
}

class _HomeDashboardState extends State<_HomeDashboard> {
  // Data dummy untuk item galeri dengan tanggal nyata (foto, video, catatan)
  // Setiap item memiliki ID unik untuk keperluan seleksi
  // Pastikan _galleryItems tidak const agar bisa diakses oleh GlobalKey.currentState
  final List<Map<String, dynamic>> _galleryItems = [
    // Data dummy Hari Ini (misal: 25 Juni 2025)
    {
      'id': 'item_001',
      'type': 'photo',
      'date': '2025-06-25',
      'url': 'https://placehold.co/200x200/cccccc/666666?text=Foto1',
    },
    {
      'id': 'item_002',
      'type': 'video',
      'date': '2025-06-25',
      'url': 'https://placehold.co/200x200/dddddd/555555?text=Video1',
    },
    {
      'id': 'item_003',
      'type': 'note',
      'date': '2025-06-25',
      'title': 'Rencana Hari Ini',
      'content': 'Meeting jam 10 pagi, belanja sore.',
    },
    {
      'id': 'item_004',
      'type': 'photo',
      'date': '2025-06-25',
      'url': 'https://placehold.co/200x200/eeeeee/444444?text=Foto2',
    },

    // Data dummy Kemarin (misal: 24 Juni 2025)
    {
      'id': 'item_005',
      'type': 'video',
      'date': '2025-06-24',
      'url': 'https://placehold.co/200x200/bbccdd/222222?text=Video2',
    },
    {
      'id': 'item_006',
      'type': 'photo',
      'date': '2025-06-24',
      'url': 'https://placehold.co/200x200/ccddeeff/111111?text=Foto4',
    },
    {
      'id': 'item_007',
      'type': 'note',
      'date': '2025-06-24',
      'title': 'Ide Aplikasi Baru',
      'content': 'Aplikasi untuk melacak kebiasaan.',
    },
    {
      'id': 'item_008',
      'type': 'photo',
      'date': '2025-06-24',
      'url': 'https://placehold.co/200x200/aaddgg/777777?text=Foto5',
    },

    // Data dummy Minggu Lalu (misal: 18 Juni 2025)
    {
      'id': 'item_009',
      'type': 'video',
      'date': '2025-06-18',
      'url': 'https://placehold.co/200x200/bbggrr/888888?text=Video3',
    },
    {
      'id': 'item_010',
      'type': 'photo',
      'date': '2025-06-18',
      'url': 'https://placehold.co/200x200/ffeecc/999999?text=Foto6',
    },
    {
      'id': 'item_011',
      'type': 'photo',
      'date': '2025-06-18',
      'url': 'https://placehold.co/200x200/ccffaa/aaaaaa?text=Foto7',
    },

    // Data dummy Bulan Lalu (misal: 25 Mei 2025)
    {
      'id': 'item_012',
      'type': 'photo',
      'date': '2025-05-25',
      'url': 'https://placehold.co/200x200/eeddcc/bbbbbb?text=Foto8',
    },
    {
      'id': 'item_013',
      'type': 'video',
      'date': '2025-05-25',
      'url': 'https://placehold.co/200x200/ddeeff/cccccc?text=Video4',
    },
    {
      'id': 'item_014',
      'type': 'note',
      'date': '2025-05-25',
      'title': 'Ringkasan Meeting',
      'content': 'Poin-poin penting dari rapat.',
    },
    {
      'id': 'item_015',
      'type': 'photo',
      'date': '2025-05-20',
      'url': 'https://placehold.co/200x200/ffffee/dddddd?text=Foto9',
    },
    {
      'id': 'item_016',
      'type': 'photo',
      'date': '2025-05-15',
      'url': 'https://placehold.co/200x200/eeffdd/eeeeee?text=Foto10',
    },
  ];

  @override
  void initState() {
    super.initState();
    // Menginisialisasi controller dengan selectedItems dan isSelectionMode dari widget
    widget.controller.selectedItems.value = {};
    widget.controller.isSelectionMode.value = false;
  }

  // Helper function untuk memformat tanggal berdasarkan relatif waktu
  String _formatDateGroup(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);

    final itemDate = DateTime(date.year, date.month, date.day);

    if (itemDate == today) {
      return 'Hari Ini';
    } else if (itemDate == yesterday) {
      return 'Kemarin';
    } else if (now.difference(date).inDays < 7) {
      return 'Minggu Lalu';
    } else if (now.difference(date).inDays < 30) {
      return 'Bulan Lalu';
    } else {
      return '${date.day} ${getMonthName(date.month)} ${date.year}';
    }
  }

  String getMonthName(int month) {
    switch (month) {
      case 1:
        return 'Januari';
      case 2:
        return 'Februari';
      case 3:
        return 'Maret';
      case 4:
        return 'April';
      case 5:
        return 'Mei';
      case 6:
        return 'Juni';
      case 7:
        return 'Juli';
      case 8:
        return 'Agustus';
      case 9:
        return 'September';
      case 10:
        return 'Oktober';
      case 11:
        return 'November';
      case 12:
        return 'Desember';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    // Kelompokkan item berdasarkan tanggal nyata
    final Map<String, List<Map<String, dynamic>>> groupedItems = {};
    // Urutkan item berdasarkan tanggal terbaru ke terlama
    final sortedGalleryItems = List<Map<String, dynamic>>.from(
      _galleryItems,
    )..sort(
      (a, b) => DateTime.parse(b['date']).compareTo(DateTime.parse(a['date'])),
    );

    for (var item in sortedGalleryItems) {
      final DateTime itemDateTime = DateTime.parse(item['date']);
      final String dateGroupKey = _formatDateGroup(itemDateTime);
      if (!groupedItems.containsKey(dateGroupKey)) {
        groupedItems[dateGroupKey] = [];
      }
      groupedItems[dateGroupKey]!.add(item);
    }

    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.all(16.0),
          sliver: SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.quote, // Kutipan inspiratif
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Theme.of(
                      context,
                    ).textTheme.bodyLarge?.color?.withOpacity(0.7),
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 20),
                // Pembungkus Material untuk TextField Search agar memiliki elevation
                Material(
                  elevation: 2, // Memberikan sedikit bayangan
                  borderRadius: BorderRadius.circular(12),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Cari foto, video, atau catatan...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor:
                          Theme.of(
                            context,
                          ).cardColor, // Menggunakan warna card/surface
                      contentPadding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Fitur pencarian belum diimplementasikan.',
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate((
            BuildContext context,
            int index,
          ) {
            final dateGroup = groupedItems.keys.elementAt(index);
            final itemsInGroup = groupedItems[dateGroup]!;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        dateGroup,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // Placeholder ikon ceklis untuk seleksi di level grup tanggal
                      IconButton(
                        icon: const Icon(Icons.check_circle_outline, size: 24),
                        color: Theme.of(
                          context,
                        ).iconTheme.color?.withOpacity(0.7),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Mengaktifkan seleksi untuk ${dateGroup}.',
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                ValueListenableBuilder<Set<String>>(
                  valueListenable: widget.controller.selectedItems,
                  builder: (context, selectedItems, child) {
                    return GridView.builder(
                      shrinkWrap:
                          true, // Untuk memastikan GridView dapat di-scroll bersama CustomScrollView
                      physics:
                          const NeverScrollableScrollPhysics(), // Nonaktifkan scrolling internal GridView
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3, // 3 kolom untuk media
                            crossAxisSpacing: 4.0,
                            mainAxisSpacing: 4.0,
                          ),
                      itemCount: itemsInGroup.length,
                      itemBuilder: (context, itemIndex) {
                        final item = itemsInGroup[itemIndex];
                        final String type = item['type'];
                        final String itemId = item['id'];
                        final bool isSelected = selectedItems.contains(itemId);

                        Widget contentWidget;
                        if (type == 'video') {
                          contentWidget = const Center(
                            child: Icon(
                              Icons.play_circle_filled,
                              color: Colors.white70,
                              size: 40,
                            ),
                          );
                        } else if (type == 'note') {
                          contentWidget = Container(
                            padding: const EdgeInsets.all(8.0),
                            alignment: Alignment.topLeft,
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor.withOpacity(
                                0.1,
                              ), // Background catatan
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.sticky_note_2_outlined,
                                  color: Theme.of(context).primaryColor,
                                  size: 20,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  item['title'],
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleSmall?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  item['content'],
                                  style: Theme.of(context).textTheme.bodySmall,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          );
                        } else {
                          // photo
                          contentWidget = Image.network(
                            item['url'],
                            fit: BoxFit.cover,
                            errorBuilder:
                                (context, error, stackTrace) => Center(
                                  child: Icon(
                                    Icons.image_not_supported,
                                    color: Theme.of(context).iconTheme.color,
                                  ),
                                ),
                          );
                        }

                        return Material(
                          // Membungkus item GridView dengan Material
                          elevation:
                              isSelected
                                  ? 4
                                  : 1, // Elevasi lebih tinggi jika terpilih
                          borderRadius: BorderRadius.circular(8),
                          clipBehavior:
                              Clip.antiAlias, // Penting untuk memastikan gambar terpotong rapi dengan border radius
                          child: GestureDetector(
                            onTap: () {
                              if (widget.controller.isSelectionMode.value) {
                                widget.controller.toggleSelection(itemId);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Membuka ${type} dari ${dateGroup}.',
                                    ),
                                  ),
                                );
                                if (type == 'note') {
                                  Navigator.pushNamed(
                                    context,
                                    '/note_editor',
                                    arguments: item,
                                  );
                                }
                              }
                            },
                            onLongPress: () {
                              widget.controller.toggleSelection(itemId);
                            },
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).cardColor,
                                    borderRadius: BorderRadius.circular(8),
                                    // Image DecorationImage perlu dihilangkan dari BoxDecoration jika contentWidget sudah menanganinya
                                    // Karena sudah ada Image.network di contentWidget, ini bisa dihapus atau dijaga agar tidak tumpang tindih
                                    image:
                                        (type == 'photo' || type == 'video') &&
                                                !isSelected
                                            ? DecorationImage(
                                              // Hanya jika bukan mode seleksi
                                              image: NetworkImage(item['url']),
                                              fit: BoxFit.cover,
                                            )
                                            : null,
                                  ),
                                  child: contentWidget,
                                ),
                                if (isSelected)
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Theme.of(
                                        context,
                                      ).primaryColor.withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: Theme.of(context).primaryColor,
                                        width: 3,
                                      ),
                                    ),
                                    child: const Align(
                                      alignment: Alignment.topLeft,
                                      child: Padding(
                                        padding: EdgeInsets.all(4.0),
                                        child: Icon(
                                          Icons.check_circle,
                                          color: Colors.white,
                                          size: 24,
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            );
          }, childCount: groupedItems.length),
        ),
      ],
    );
  }
}
