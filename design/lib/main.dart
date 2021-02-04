import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(




      body: Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(17, 1, 7, 1),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                        labelText: "Nova Tarefa",
                        labelStyle: TextStyle(color: Colors.black)),
                  ),
                ),
                RaisedButton(
                  color: Colors.black,
                  child: Text("ADD"),
                  textColor: Colors.white,
                  onPressed: () {},
                )
              ],
            ),
          ),

          Row(
            children: [
              Card(
                color: Colors.white,
                child: Column(
                  children: [
                    SizedBox(height:50,width: 150),
                    Text("Mês",style: TextStyle(fontSize: 30,color: Colors.black),),
                    Row(
                      children: [

                      ],
                    )

                  ],
                ),
                

              )
            ],
          ),


        ],
      ),

    );

  }

}
