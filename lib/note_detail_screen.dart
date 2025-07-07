// lib/note_detail_screen.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NoteDetailScreen extends StatelessWidget {
  final Map<String, dynamic> note;

  const NoteDetailScreen({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    final title = note['title'] ?? 'Tanpa Judul';
    final content = note['content'] ?? 'Tidak ada konten.';
    final createdDate = DateFormat(
      'EEEE, d MMMM yyyy, HH:mm', 'id_ID' // Tambahkan locale Indonesia
    ).format(DateTime.parse(note['created_at']).toLocal());

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              'Dibuat pada: $createdDate',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16),
            SelectableText(
              content,
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}