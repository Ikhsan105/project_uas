import 'package:flutter/material.dart';
import 'note_editor_screen.dart';

// Ini adalah layar generik untuk menampilkan daftar konten berdasarkan tipe
class TypedContentListScreen extends StatefulWidget {
  // contentType bisa berupa 'photo', 'video', 'note', 'trash', atau 'all'
  final String contentType;
  final String appBarTitle;

  const TypedContentListScreen({
    Key? key,
    required this.contentType,
    required this.appBarTitle,
  }) : super(key: key);

  @override
  State<TypedContentListScreen> createState() => _TypedContentListScreenState();
}

class _TypedContentListScreenState extends State<TypedContentListScreen> {
  // Data dummy yang sama dengan _HomeDashboard untuk konsistensi
  // Dalam aplikasi nyata, data ini akan diambil dari backend dan difilter
  final List<Map<String, dynamic>> _allItems = [
    // Data dummy Foto
    {
      'id': 'photo_001',
      'type': 'photo',
      'date': '2025-06-25',
      'url': 'https://placehold.co/200x200/cccccc/666666?text=Foto1',
    },
    {
      'id': 'photo_002',
      'type': 'photo',
      'date': '2025-06-24',
      'url': 'https://placehold.co/200x200/eeeeee/444444?text=Foto2',
    },
    {
      'id': 'photo_003',
      'type': 'photo',
      'date': '2025-06-20',
      'url': 'https://placehold.co/200x200/aabbcc/333333?text=Foto3',
    },
    {
      'id': 'photo_004',
      'type': 'photo',
      'date': '2025-06-18',
      'url': 'https://placehold.co/200x200/ccddeeff/111111?text=Foto4',
    },
    {
      'id': 'photo_005',
      'type': 'photo',
      'date': '2025-05-25',
      'url': 'https://placehold.co/200x200/aaddgg/777777?text=Foto5',
    },

    // Data dummy Video
    {
      'id': 'video_001',
      'type': 'video',
      'date': '2025-06-25',
      'url': 'https://placehold.co/200x200/dddddd/555555?text=Video1',
    },
    {
      'id': 'video_002',
      'type': 'video',
      'date': '2025-06-24',
      'url': 'https://placehold.co/200x200/bbccdd/222222?text=Video2',
    },
    {
      'id': 'video_003',
      'type': 'video',
      'date': '2025-06-18',
      'url': 'https://placehold.co/200x200/bbggrr/888888?text=Video3',
    },
    {
      'id': 'video_004',
      'type': 'video',
      'date': '2025-05-25',
      'url': 'https://placehold.co/200x200/ddeeff/cccccc?text=Video4',
    },

    // Data dummy Catatan
    {
      'id': 'note_001',
      'type': 'note',
      'date': '2025-06-25',
      'title': 'Rencana Hari Ini',
      'content': 'Meeting jam 10 pagi, belanja sore.',
    },
    {
      'id': 'note_002',
      'type': 'note',
      'date': '2025-06-24',
      'title': 'Ide Aplikasi Baru',
      'content': 'Aplikasi untuk melacak kebiasaan.',
    },
    {
      'id': 'note_003',
      'type': 'note',
      'date': '2025-05-25',
      'title': 'Ringkasan Meeting',
      'content': 'Poin-poin penting dari rapat.',
    },

    // Data dummy Sampah (contoh item yang dihapus)
    {
      'id': 'trash_001',
      'type': 'photo',
      'date': '2025-06-23',
      'url': 'https://placehold.co/200x200/ff0000/ffffff?text=Trash1',
      'is_deleted': true,
    },
    {
      'id': 'trash_002',
      'type': 'note',
      'date': '2025-06-22',
      'title': 'Catatan Lama',
      'content': 'Ini catatan yang sudah dihapus.',
      'is_deleted': true,
    },
  ];

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
    // Filter item berdasarkan contentType
    List<Map<String, dynamic>> filteredItems = [];
    if (widget.contentType == 'all') {
      // Untuk kasus melihat semua media (gabungan foto, video, catatan)
      filteredItems =
          _allItems
              .where(
                (item) =>
                    item['type'] != 'trash' && !(item['is_deleted'] ?? false),
              )
              .toList();
    } else if (widget.contentType == 'media') {
      // Hanya foto dan video
      filteredItems =
          _allItems
              .where(
                (item) =>
                    (item['type'] == 'photo' || item['type'] == 'video') &&
                    !(item['is_deleted'] ?? false),
              )
              .toList();
    } else if (widget.contentType == 'trash') {
      filteredItems =
          _allItems.where((item) => item['is_deleted'] == true).toList();
    } else {
      filteredItems =
          _allItems
              .where(
                (item) =>
                    item['type'] == widget.contentType &&
                    !(item['is_deleted'] ?? false),
              )
              .toList();
    }

