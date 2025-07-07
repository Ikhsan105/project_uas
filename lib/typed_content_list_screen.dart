// lib/typed_content_list_screen.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:project_ambtron/api/database_service.dart';

class TypedContentListScreen extends StatefulWidget {
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
  // 1. Buat instance dari DatabaseService
  final DatabaseService _dbService = DatabaseService();
  late Future<List<Map<String, dynamic>>> _contentFuture;

  @override
  void initState() {
    super.initState();
    // 2. Panggil fungsi untuk mengambil data saat halaman pertama kali dimuat
    _contentFuture = _fetchContent();
  }

  // 3. Fungsi untuk menentukan data apa yang harus diambil
  Future<List<Map<String, dynamic>>> _fetchContent() {
    switch (widget.contentType) {
      case 'photo':
        return _dbService.getPhotos(); // Fungsi baru di DatabaseService
      case 'note':
        return _dbService.getNotes(); // Menggunakan fungsi yang sudah ada
      case 'video':
        // Untuk video, kita kembalikan list kosong karena belum diimplementasikan
        return Future.value([]); 
      case 'trash':
         // Untuk sampah, kita kembalikan list kosong karena belum diimplementasikan
        return Future.value([]);
      default:
        return _dbService.getGalleryItems(); // Untuk 'all' atau lainnya
    }
  }

  String _formatDateGroup(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    final itemDate = DateTime(date.year, date.month, date.day);

    if (itemDate == today) return 'Hari Ini';
    if (itemDate == yesterday) return 'Kemarin';
    if (now.difference(date).inDays < 7) return 'Minggu Lalu';
    if (now.difference(date).inDays < 30) return 'Bulan Lalu';
    return DateFormat('d MMMM yyyy', 'id_ID').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.appBarTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Fitur pencarian di layar ini belum diimplementasikan.'),
                ),
              );
            },
          ),
        ],
      ),
      // 4. Ganti body dengan FutureBuilder
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _contentFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.folder_open,
                    size: 80,
                    color: Theme.of(context).iconTheme.color?.withOpacity(0.5),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Tidak ada ${widget.appBarTitle.toLowerCase()} ditemukan',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Theme.of(context).textTheme.titleLarge?.color?.withOpacity(0.7),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }

          final items = snapshot.data!;
          // Kelompokkan item berdasarkan tanggal
          final Map<String, List<Map<String, dynamic>>> groupedItems = {};
          for (var item in items) {
            final DateTime itemDateTime = DateTime.parse(item['created_at']);
            final String dateGroupKey = _formatDateGroup(itemDateTime);
            if (!groupedItems.containsKey(dateGroupKey)) {
              groupedItems[dateGroupKey] = [];
            }
            groupedItems[dateGroupKey]!.add(item);
          }

          return CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    final dateGroup = groupedItems.keys.elementAt(index);
                    final itemsInGroup = groupedItems[dateGroup]!;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
                          child: Text(
                            dateGroup,
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        GridView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 4.0,
                            mainAxisSpacing: 4.0,
                          ),
                          itemCount: itemsInGroup.length,
                          itemBuilder: (context, itemIndex) {
                            final item = itemsInGroup[itemIndex];
                            // Tentukan tipe berdasarkan data yang ada
                            final String type = item.containsKey('content') ? 'note' : 'photo';

                            return buildGridItem(context, item, type);
                          },
                        ),
                      ],
                    );
                  },
                  childCount: groupedItems.length,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget buildGridItem(BuildContext context, Map<String, dynamic> item, String type) {
    Widget contentWidget;
    if (type == 'photo') {
      final imageUrl = item['file_url'];
      contentWidget = (imageUrl != null && imageUrl.isNotEmpty)
          ? Image.network(
              imageUrl,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return const Center(child: CircularProgressIndicator(strokeWidth: 2.0));
              },
              errorBuilder: (context, error, stackTrace) =>
                  const Center(child: Icon(Icons.broken_image, color: Colors.red)),
            )
          : Container(color: Colors.grey[300], child: const Icon(Icons.image));
    } else { // type == 'note'
      contentWidget = Container(
        padding: const EdgeInsets.all(8.0),
        alignment: Alignment.topLeft,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.sticky_note_2_outlined, color: Theme.of(context).primaryColor, size: 20),
            const SizedBox(height: 4),
            Text(
              item['title'],
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );
    }

    return Material(
      elevation: 1,
      borderRadius: BorderRadius.circular(8),
      clipBehavior: Clip.antiAlias,
      child: GestureDetector(
        onTap: () {
          if (type == 'note') {
            context.pushNamed('note-detail', extra: item);
          } else if (type == 'photo') {
            final imageUrl = item['file_url'];
            if (imageUrl != null) {
              context.pushNamed('photo-view', extra: imageUrl);
            }
          }
        },
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: contentWidget,
        ),
      ),
    );
  }
}