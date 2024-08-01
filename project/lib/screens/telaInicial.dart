import 'package:flutter/material.dart';

class TelaInicial extends StatefulWidget {
  String nomeusuario;
  TelaInicial({required this.nomeusuario, super.key});

  @override
  State<TelaInicial> createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 18, 18, 18),
      drawer: Drawer(
          backgroundColor: const Color.fromARGB(255, 36, 36, 36),
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: ListView(
              children: [
                Row(
                  children: [
                    Image.asset(
                      "assets/usuario.png",
                      scale: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.nomeusuario,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                          Text(
                            "Ver perfil",
                            style: TextStyle(
                                color: Color.fromARGB(255, 182, 182, 182),
                                fontSize: 12),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(height: 50.0),
                ListTile(
                  title: Text(
                    "Sair",
                    style: TextStyle(color: Colors.white),
                  ),
                  leading: Icon(
                    Icons.logout,
                    color: Colors.white,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          )),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: Color.fromARGB(255, 18, 18, 18),
      ),
      body: ListView(
        children: [
          Column(
            children: [
              Column(
                children: [
                  ListTile(
                    title: Text('Rap'),
                  )
                ],
              ),
            ],
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        child: Column(
          children: [Text("Sua biblioteca")],
        ),
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
