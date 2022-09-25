import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import '../global/global.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({Key? key}) : super(key: key);

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  List<VideoPlayerController> videoPlayerControllerList = [];
  List<ChewieController> chewieControllerList = [];

  List allVideos = [];

  late VideoPlayerController videoPlayerController;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();

    allVideos = Global.categoryVideos.videos;

    for (var e in allVideos) {
      videoPlayerControllerList.add(
        VideoPlayerController.asset(e)
          ..initialize().then((_) {
            setState(() {});
          }),
      );
    }

    for (var e in videoPlayerControllerList) {
      chewieControllerList.add(ChewieController(
          videoPlayerController: e, autoPlay: false, looping: false));
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    dynamic res = ModalRoute.of(context)?.settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text("${res.category}"),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            ...allVideos.map((e) {
              return Container(
                margin: const EdgeInsets.all(12),
                width: double.infinity,
                height: 240,
                color: Colors.blueGrey,
                child: AspectRatio(
                  aspectRatio: videoPlayerControllerList[allVideos.indexOf(e)]
                      .value
                      .aspectRatio,
                  child: Chewie(
                    controller: chewieControllerList[allVideos.indexOf(e)],
                  ),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    for (var e in videoPlayerControllerList) {
      chewieControllerList[videoPlayerControllerList.indexOf(e)].dispose();
      e.dispose();
    }
  }
}