    // Urutkan item berdasarkan tanggal terbaru ke terlama
    final sortedFilteredItems = List<Map<String, dynamic>>.from(
      filteredItems,
    )..sort(
      (a, b) => DateTime.parse(b['date']).compareTo(DateTime.parse(a['date'])),
    );

    // Kelompokkan item berdasarkan tanggal nyata
    final Map<String, List<Map<String, dynamic>>> groupedItems = {};
    for (var item in sortedFilteredItems) {
      final DateTime itemDateTime = DateTime.parse(item['date']);
      final String dateGroupKey = _formatDateGroup(itemDateTime);
      if (!groupedItems.containsKey(dateGroupKey)) {
        groupedItems[dateGroupKey] = [];
      }
      groupedItems[dateGroupKey]!.add(item);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.appBarTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Fitur pencarian di layar ini belum diimplementasikan.',
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body:
          groupedItems.isEmpty
              ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.folder_open,
                      size: 80,
                      color: Theme.of(
                        context,
                      ).iconTheme.color?.withOpacity(0.5),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Tidak ada ${widget.appBarTitle.toLowerCase()} ditemukan',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Theme.of(
                          context,
                        ).textTheme.titleLarge?.color?.withOpacity(0.7),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              )
              : CustomScrollView(
                slivers: [
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
                            padding: const EdgeInsets.fromLTRB(
                              16.0,
                              16.0,
                              16.0,
                              8.0,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  dateGroup,
                                  style: Theme.of(context).textTheme.titleLarge
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.check_circle_outline,
                                    size: 24,
                                  ),
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
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 4.0,
                                  mainAxisSpacing: 4.0,
                                ),
                            itemCount: itemsInGroup.length,
                            itemBuilder: (context, itemIndex) {
                              final item = itemsInGroup[itemIndex];
                              final String type = item['type'];
                              // String itemId = item['id']; // Tidak digunakan untuk seleksi di layar ini
                              // bool isSelected = false; // Mode seleksi tidak aktif di sini secara default

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
                                    color: Theme.of(
                                      context,
                                    ).primaryColor.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                        style:
                                            Theme.of(
                                              context,
                                            ).textTheme.bodySmall,
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
                                          color:
                                              Theme.of(context).iconTheme.color,
                                        ),
                                      ),
                                );
                              }

                              return Material(
                                elevation: 1, // Elevasi standar
                                borderRadius: BorderRadius.circular(8),
                                clipBehavior: Clip.antiAlias,
                                child: GestureDetector(
                                  onTap: () {
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
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).cardColor,
                                      borderRadius: BorderRadius.circular(8),
                                      image:
                                          (type == 'photo' || type == 'video')
                                              ? DecorationImage(
                                                image: NetworkImage(
                                                  item['url'],
                                                ),
                                                fit: BoxFit.cover,
                                              )
                                              : null,
                                    ),
                                    child: contentWidget,
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      );
                    }, childCount: groupedItems.length),
                  ),
                ],
              ),
    );
  }
}
