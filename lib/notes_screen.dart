import 'package:flutter/material.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => NotesScreenState(); // Perbaikan di sini
}

class NotesScreenState extends State<NotesScreen> {
  // Perbaikan di sini, hapus underscore
  // Data dummy untuk catatan
  final List<Map<String, String>> _notes = [
    {
      'title': 'Rencana Proyek Alpha',
      'date': '12 Juni 2024',
      'content': 'Detail perencanaan untuk fase awal proyek Alpha...',
    },
    {
      'title': 'Daftar Tugas Mingguan',
      'date': '10 Juni 2024',
      'content': 'Belanja, gym, email ke klien, siapkan presentasi...',
    },
    {
      'title': 'Resep Baru',
      'date': '05 Juni 2024',
      'content': 'Bahan: Ayam, bawang, jahe, kecap. Cara membuat...',
    },
    {
      'title': 'Ide Liburan',
      'date': '01 Juni 2024',
      'content': 'Tempat: Bali, Raja Ampat. Aktivitas: Snorkeling, hiking...',
    },
    {
      'title': 'Catatan Rapat Pemasaran',
      'date': '28 Mei 2024',
      'content': 'Diskusi strategi pemasaran digital baru...',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: _notes.length,
      itemBuilder: (context, index) {
        final note = _notes[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 10),
          child: ListTile(
            leading: Icon(
              Icons.sticky_note_2_outlined,
              color: Theme.of(context).primaryColor,
            ),
            title: Text(note['title']!),
            subtitle: Text(
              '${note['date']} - ${note['content']!.substring(0, note['content']!.length > 50 ? 50 : note['content']!.length)}...',
            ),
            trailing: IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () {
                _showNoteContextMenu(context, note);
              },
            ),
            onTap: () {
              // Navigasi ke layar editor catatan
              Navigator.pushNamed(context, '/note_editor', arguments: note);
            },
          ),
        );
      },
    );
  }

  // Fungsi untuk menampilkan menu konteks catatan
  void _showNoteContextMenu(BuildContext context, Map<String, String> note) {
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
                  note['title']!,
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Edit Catatan'),
              onTap: () {
                Navigator.pop(bc);
                Navigator.pushNamed(
                  context,
                  '/note_editor',
                  arguments: note,
                ); // Navigasi ke editor
              },
            ),
            ListTile(
              leading: const Icon(Icons.share),
              title: const Text('Bagikan'),
              onTap: () {
                Navigator.pop(bc);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Berbagi catatan "${note['title']}".'),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete_outline, color: Colors.red),
              title: const Text('Hapus', style: TextStyle(color: Colors.red)),
              onTap: () {
                Navigator.pop(bc);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Menghapus catatan "${note['title']}".'),
                  ),
                );
                // Di sini Anda akan menghapus catatan dari daftar _notes
                setState(() {
                  _notes.remove(note);
                });
              },
            ),
          ],
        );
      },
    );
  }
}
