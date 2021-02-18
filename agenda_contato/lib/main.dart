import 'dart:ui';
import 'package:flutter/material.dart';
import 'login.dart';


void main() {
  runApp(MaterialApp(home: Logar()));
}

class Inicio extends StatefulWidget {
  @override
  _HomeAppState createState() => _HomeAppState();
}

class _HomeAppState extends State<Inicio> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        leading: Icon(Icons.menu),
        actions: [
          GestureDetector(
            onTap: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Logar())

              );
            },
            child: Icon(Icons.logout),

          ),
        ],

        title: Text("Agenda Dr Dumilde"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Row(

        children: [


          Container(
            height: 150,
            width: 200,
            child: Card(
              child: Column(
                children: [
                  Icon(
                    Icons.note_add,
                    size: 100,
                  ),
                  Text("Agendar"),
                ],
              ),
            ),
          ),
          Row(
            children: [
              Container(
                height: 150,
                width: 200,
                child: Card(
                  child: Column(
                    children: [
                      Icon(
                        Icons.plagiarism,
                        size: 100,
                      ),
                      Text("Minhas Consultas"),
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
