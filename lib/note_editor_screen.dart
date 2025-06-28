import 'package:flutter/material.dart';

// Ini adalah placeholder untuk layar editor catatan dengan rich text capabilities di masa depan.
class NoteEditorScreen extends StatefulWidget {
  final Map<String, String>?
  note; // Menerima data catatan opsional untuk mode edit

  const NoteEditorScreen({super.key, this.note});

  @override
  State<NoteEditorScreen> createState() => _NoteEditorScreenState();
}

class _NoteEditorScreenState extends State<NoteEditorScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      _titleController.text = widget.note!['title'] ?? '';
      _contentController.text = widget.note!['content'] ?? '';
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _saveNote() {
    final title = _titleController.text;
    final content = _contentController.text;

    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Judul catatan tidak boleh kosong.')),
      );
      return;
    }

    // Logika penyimpanan catatan (placeholder)
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Catatan "${title}" disimpan.')));
    Navigator.pop(context); // Kembali setelah menyimpan
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.note == null ? 'Catatan Baru' : 'Edit Catatan'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check), // Ikon untuk menyimpan
            onPressed: _saveNote,
            tooltip: 'Simpan Catatan',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                hintText: 'Judul Catatan',
                border:
                    InputBorder.none, // Tanpa border untuk tampilan yang bersih
                contentPadding: EdgeInsets.zero,
              ),
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
              maxLines: 1,
            ),
            const Divider(height: 20, thickness: 1),
            Expanded(
              child: TextField(
                controller: _contentController,
                decoration: const InputDecoration(
                  hintText: 'Mulai tulis catatan Anda di sini...',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                ),
                keyboardType: TextInputType.multiline,
                maxLines: null, // Memungkinkan banyak baris
                expands:
                    true, // Memungkinkan TextField untuk mengisi ruang yang tersedia
                textAlignVertical: TextAlignVertical.top,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            // Di sini Anda bisa menambahkan toolbar rich text di masa depan
            // Contoh placeholder toolbar
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    onPressed: () {
                      /* Bold */
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Format tebal belum aktif.'),
                        ),
                      );
                    },
                    icon: const Icon(Icons.format_bold),
                  ),
                  IconButton(
                    onPressed: () {
                      /* Italic */
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Format miring belum aktif.'),
                        ),
                      );
                    },
                    icon: const Icon(Icons.format_italic),
                  ),
                  IconButton(
                    onPressed: () {
                      /* Underline */
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Format garis bawah belum aktif.'),
                        ),
                      );
                    },
                    icon: const Icon(Icons.format_underlined),
                  ),
                  IconButton(
                    onPressed: () {
                      /* List */
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Daftar belum aktif.')),
                      );
                    },
                    icon: const Icon(Icons.format_list_bulleted),
                  ),
                  IconButton(
                    onPressed: () {
                      /* Add Image */
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Sisipkan gambar belum aktif.'),
                        ),
                      );
                    },
                    icon: const Icon(Icons.image),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
