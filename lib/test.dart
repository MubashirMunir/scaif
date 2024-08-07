import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class PreLoad extends StatefulWidget {
  @override
  _PreLoadState createState() => _PreLoadState();
}

class _PreLoadState extends State<PreLoad> {
  List<String> videoUrls = [
    'https://videos.pexels.com/video-files/4812205/4812205-hd_1080_1920_30fps.mp4',
    'https://videos.pexels.com/video-files/6394054/6394054-uhd_2732_1366_24fps.mp4',
    'https://videos.pexels.com/video-files/1777892/1777892-hd_1280_720_25fps.mp4',
    'https://videos.pexels.com/video-files/8538236/8538236-uhd_1440_2514_30fps.mp4',
    'https://videos.pexels.com/video-files/18069164/18069164-uhd_1440_2560_24fps.mp4',
    'https://videos.pexels.com/video-files/9669109/9669109-hd_1080_1920_25fps.mp4',
  ];
  late PageController pageController;
  List<VideoPlayerController?> videoControllers = [];
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: currentIndex);
    _initializeControllers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bhai reels'),
      ),
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        controller: pageController,
        itemCount: videoUrls.length,
        onPageChanged: _onPageChanged,
        itemBuilder: (context, index) {
          return VideoPlayer(videoControllers[index]!);
        },
      ),
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    for (int i = 0; i <= videoControllers.length; i++) {
      currentIndex - 2;
      var c = videoControllers[i];
    }
    super.dispose();
  }

  void _initializeControllers() {
    for (int i = 0; i < videoUrls.length; i++) {
      videoControllers
          .add(VideoPlayerController.networkUrl(Uri.parse(videoUrls[i]))
            ..initialize().then((_) {
              setState(() {});
            }));
    }
    _playVideo(currentIndex);
  }

  void _playVideo(int index) {
    if (videoControllers.length > 0) {
      for (int i = 0; i <= videoControllers.length; i++) {
        var controller = videoControllers[0];
        if (controller != null) {
          controller.pause();
        }
      }
    }
    videoControllers[index]?.play();
    videoControllers[index]?.setLooping(true);
  }

  void _onPageChanged(int index) {
    setState(() {
      currentIndex = index;
      _playVideo(currentIndex);

      // previos load
      if (currentIndex > 0) {
        initializeController(currentIndex - 1);
      }
      if (currentIndex < videoUrls.length - 1) {
        initializeController(currentIndex + 1);
      }
    });
  }

  void initializeController(int index) {
    if (videoControllers[index] == null) {
      videoControllers[index] =
          VideoPlayerController.networkUrl(Uri.parse(videoUrls[index]))
            ..initialize().then((_) {
              setState(() {});
            });
    }
  }
}
