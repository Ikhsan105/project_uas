// lib/api/storage_service.dart

import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class StorageService {
  final _supabase = Supabase.instance.client;

  Future<String?> uploadImage() async {
    final picker = ImagePicker();
    final imageFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (imageFile == null) {
      return null;
    }

    final fileName = '${DateTime.now().toIso8601String()}-${imageFile.name}';
    final filePath = '${_supabase.auth.currentUser!.id}/$fileName';

    try {
      // Hanya fokus untuk upload file, tidak ada lagi insert ke database dari sini.
      if (kIsWeb) {
        final imageBytes = await imageFile.readAsBytes();
        await _supabase.storage
            .from('user-photos')
            .uploadBinary(
              filePath,
              imageBytes,
              fileOptions: FileOptions(contentType: imageFile.mimeType),
            );
      } else {
        final file = File(imageFile.path);
        await _supabase.storage.from('user-photos').upload(filePath, file);
      }

      // Kembalikan path file sebagai tanda berhasil
      return filePath;
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }
}
