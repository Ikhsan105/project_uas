import 'package:flutter/material.dart';

class FilesScreen extends StatefulWidget {
  const FilesScreen({super.key});

  @override
  State<FilesScreen> createState() => _FilesScreenState();
}

class _FilesScreenState extends State<FilesScreen> {
  bool _isGridView = true; // State untuk toggle tampilan grid/list

  // Data dummy untuk file dan folder
  final List<Map<String, dynamic>> _items = [
    {'name': 'Dokumen', 'type': 'folder', 'icon': Icons.folder},
    {'name': 'Gambar', 'type': 'folder', 'icon': Icons.folder},
    {'name': 'Video', 'type': 'folder', 'icon': Icons.folder},
    {
      'name': 'Laporan Akhir.pdf',
      'type': 'file',
      'icon': Icons.picture_as_pdf,
      'size': '2.5 MB',
    },
    {
      'name': 'Meeting Notes.txt',
      'type': 'file',
      'icon': Icons.text_snippet,
      'size': '0.1 MB',
    },
    {
      'name': 'Proyek 2024.zip',
      'type': 'file',
      'icon': Icons.archive,
      'size': '15.3 MB',
    },
    {
      'name': 'Presentasi Q3.pptx',
      'type': 'file',
      'icon': Icons.slideshow,
      'size': '5.8 MB',
    },
    {
      'name': 'Spreadsheet Keuangan.xlsx',
      'type': 'file',
      'icon': Icons.table_chart,
      'size': '1.2 MB',
    },
    {'name': 'Folder Penting', 'type': 'folder', 'icon': Icons.folder},
    {
      'name': 'Rekaman Suara.mp3',
      'type': 'file',
      'icon': Icons.audio_file,
      'size': '3.1 MB',
    },
  ];

  // Mendapatkan ikon berdasarkan tipe file
  IconData _getFileIcon(String fileName) {
    final lowerCaseFileName = fileName.toLowerCase();
    if (lowerCaseFileName.endsWith('.pdf')) {
      return Icons.picture_as_pdf;
    } else if (lowerCaseFileName.endsWith('.doc') ||
        lowerCaseFileName.endsWith('.docx')) {
      return Icons.description;
    } else if (lowerCaseFileName.endsWith('.xls') ||
        lowerCaseFileName.endsWith('.xlsx')) {
      return Icons.table_chart;
    } else if (lowerCaseFileName.endsWith('.ppt') ||
        lowerCaseFileName.endsWith('.pptx')) {
      return Icons.slideshow;
    } else if (lowerCaseFileName.endsWith('.zip') ||
        lowerCaseFileName.endsWith('.rar')) {
      return Icons.archive;
    } else if (lowerCaseFileName.endsWith('.jpg') ||
        lowerCaseFileName.endsWith('.png') ||
        lowerCaseFileName.endsWith('.gif')) {
      return Icons.image;
    } else if (lowerCaseFileName.endsWith('.mp4') ||
        lowerCaseFileName.endsWith('.avi') ||
        lowerCaseFileName.endsWith('.mov')) {
      return Icons.videocam;
    } else if (lowerCaseFileName.endsWith('.mp3') ||
        lowerCaseFileName.endsWith('.wav')) {
      return Icons.audio_file;
    } else if (lowerCaseFileName.endsWith('.txt')) {
      return Icons.text_snippet;
    }
    return Icons.insert_drive_file; // Ikon default untuk file tidak dikenal
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: Icon(_isGridView ? Icons.view_list : Icons.grid_view),
                onPressed: () {
                  setState(() {
                    _isGridView = !_isGridView; // Toggle tampilan
                  });
                },
                tooltip:
                    _isGridView
                        ? 'Ubah ke Tampilan Daftar'
                        : 'Ubah ke Tampilan Grid',
              ),
            ],
          ),
        ),
        Expanded(
          child:
              _isGridView
                  ? GridView.builder(
                    padding: const EdgeInsets.all(16.0),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // 2 kolom dalam grid
                          crossAxisSpacing: 16.0,
                          mainAxisSpacing: 16.0,
                          childAspectRatio: 0.9, // Rasio aspek untuk item grid
                        ),
                    itemCount: _items.length,
                    itemBuilder: (context, index) {
                      final item = _items[index];
                      return _buildGridItem(context, item);
                    },
                  )
                  : ListView.builder(
                    padding: const EdgeInsets.all(16.0),
                    itemCount: _items.length,
                    itemBuilder: (context, index) {
                      final item = _items[index];
                      return _buildListItem(context, item);
                    },
                  ),
        ),
      ],
    );
  }

  // Widget untuk item dalam tampilan Grid
  Widget _buildGridItem(BuildContext context, Map<String, dynamic> item) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Membuka ${item['name']}.')));
        },
        onLongPress: () {
          // Tampilkan menu konteks untuk opsi file/folder
          _showFileContextMenu(context, item);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              item['type'] == 'folder'
                  ? item['icon']
                  : _getFileIcon(item['name']),
              size: 60,
              color:
                  item['type'] == 'folder'
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).iconTheme.color,
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                item['name'],
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
            if (item['type'] == 'file' && item['size'] != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  item['size'],
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(
                      context,
                    ).textTheme.bodySmall?.color?.withOpacity(0.7),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // Widget untuk item dalam tampilan Daftar
  Widget _buildListItem(BuildContext context, Map<String, dynamic> item) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: Icon(
          item['type'] == 'folder' ? item['icon'] : _getFileIcon(item['name']),
          color:
              item['type'] == 'folder'
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).iconTheme.color,
        ),
        title: Text(item['name']),
        subtitle:
            item['type'] == 'file' && item['size'] != null
                ? Text(item['size'])
                : null,
        trailing: IconButton(
          icon: const Icon(Icons.more_vert),
          onPressed: () {
            _showFileContextMenu(context, item);
          },
        ),
        onTap: () {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Membuka ${item['name']}.')));
        },
      ),
    );
  }

  // Fungsi untuk menampilkan menu konteks (long press atau ikon more_vert)
  void _showFileContextMenu(BuildContext context, Map<String, dynamic> item) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (BuildContext bc) {
        return Wrap(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Text(
                  item['name'],
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.open_in_new),
              title: const Text('Buka'),
              onTap: () {
                Navigator.pop(bc);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Membuka ${item['name']}.')),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Ganti Nama'),
              onTap: () {
                Navigator.pop(bc);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Mengganti nama ${item['name']}.')),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.drive_file_move),
              title: const Text('Pindahkan'),
              onTap: () {
                Navigator.pop(bc);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Memindahkan ${item['name']}.')),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.content_copy),
              title: const Text('Salin'),
              onTap: () {
                Navigator.pop(bc);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Menyalin ${item['name']}.')),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.share),
              title: const Text('Bagikan'),
              onTap: () {
                Navigator.pop(bc);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Berbagi ${item['name']}.')),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete_outline, color: Colors.red),
              title: const Text('Hapus', style: TextStyle(color: Colors.red)),
              onTap: () {
                Navigator.pop(bc);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Menghapus ${item['name']}.')),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
