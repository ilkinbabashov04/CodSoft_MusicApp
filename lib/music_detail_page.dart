import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

class MusicDetailPage extends StatefulWidget {
  final String songName;
  final String artistName;
  final String audioAsset;
  final String imageAsset;

  const MusicDetailPage({
    required this.songName,
    required this.artistName,
    required this.audioAsset,
    required this.imageAsset,
  });

  @override
  _MusicDetailPageState createState() => _MusicDetailPageState();
}

class _MusicDetailPageState extends State<MusicDetailPage> {
  late AssetsAudioPlayer player;
  bool isPlaying = false;
  Duration? duration;
  Duration? currentPosition;

  @override
  void initState() {
    super.initState();
    player = AssetsAudioPlayer();
    player.open(Audio(widget.audioAsset));
    player.isPlaying.listen((isPlaying) {
      setState(() {
        this.isPlaying = isPlaying;
      });
    });
    player.currentPosition.listen((position) {
      setState(() {
        currentPosition = position;
      });
    });
    player.current.listen((playingAudio) {
      setState(() {
        duration = playingAudio!.audio.duration;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    String durationText = duration != null
        ? '${duration!.inMinutes.remainder(60).toString().padLeft(2, '0')}:${duration!.inSeconds.remainder(60).toString().padLeft(2, '0')}'
        : '--:--';

    String currentDurationText = currentPosition != null
        ? '${currentPosition!.inMinutes.remainder(60).toString().padLeft(2, '0')}:${currentPosition!.inSeconds.remainder(60).toString().padLeft(2, '0')}'
        : '00:00';

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 44, 29, 104).withOpacity(0.3),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 9, 0, 45).withOpacity(0.3),
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 0),
            Text(
              widget.songName,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              widget.artistName,
              style: TextStyle(color: Colors.white70, fontSize: 18),
            ),
            SizedBox(height: 10),
            Container(
              width: 400,
              height: 350,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: AssetImage(widget.imageAsset),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 30),
            Row(
              children: [
                Expanded(
                  child: Slider(
                    value: currentPosition != null && duration != null
                        ? currentPosition!.inMilliseconds.toDouble()
                        : 0,
                    min: 0,
                    max: duration != null
                        ? duration!.inMilliseconds.toDouble()
                        : 0,
                    onChanged: (value) {
                      player.seek(Duration(milliseconds: value.toInt()));
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    currentDurationText,
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    durationText,
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.skip_previous),
                  color: Colors.white,
                  iconSize: 36,
                  onPressed: () {
                    player.previous();
                  },
                ),
                SizedBox(width: 70),
                IconButton(
                  icon: isPlaying
                      ? Icon(Icons.pause_circle_filled)
                      : Icon(Icons.play_circle_filled),
                  color: Colors.white,
                  iconSize: 64,
                  onPressed: () {
                    if (isPlaying) {
                      player.pause();
                    } else {
                      player.play();
                    }
                  },
                ),
                SizedBox(width: 66),
                IconButton(
                  icon: Icon(Icons.skip_next),
                  color: Colors.white,
                  iconSize: 36,
                  onPressed: () {
                    player.next(); // This changes the music to the next one
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }
}
