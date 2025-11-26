import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../audio_provider.dart';
import '../widgets/album_art_widget.dart';
import '../widgets/play_pause_button.dart';
import '../widgets/seek_bar_widget.dart';
import 'home_screen.dart';

class PlayerScreen extends StatelessWidget {
  const PlayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Now Playing"),
        actions: [
          IconButton(
            icon: const Icon(Icons.library_music),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const HomeScreen()),
              );
            },
          )
        ],
      ),
      body: Consumer<AudioProvider>(
        builder: (context, audio, _) {
          return Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AlbumArtWidget(albumArt: audio.albumArt),
                const SizedBox(height: 20),
                Text(audio.title,
                    style:
                        const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text(audio.artist, style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 20),
                PlayPauseButton(isPlaying: audio.isPlaying, onTap: audio.playPause),
                const SizedBox(height: 20),
                SeekBarWidget(
                  position: audio.position,
                  duration: audio.duration,
                  onChanged: audio.seek,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
