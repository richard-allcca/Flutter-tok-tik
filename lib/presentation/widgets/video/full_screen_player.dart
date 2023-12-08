import 'package:flutter/material.dart';
import 'package:toktik/presentation/widgets/video/vide_background.dart';
import 'package:video_player/video_player.dart';


class FullScreenPlayer extends StatefulWidget {
  final String videoUrl;
  final String caption;

  const FullScreenPlayer({
    super.key,
    required this.videoUrl,
    required this.caption
  });

  @override
  State<FullScreenPlayer> createState() => _FullScreenPlayerState();
}

// NOTE - To access properties of stateFullWidget use 'widget.nameProp'

class _FullScreenPlayerState extends State<FullScreenPlayer> {
  late VideoPlayerController controller;

  @override
  void initState() {
    super.initState();

    // implement initState
    controller = VideoPlayerController.asset(widget.videoUrl)
    ..initialize().then((_) =>
      setState(() {})
    )
      ..setVolume(0)
      ..setLooping(true)
      ..play();
  }

  @override
  void dispose() {
    // implement dispose - avoid video playback if it is not being viewed
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // return const Placeholder();
    return FutureBuilder(
      future: controller.initialize(),
      builder: (context, snapshot) {
        if( snapshot.connectionState != ConnectionState.done){
          return const Center(child: CircularProgressIndicator(strokeWidth: 2));
        }
        return GestureDetector(
          onTap: () {
            if(controller.value.isPlaying){
              controller.pause();
              return;
            }
            controller.play();
          },
          child: AspectRatio(
            aspectRatio: controller.value.aspectRatio,
            child: Stack(
              children: [
                VideoPlayer(controller),

                // Gradient
                VideoBackground( stops: const [0.8, 1.0]),

                // Description
                Positioned(
                  bottom: 50,
                  left: 20,
                  child: _VideoCaption(caption: widget.caption),
                )

                // Text
              ],
            ),
          ),
        );
      }
    );
  }
}

class _VideoCaption extends StatelessWidget {

  final String caption;

  const _VideoCaption({super.key, required this.caption});

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final titleStyle = Theme.of(context).textTheme.titleLarge;

    return SizedBox(
      width: size.width * 0.6,
      child: Text( caption, maxLines: 2, style: titleStyle),
    );
  }
}