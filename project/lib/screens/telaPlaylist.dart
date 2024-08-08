// ignore_for_file: file_names

import 'dart:typed_data';

import 'package:flutter/material.dart';

class TelaPlaylist extends StatefulWidget {
  final String namePlaylist;
  final Uint8List capaPlaylist;
  final int idPlaylist;

  const TelaPlaylist(
      {super.key,
      required this.namePlaylist,
      required this.capaPlaylist,
      required this.idPlaylist});

  @override
  State<TelaPlaylist> createState() => _TelaPlaylistState();
}

class _TelaPlaylistState extends State<TelaPlaylist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 18, 18, 18),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 18, 18, 18),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(32.0, 8.0, 32.0, 8.0),
        child: Center(
          child: Column(
            children: [
              Image.memory(
                widget.capaPlaylist,
                width: 250,
                height: 250,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.namePlaylist,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  IconButton.filled(
                    onPressed: () {},
                    icon: const Icon(Icons.play_arrow),
                    color: Colors.white,
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color.fromARGB(255, 30, 215, 16)),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: const Color.fromARGB(255, 14, 14, 14),
        child: Center(
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Column(
              children: [
                Icon(
                  Icons.library_music,
                  color: Color.fromARGB(255, 182, 182, 182),
                  size: 35,
                ),
                SizedBox(height: 4),
                Text(
                  "Sua Biblioteca",
                  style: TextStyle(
                      color: Color.fromARGB(255, 182, 182, 182), fontSize: 12),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
