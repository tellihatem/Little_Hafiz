import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class SplashScreen extends StatefulWidget {
  final Widget child;
  final Duration duration;

  const SplashScreen({
    Key? key,
    required this.child,
    this.duration = const Duration(
      seconds: 3,
    ), // Increased duration for video playback
  }) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;
  bool _isInitialized = false;
  String? _videoPath;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    // Determine which video to load based on screen aspect ratio
    final mediaQuery = MediaQueryData.fromView(
      WidgetsBinding.instance.platformDispatcher.views.first,
    );
    final screenAspectRatio = mediaQuery.size.aspectRatio;

    // Use 16:9 video for wider screens, 9:16 for taller screens
    _videoPath =
        screenAspectRatio >= (9 / 16)
            ? 'assets/videos/splash_screen_16.mp4' // 16:9 video
            : 'assets/videos/splash_screen_9.mp4'; // 9:16 video

    _videoPlayerController = VideoPlayerController.asset(_videoPath!);

    try {
      await _videoPlayerController.initialize();

      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        autoPlay: true,
        looping: false,
        showControls: false,
        allowFullScreen: false,
        allowMuting: true,
        allowPlaybackSpeedChanging: false,
        errorBuilder: (context, errorMessage) {
          return Center(
            child: Text(
              'Error loading video: $errorMessage',
              style: const TextStyle(color: Colors.white),
            ),
          );
        },
      );

      // Start playing the video
      _videoPlayerController.play();

      // Listen for when the video ends
      _videoPlayerController.addListener(() {
        if (_videoPlayerController.value.isPlaying &&
            _videoPlayerController.value.position >=
                _videoPlayerController.value.duration) {
          _navigateToApp();
        }
      });

      // Navigate after the specified duration (as a fallback)
      Future.delayed(widget.duration, _navigateToApp);

      if (mounted) {
        setState(() {
          _isInitialized = true;
        });
      }
    } catch (e) {
      debugPrint('Error initializing video: $e');
      // If video fails to load, navigate after a short delay
      Future.delayed(const Duration(seconds: 2), _navigateToApp);
    }
  }

  void _navigateToApp() {
    if (mounted) {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => widget.child,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      );
    }
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body:
          _isInitialized
              ? Center(
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Chewie(controller: _chewieController),
                  ),
                ),
              )
              : const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
    );
  }
}
