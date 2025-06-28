import 'package:flutter/material.dart';

class PhotosScreen extends StatelessWidget {
  const PhotosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(8.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // 3 kolom untuk galeri foto
        crossAxisSpacing: 4.0,
        mainAxisSpacing: 4.0,
      ),
      itemCount: 30, // Contoh 30 gambar dummy
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            // Tampilkan pratinjau gambar layar penuh
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Melihat foto ${index + 1}.')),
            );
          },
          child: Hero(
            // Hero animation for smooth transition
            tag: 'photo$index',
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: NetworkImage(
                    'https://placehold.co/200x200/${Theme.of(context).brightness == Brightness.light ? 'cccccc' : '444444'}/${Theme.of(context).brightness == Brightness.light ? '666666' : 'aaaaaa'}?text=Foto${index + 1}',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    '${index + 1}',
                    style: TextStyle(
                      color: Theme.of(context).cardColor,
                      backgroundColor: Colors.black54,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
