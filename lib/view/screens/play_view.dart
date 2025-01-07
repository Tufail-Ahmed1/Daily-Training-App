import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class PlayView extends StatelessWidget {
  final VideoPlayerController? controller;

  const PlayView({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    if (controller != null && controller!.value.isInitialized) {
      return Container(
        padding: const EdgeInsets.only(top: 15),
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: VideoPlayer(controller!),
        ),
      );
    } else {
      return const AspectRatio(
        aspectRatio: 16 / 9,
        child: Center(
          child: Text(
            'Preparing...\nRuko Zara Sabar Karo...',
            style: TextStyle(
              fontSize: 25,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );
    }
  }
}


