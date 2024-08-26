// ignore_for_file: file_names
// ignore: depend_on_referenced_packages
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:project/database/dao/db_query.dart';

// ignore: must_be_immutable
class TelaMusica extends StatefulWidget {
  final String nameMusic;
  final String autorMusic;
  final String capaMusic;
  final String namePlaylist;
  final String nomearquivo;
  final int tamanho;
  final int idPlaylist;
  int idMusic;

  TelaMusica(
      {super.key,
      required this.idMusic,
      required this.idPlaylist,
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
  String currentSliderValueFormatted = "0:00";
  late AudioPlayer audioPlayer;
  IconData buttonPlayPause = Icons.play_arrow;
  late double tempoTotal = double.parse(widget.tamanho.toString());
  Timer? _timer;
  bool isPlaying = false;
  List<Map<String, dynamic>>? listMusics;

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
    audioPlayer.play(AssetSource('musics/${widget.nomearquivo}'));
    buttonPlayPause = Icons.pause;
    _togglePlayPause();
    fetchMusics();
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  Future<void> fetchMusics() async {
    listMusics = (await getMusicsByPlaylist(widget.idPlaylist))
        as List<Map<String, dynamic>>?;
    setState(() {}); // Atualiza o estado para refletir as mudanças na UI
  }

  void _togglePlayPause() {
    setState(() {
      isPlaying = !isPlaying;

      if (isPlaying) {
        // Inicia ou retoma o timer quando o botão de play é pressionado
        _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
          setState(() {
            // Incrementa o valor do slider
            if (_currentSliderValue < tempoTotal) {
              _currentSliderValue = _currentSliderValue + 1;
              formatCurrentTime(_currentSliderValue);
            } else {
              _currentSliderValue = tempoTotal;
            }
            // Para o timer se o slider atingir o valor máximo
            if (_currentSliderValue == tempoTotal) {
              currentSliderValueFormatted = "$tempoTotal";
              _timer?.cancel();
              skipMusic();
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
    return "$minutes:${seconds.toString().padLeft(2, '0')}";
  }

  void formatCurrentTime(double value) {
    int totalSeconds = value.toInt();

    // Calcula os minutos e segundos
    int minutes = totalSeconds ~/ 60;
    int seconds = totalSeconds % 60;

    currentSliderValueFormatted =
        "$minutes:${seconds.toString().padLeft(2, '0')}";
  }

  skipMusic() {
    Map<int, int> idToIndex = {
      for (int i = 0; i < listMusics!.length; i++) listMusics![i]['id']: i
    };
    int currentIndex = idToIndex[widget.idMusic]!;
    int lastId = listMusics?.last['id'];
    int firstId = listMusics?.first['id'];
    if (widget.idMusic == lastId) {
      widget.idMusic = firstId;
    } else {
      widget.idMusic = listMusics![currentIndex + 1]['id'];
    }
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => TelaMusica(
                  idMusic: widget.idMusic,
                  idPlaylist: widget.idPlaylist,
                  nameMusic: listMusics![idToIndex[widget.idMusic]!]['nome'],
                  autorMusic: listMusics![idToIndex[widget.idMusic]!]['autor'],
                  capaMusic: listMusics![idToIndex[widget.idMusic]!]['capa'],
                  namePlaylist: widget.namePlaylist,
                  nomearquivo: listMusics![idToIndex[widget.idMusic]!]
                      ['nomearquivo'],
                  tamanho: listMusics![idToIndex[widget.idMusic]!]['tamanho'],
                )));
  }

  prevMusic() {
    Map<int, int> idToIndex = {
      for (int i = 0; i < listMusics!.length; i++) listMusics![i]['id']: i
    };
    int lastId = listMusics?.last['id'];
    int firstId = listMusics?.first['id'];
    int currentIndex = idToIndex[widget.idMusic]!;
    if (widget.idMusic == firstId) {
      widget.idMusic = lastId;
    } else {
      widget.idMusic = listMusics![currentIndex - 1]['id'];
    }
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => TelaMusica(
                  idMusic: widget.idMusic,
                  idPlaylist: widget.idPlaylist,
                  nameMusic: listMusics![idToIndex[widget.idMusic]!]['nome'],
                  autorMusic: listMusics![idToIndex[widget.idMusic]!]['autor'],
                  capaMusic: listMusics![idToIndex[widget.idMusic]!]['capa'],
                  namePlaylist: widget.namePlaylist,
                  nomearquivo: listMusics![idToIndex[widget.idMusic]!]
                      ['nomearquivo'],
                  tamanho: listMusics![idToIndex[widget.idMusic]!]['tamanho'],
                )));
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
            Image.asset(
              "assets/capas/${widget.capaMusic}",
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
                  const Color.fromARGB(255, 45, 207, 13), // Cor ativa do slider
              inactiveColor: Colors.grey, // Cor inativa do slider
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    currentSliderValueFormatted,
                    style: const TextStyle(color: Colors.white),
                  ),
                  Text(secondsToMinutes(),
                      style: const TextStyle(color: Colors.white))
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                    onPressed: prevMusic,
                    icon: const Icon(
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
                IconButton(
                    onPressed: skipMusic,
                    icon: const Icon(
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
