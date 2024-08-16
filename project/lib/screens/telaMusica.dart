// ignore_for_file: file_names
// ignore: depend_on_referenced_packages
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:audioplayers/audioplayers.dart';

class TelaMusica extends StatefulWidget {
  final String nameMusic;
  final String autorMusic;
  final Uint8List capaMusic;
  final String namePlaylist;
  final String nomearquivo;
  final int tamanho;

  const TelaMusica(
      {super.key,
      required this.nameMusic,
      required this.autorMusic,
      required this.capaMusic,
      required this.namePlaylist,
      required this.nomearquivo,
      required this.tamanho});

  @override
  State<TelaMusica> createState() => _TelaMusicaState();
}

class _TelaMusicaState extends State<TelaMusica> {
  double _currentSliderValue = 0;
  late AudioPlayer audioPlayer;
  IconData buttonPlayPause = Icons.play_arrow;
  late double tempoTotal = double.parse(widget.tamanho.toString());
  Timer? _timer;
  bool isPlaying = false;

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

  void _togglePlayPause() {
    setState(() {
      isPlaying = !isPlaying;

      if (isPlaying) {
        // Inicia ou retoma o timer quando o botão de play é pressionado
        _timer = Timer.periodic(Duration(seconds: 1), (timer) {
          setState(() {
            // Incrementa o valor do slider
            _currentSliderValue = (_currentSliderValue < tempoTotal)
                ? _currentSliderValue + 1
                : tempoTotal;
            // Para o timer se o slider atingir o valor máximo
            if (_currentSliderValue == tempoTotal) {
              _timer?.cancel();
            }
          });
        });
      } else {
        // Pausa o timer quando o botão de pause é pressionado
        _timer?.cancel();
      }
    });
  }

  String secondsToMinutes() {
    int minutes = widget.tamanho ~/ 60;
    int seconds = widget.tamanho % 60;
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 18, 18, 18),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 18, 18, 18),
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: Expanded(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.namePlaylist,
              style: const TextStyle(color: Colors.white, fontSize: 24),
            ),
            const SizedBox(height: 40.0),
            Image.memory(
              widget.capaMusic,
              width: 350,
              height: 350,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 50.0),
            Text(
              textAlign: TextAlign.start,
              widget.nameMusic,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
            Text(widget.autorMusic,
                style: const TextStyle(color: Colors.white)),
            Slider(
              value: _currentSliderValue,
              divisions: widget.tamanho,
              max: tempoTotal,
              onChanged: (value) {},
              activeColor:
                  Color.fromARGB(255, 45, 207, 13), // Cor ativa do slider
              inactiveColor: Colors.grey, // Cor inativa do slider
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _currentSliderValue.toString(),
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(secondsToMinutes(),
                      style: const TextStyle(color: Colors.white))
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const IconButton(
                    onPressed: null,
                    icon: Icon(
                      Icons.skip_previous,
                      color: Colors.white,
                      size: 50,
                    )),
                IconButton.filled(
                    onPressed: () {
                      _togglePlayPause();
                      if (buttonPlayPause == Icons.play_arrow) {
                        setState(() {
                          buttonPlayPause = Icons.pause;
                          audioPlayer.play(
                              AssetSource('musics/${widget.nomearquivo}'));
                        });
                      } else {
                        setState(() {
                          buttonPlayPause = Icons.play_arrow;
                          audioPlayer.pause();
                        });
                      }
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.white,
                    )),
                    icon: Icon(
                      buttonPlayPause,
                      color: Colors.black,
                      size: 50,
                    )),
                const IconButton(
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
