import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:firebase_storage/firebase_storage.dart';

class VideoApp extends StatefulWidget {
  final String videoPath;

  VideoApp({Key? key, required this.videoPath}) : super(key: key);

  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {
  VideoPlayerController? _controller;
  bool _isLoading = true;
  bool _isMuted = false;

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer();
  }

  Future<void> _initializeVideoPlayer() async {
    try {
      String videoUrl = await FirebaseStorage.instance.ref(widget.videoPath).getDownloadURL();
      _controller = VideoPlayerController.networkUrl(Uri.parse(videoUrl))
        ..initialize().then((_) {
          setState(() {
            _isLoading = false;
          });
        });
      _controller!.addListener(() {
        setState(() {});
      });
    } catch (e) {
      print('Video yüklenirken hata oluştu: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Player'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _buildVideoContent(),
    );
  }

  Widget _buildVideoContent() {
    if (_controller == null || !_controller!.value.isInitialized) {
      return Center(child: Text('Video yüklenemedi.'));
    }
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.8),
                  spreadRadius: 3,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
              borderRadius: BorderRadius.circular(10),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: AspectRatio(
                aspectRatio: _controller!.value.aspectRatio,
                child: VideoPlayer(_controller!),
              ),
            ),
          ),
          VideoProgressIndicator(
            _controller!,
            allowScrubbing: true,
            padding: EdgeInsets.symmetric(vertical: 5),
            colors: VideoProgressColors(
              playedColor: Colors.redAccent,
              bufferedColor: Colors.red[100]!,
              backgroundColor: Colors.grey[800]!,
            ),
          ),
          _buildControls(),
        ],
      ),
    );
  }

  Widget _buildControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(
            _controller!.value.isPlaying ? Icons.pause : Icons.play_arrow,
          ),
          onPressed: () {
            setState(() {
              _controller!.value.isPlaying ? _controller!.pause() : _controller!.play();
            });
          },
        ),
        IconButton(
          icon: Icon(_isMuted ? Icons.volume_off : Icons.volume_up),
          onPressed: () {
            setState(() {
              _isMuted = !_isMuted;
              _controller!.setVolume(_isMuted ? 0 : 1);
            });
          },
        ),
        IconButton(
          icon: Icon(Icons.fullscreen),
          onPressed: () => _toggleFullScreen(context),
        ),
      ],
    );
  }

  void _toggleFullScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          body: SafeArea(
            child: AspectRatio(
              aspectRatio: _controller!.value.aspectRatio,
              child: VideoPlayer(_controller!),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}
