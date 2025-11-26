import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../audio_provider.dart';
import 'player_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final audioProvider = Provider.of<AudioProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Local Music Player"),
        centerTitle: true,
      ),
      body: Center(
        child: ElevatedButton.icon(
          icon: const Icon(Icons.music_note),
          label: const Text("Pick MP3"),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            textStyle: const TextStyle(fontSize: 18),
          ),
          onPressed: () async {
            await audioProvider.pickAudio();
            if (audioProvider.filePath != null) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const PlayerScreen()),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("No file selected")),
              );
            }
          },
        ),
      ),
    );
  }
}
