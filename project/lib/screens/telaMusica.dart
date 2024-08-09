// ignore_for_file: file_names
// ignore: depend_on_referenced_packages
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:audioplayers/audioplayers.dart';

class TelaMusica extends StatefulWidget {
  final String nameMusic;
  final String autorMusic;
  final Uint8List capaMusic;
  final String namePlaylist;

  const TelaMusica(
      {super.key,
      required this.nameMusic,
      required this.autorMusic,
      required this.capaMusic,
      required this.namePlaylist});

  @override
  State<TelaMusica> createState() => _TelaMusicaState();
}

class _TelaMusicaState extends State<TelaMusica> {
  double _currentSliderValue = 0;
  late AudioPlayer audioPlayer;

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  Future<void> playLocal(String path) async {
    audioPlayer.play(AssetSource(path));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 18, 18, 18),
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 18, 18, 18),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: Expanded(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.namePlaylist,
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
            SizedBox(height: 40.0),
            Image.memory(
              widget.capaMusic,
              width: 350,
              height: 350,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 50.0),
            Text(
              textAlign: TextAlign.start,
              widget.nameMusic,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
            Text(widget.autorMusic, style: TextStyle(color: Colors.white)),
            Slider(
                value: _currentSliderValue,
                max: 100,
                activeColor: Colors.grey[800],
                divisions: 4,
                onChanged: (double value) {
                  setState(() {
                    _currentSliderValue = value;
                  });
                }),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '0:00',
                    style: TextStyle(color: Colors.white),
                  ),
                  Text('2:56', style: TextStyle(color: Colors.white))
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                    onPressed: null,
                    icon: Icon(
                      Icons.skip_previous,
                      color: Colors.white,
                      size: 50,
                    )),
                IconButton.filled(
                    onPressed: () {
                      playLocal('anjoscantam.mp3');
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.white,
                    )),
                    icon: Icon(
                      Icons.play_arrow,
                      color: Colors.black,
                      size: 50,
                    )),
                IconButton(
                    onPressed: null,
                    icon: Icon(
                      Icons.skip_next,
                      color: Colors.white,
                      size: 50,
                    )),
              ],
            )
          ],
        )));
  }
}
