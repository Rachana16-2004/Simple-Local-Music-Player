import 'package:flutter/material.dart';

class SeekBarWidget extends StatelessWidget {
  final Duration position;
  final Duration duration;
  final ValueChanged<Duration> onChanged;

  const SeekBarWidget(
      {super.key, required this.position, required this.duration, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Slider(
          min: 0,
          max: duration.inMilliseconds.toDouble(),
          value: position.inMilliseconds.clamp(0, duration.inMilliseconds).toDouble(),
          onChanged: (value) => onChanged(Duration(milliseconds: value.toInt())),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(_formatDuration(position)),
            Text(_formatDuration(duration)),
          ],
        ),
      ],
    );
  }

  String _formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(d.inMinutes.remainder(60));
    final seconds = twoDigits(d.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }
}
