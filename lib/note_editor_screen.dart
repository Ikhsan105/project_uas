// lib/screens/note_editor_screen.dart

import 'package:flutter/material.dart';
import 'package:project_ambtron/api/database_service.dart';
import 'package:go_router/go_router.dart';

class NoteEditorScreen extends StatefulWidget {
  const NoteEditorScreen({super.key});

  @override
  State<NoteEditorScreen> createState() => _NoteEditorScreenState();
}

class _NoteEditorScreenState extends State<NoteEditorScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final DatabaseService _dbService = DatabaseService();
  bool _isLoading = false;

  void _saveNote() async {
    if (_isLoading) return;

    setState(() => _isLoading = true);

    final title = _titleController.text.trim();
    final content = _contentController.text.trim();

    if (title.isNotEmpty) {
      await _dbService.addNote(title: title, content: content);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Catatan "$title" disimpan.'),
          backgroundColor: Colors.green,
        ),
      );
      if (mounted) context.pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Judul tidak boleh kosong.'),
          backgroundColor: Colors.red,
        ),
      );
    }

    if (mounted) setState(() => _isLoading = false);
  }

  // --- BAGIAN YANG PERLU DITAMBAHKAN KEMBALI ---
  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catatan Baru'),
        // Hubungkan tombol simpan dengan logika baru kita
        actions: [
          IconButton(
            icon:
                _isLoading
                    ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2.0,
                      ),
                    )
                    : const Icon(Icons.check),
            onPressed: _saveNote,
            tooltip: 'Simpan Catatan',
          ),
        ],
      ),
      // Tampilan UI ini sama seperti yang sudah kamu buat sebelumnya
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                hintText: 'Judul Catatan',
                border: InputBorder.none,
              ),
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const Divider(height: 20, thickness: 1),
            Expanded(
              child: TextField(
                controller: _contentController,
                decoration: const InputDecoration(
                  hintText: 'Mulai tulis catatan Anda di sini...',
                  border: InputBorder.none,
                ),
                keyboardType: TextInputType.multiline,
                maxLines: null,
                expands: true,
                textAlignVertical: TextAlignVertical.top,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
