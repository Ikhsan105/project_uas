// lib/api/database_service.dart

import 'package:supabase_flutter/supabase_flutter.dart';

class DatabaseService {
  final _supabase = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> getPhotos() async {
    try {
      final userId = _supabase.auth.currentUser!.id;
      final photosResponse = await _supabase
          .from('photos')
          .select()
          .eq('user_id', userId)
          .order('created_at', ascending: false); // Urutkan dari yang terbaru

      final List<Map<String, dynamic>> photosWithUrls = [];
      for (var photo in photosResponse) {
        final publicUrl = _supabase.storage
            .from('user-photos')
            .getPublicUrl(photo['path']);

        photosWithUrls.add({...photo, 'file_url': publicUrl});
      }

      return photosWithUrls;
    } catch (e) {
      print('Error getting photos: $e');
      return [];
    }
  }


  Future<List<Map<String, dynamic>>> getNotes() async {
    try {
      final userId = _supabase.auth.currentUser!.id;
      final data = await _supabase.from('notes').select().eq('user_id', userId);
      return data;
    } catch (e) {
      print('Error getting notes: $e');
      return [];
    }
  }

  Future<void> addNote({required String title, required String content}) async {
    try {
      await _supabase.from('notes').insert({
        'title': title,
        'content': content,
        'user_id': _supabase.auth.currentUser!.id,
      });
    } catch (e) {
      print('Error adding note: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getGalleryItems() async {
    try {
      final userId = _supabase.auth.currentUser!.id;
      final notes = await _supabase
          .from('notes')
          .select()
          .eq('user_id', userId);

      final photosResponse = await _supabase
          .from('photos')
          .select()
          .eq('user_id', userId);

      final List<Map<String, dynamic>> photosWithUrls = [];
      for (var photo in photosResponse) {
        final publicUrl = _supabase.storage
            .from('user-photos') // Pastikan nama bucket benar
            .getPublicUrl(photo['path']); // Gunakan kolom 'path'

        photosWithUrls.add({...photo, 'file_url': publicUrl});
      }

      final allItems = [...notes, ...photosWithUrls];

      allItems.sort(
        (a, b) => DateTime.parse(
          b['created_at'],
        ).compareTo(DateTime.parse(a['created_at'])),
      );

      return allItems;
    } catch (e) {
      print('Error getting gallery items: $e');
      return [];
    }
  }

  Future<Map<String, dynamic>?> getProfile() async {
    try {
      final userId = _supabase.auth.currentUser!.id;
      final data =
          await _supabase.from('profiles').select().eq('id', userId).single();
      return data;
    } catch (e) {
      print('Error getting profile: $e');
      return null;
    }
  }

  Future<void> deleteNote(String noteId) async {
    try {
      await _supabase.from('notes').delete().eq('id', noteId);
    } catch (e) {
      print('Error deleting note: $e');
    }
  }

  Future<void> deletePhoto(String photoId, String photoPath) async {
    try {
      await _supabase.storage.from('user-photos').remove([photoPath]);
      await _supabase.from('photos').delete().eq('id', photoId);
    } catch (e) {
      print('Error deleting photo: $e');
    }
  }

  // --- FUNGSI BARU UNTUK UPDATE PROFIL ---
  Future<void> updateProfile({
    required String username,
    String? avatarUrl, // Dibuat opsional
  }) async {
    try {
      final userId = _supabase.auth.currentUser!.id;
      final updates = {
        'username': username,
        'updated_at': DateTime.now().toIso8601String(),
      };

      // Hanya tambahkan avatar_url ke dalam map jika nilainya tidak null
      if (avatarUrl != null) {
        updates['avatar_url'] = avatarUrl;
      }

      await _supabase.from('profiles').update(updates).eq('id', userId);
    } catch (e) {
      print('Error updating profile: $e');
      // Lemparkan error agar UI bisa tahu jika ada masalah
      throw Exception('Gagal memperbarui profil.');
    }
  }
}
