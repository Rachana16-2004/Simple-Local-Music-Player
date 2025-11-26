import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:flutter_media_metadata/flutter_media_metadata.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

class AudioProvider extends ChangeNotifier {
  final AudioPlayer player = AudioPlayer();

  String? filePath;
  String title = '';
  String artist = '';
  Uint8List? albumArt;

  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  bool isPlaying = false;

  Future<void> pickAudio() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['mp3'],
      );

      if (result != null && result.files.single.path != null) {
        filePath = result.files.single.path!;

        // Load metadata
        await _loadMetadata(filePath!);

        // Load audio
        await player.setFilePath(filePath!);

        duration = player.duration ?? Duration.zero;
        position = Duration.zero;
        isPlaying = false;

        // Position listener
        player.positionStream.listen((pos) {
          position = pos;
          notifyListeners();
        });

        // Player state listener
        player.playerStateStream.listen((state) {
          isPlaying = state.playing;

          if (state.processingState == ProcessingState.completed) {
            player.seek(Duration.zero);
            isPlaying = false;
          }

          notifyListeners();
        });

        notifyListeners();
      } else {
        // User cancelled
        title = '';
        artist = '';
        albumArt = null;
        filePath = null;
        notifyListeners();
      }
    } catch (e) {
      print("Error picking file: $e");
    }
  }

  Future<void> _loadMetadata(String path) async {
    try {
      Metadata metadata = await MetadataRetriever.fromFile(File(path));

      title = metadata.trackName ?? path.split('/').last;

      // Handling artist safely
      if (metadata.trackArtistNames != null &&
          metadata.trackArtistNames!.isNotEmpty) {
        artist = metadata.trackArtistNames!.join(', ');
      } else if (metadata.albumArtistName != null &&
          metadata.albumArtistName!.isNotEmpty) {
        artist = metadata.albumArtistName!;
      } else {
        artist = 'Unknown Artist';
      }

      // Album Art
      albumArt = metadata.albumArt;
    } catch (e) {
      title = path.split('/').last;
      artist = 'Unknown Artist';
      albumArt = null;
    }
  }

  void playPause() {
    if (isPlaying) {
      player.pause();
    } else {
      player.play();
    }
    notifyListeners();
  }

  void seek(Duration pos) {
    player.seek(pos);
  }
}
