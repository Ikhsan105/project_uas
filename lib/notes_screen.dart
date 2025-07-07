// lib/screens/notes_screen.dart

import 'package:flutter/material.dart';
import 'package:project_ambtron/api/database_service.dart'; // <-- IMPORT SERVICE

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => NotesScreenState();
}

class NotesScreenState extends State<NotesScreen> {
  // Hapus list _notes yang hardcoded
  final DatabaseService _dbService =
      DatabaseService(); // <-- Buat instance service

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _dbService.getNotes(), // <-- Panggil fungsi untuk mengambil data
      builder: (context, snapshot) {
        // Saat data sedang dimuat, tampilkan loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        // Jika ada error
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        // Jika tidak ada data atau data kosong
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('Belum ada catatan.'));
        }

        // Jika data berhasil diambil
        final notes = snapshot.data!;

        return ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: notes.length,
          itemBuilder: (context, index) {
            final note = notes[index];
            return Card(
              margin: const EdgeInsets.only(bottom: 10),
              child: ListTile(
                leading: Icon(
                  Icons.sticky_note_2_outlined,
                  color: Theme.of(context).primaryColor,
                ),
                title: Text(note['title'] ?? 'Tanpa Judul'),
                subtitle: Text(
                  // Menampilkan tanggal dan sedikit konten
                  '${note['created_at']} - ${note['content'] ?? ''}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.more_vert),
                  onPressed: () {
                    // Fitur menu bisa ditambahkan nanti
                  },
                ),
                onTap: () {
                  // Navigasi ke editor catatan
                  // Kita akan perbaiki ini nanti
                },
              ),
            );
          },
        );
      },
    );
  }
}
