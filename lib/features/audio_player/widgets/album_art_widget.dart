import 'dart:typed_data';
import 'package:flutter/material.dart';

class AlbumArtWidget extends StatelessWidget {
  final Uint8List? albumArt;
  const AlbumArtWidget({super.key, this.albumArt});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.grey[300],
        image: albumArt != null
            ? DecorationImage(
                image: MemoryImage(albumArt!),
                fit: BoxFit.cover,
              )
            : null,
      ),
      child: albumArt == null
          ? const Icon(Icons.music_note, size: 100, color: Colors.white70)
          : null,
    );
  }
}
