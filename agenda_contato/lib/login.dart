import 'package:agenda_contato/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'mainscreen.dart';

class Logar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(
            minHeight: (MediaQuery.of(context).size.height),
          ),
          color: Colors.white,
          padding: EdgeInsets.fromLTRB(20, 100, 20, 20),
          child: Column(
            children: [
              Container(
                alignment: Alignment(0, 0),
                height: 100,
                width: 100,
                child: FaIcon(
                  FontAwesomeIcons.tooth,
                  size: 60,
                  color: Colors.white,
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.deepPurple),
              ),
              Padding(padding: EdgeInsets.all(10)),
              Text(
                "Dr. Dumilde",
                style: TextStyle(
                    color: Colors.black, fontSize: 36, fontWeight: FontWeight.bold,fontFamily: "cursive"),
              ),
              Text('Cirurgião Dentista',
                style: TextStyle(
                    color: Colors.black, fontSize: 30, fontFamily: "cursive"),
              ),
              Form(
                  child: Column(
                children: [
                  Padding(padding: EdgeInsets.all(25)),
                  Material(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: "E-mail",
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            borderSide: BorderSide(color: Colors.grey)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            borderSide: BorderSide(color: Colors.black)),
                        // border: InputBorder.none
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(10)),
                  Material(
                      child: TextField(
                    obscureText: true,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    cursorColor: Colors.blueGrey,
                    decoration: InputDecoration(
                      labelText: "Senha",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          borderSide: BorderSide(color: Colors.black)),
                      // border: InputBorder.none
                    ),
                  )),
                  Padding(
                    padding: EdgeInsets.all(10),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(40.0),
                    child: Container(
                      height: 60,
                      width: 180,
                      child: RaisedButton(
                        color: Colors.deepPurple,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyApp()));
                        },
                        child: Text(
                          "Entrar",
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                  ),
                  Text(
                    "Esqueci minha Senha",
                    style: TextStyle(color: Colors.black87, fontSize: 14),
                  ),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
