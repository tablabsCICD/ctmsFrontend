import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';


String convertToMinutesSeconds(Duration duration) {
  final parsedMinutes = duration.inMinutes < 10
      ? '0${duration.inMinutes}'
      : duration.inMinutes.toString();

  final seconds = duration.inSeconds % 60;

  final parsedSeconds =
  seconds < 10 ? '0${seconds % 60}' : (seconds % 60).toString();
  return '$parsedMinutes:$parsedSeconds';
}

IconData animatedVolumeIcon(double volume) {
  if (volume == 0)
    return Icons.volume_mute;
  else if (volume < 0.5)
    return Icons.volume_down;
  else
    return Icons.volume_up;
}


class CustomVideoPlayer extends StatefulWidget {
  final String videoUrl;

  CustomVideoPlayer({required this.videoUrl});

  @override
  _CustomVideoPlayerState createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
   Duration? videoLength;
  Duration? videoPosition;
  double volume = 0.5;

  @override
  void initState() {
    super.initState();
   // _controller = VideoPlayerController.network(widget.videoUrl);
    _controller = VideoPlayerController.network(
        widget.videoUrl)
      ..addListener(() => setState(() {
        videoPosition = _controller.value.position;
      }))
      ..initialize().then((_) => setState(() {
        videoLength = _controller.value.duration;
      }));
    _initializeVideoPlayerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _controller.value.isInitialized?FutureBuilder(
          future: _initializeVideoPlayerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                         SizedBox(
                           height: 150,
                             width: MediaQuery.sizeOf(context).width,
                             child: VideoPlayer(_controller)),
                         Align(
                           alignment: Alignment.bottomCenter,
                           child: VideoProgressIndicator(
                             _controller,
                             allowScrubbing: true,
                             padding: EdgeInsets.symmetric(horizontal: 10,vertical: 0),
                           ),
                         )

                        ],
                      ),
                      Row(
                        children: <Widget>[
                          IconButton(
                            icon: Icon(_controller.value.isPlaying
                                ? Icons.pause
                                : Icons.play_arrow,color: Colors.black,size: 20,),
                            onPressed: () {
                              setState(() {
                                _controller.value.isPlaying
                                    ? _controller.pause()
                                    : _controller.play();
                              });
                            },
                          ),
                          Text(
                            '${convertToMinutesSeconds(videoPosition!)} / ${convertToMinutesSeconds(videoLength!)}', style: TextStyle(
                            color: Colors.black,
                            fontSize: 9.sp,
                            fontFamily: GoogleFonts.poppins().fontFamily,
                            fontWeight: FontWeight.w300,
                          ),),
                          Spacer(),
                          Icon(animatedVolumeIcon(volume),size: 20,),
                           SizedBox(
                             width: 100,
                             child: Slider(
                              value: volume,
                              min: 0,
                              max: 1,
                              onChanged: (_volume) => setState(() {
                                volume = _volume;
                                _controller.setVolume(_volume);
                              }),
                                                       ),
                           ),
                          /* Spacer(),
                          IconButton(
                              icon: Icon(
                                Icons.loop,
                                color: _controller.value.isLooping
                                    ? Colors.green
                                    : Colors.black,
                              ),
                              onPressed: () {
                                setState(() {
                                  _controller
                                      .setLooping(!_controller.value.isLooping);
                                });
                              })*/
                        ],
                      ),

                    ],
                  ),
                )
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        ):CircularProgressIndicator()
      ),
    );
  }

}
