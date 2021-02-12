import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

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
  List _toDolist = [];
  DateTime _dateTime;
  Map<String, dynamic> _lastRemoved;
  int _lastRemovedPost;

  @override
  void initState() {
    super.initState();
    _readData().then((data) {
      setState(() {
        _toDolist = json.decode(data);
      });
    });
  }

  final _toDoController = TextEditingController();
  final _txtDataControler = TextEditingController();

  Future<Null> _refresh() async {
    await Future.delayed(Duration(seconds: 1));

    setState(() {
      _toDolist.sort((a, b) {
        if (a["ok"] && !b["ok"])
          return 1;
        else if (!a["ok"] && b["ok"])
          return -1;
        else
          return 0;
      });
    });
    return null;
  }

  Future<void> _askedToLead() async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            children: <Widget>[
              Container(
                  padding: EdgeInsets.fromLTRB(17, 1, 17, 1),
                  child: Column(
                    children: <Widget>[
                      TextField(
                        controller: _toDoController,
                        decoration: InputDecoration(
                            labelText: "Nova Tarefa",
                            labelStyle: TextStyle(color: Colors.blueAccent)),
                        autofocus: true,
                      ),
                      GestureDetector(
                        onTap: () {
                          showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2001),
                                  lastDate: DateTime(2222))
                              .then((date) {
                            setState(() {
                              _dateTime = date;
                              _txtDataControler.text =
                                  _dateTime.day.toString() +
                                      "/" +
                                      _dateTime.month.toString() +
                                      "/" +
                                      _dateTime.year.toString();
                            });
                          });
                        },
                        child: TextField(
                          decoration: InputDecoration(labelText: "Data"),
                          enabled: false,
                          controller: _txtDataControler,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: RaisedButton(
                          elevation: 10,
                          color: Colors.blueAccent,
                          child: Text("Salvar"),
                          textColor: Colors.white,
                          onPressed: () {
                            _addToDo();
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ],
                  ))
            ],
          );
        });
  }

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomAppBar(
          child: Row(
            children: [
              IconButton(
                  icon: Icon(Icons.date_range),
                  onPressed: () {
                    showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2001),
                            lastDate: DateTime(2222))
                        .then((date) {
                      setState(() {
                        _dateTime = date;
                      });
                    });
                  }),
              Spacer(),
              IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    //AQUI
                    GestureDetector(
                      onTap: () {
                        AlertDialog(
                          title: Text('Reset settings?'),
                          content: Text(
                              'This will reset your device to its default factory settings.'),
                          actions: [
                            FlatButton(
                              textColor: Color(0xFF6200EE),
                              onPressed: () {},
                              child: Text('CANCEL'),
                            ),
                            FlatButton(
                              textColor: Color(0xFF6200EE),
                              onPressed: () {},
                              child: Text('ACCEPT'),
                            ),
                          ],
                        );
                      },
                    );
                  }),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add), onPressed: _askedToLead),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        appBar: AppBar(
          title: Text("Lista de Tarefas"),
          backgroundColor: Colors.blueAccent,
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
              child: RefreshIndicator(
                onRefresh: _refresh,
                child: ListView.builder(
                    padding: EdgeInsets.only(top: 10),
                    itemCount: _toDolist.length,
                    itemBuilder: buildItem),
              ),
            ),
          ],
        ));
  }

  Widget buildItem(context, index) {
    return Dismissible(
      key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
      background: Container(
        color: Colors.red,
        child: Align(
          alignment: Alignment(-0.9, 0),
          child: Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
      ),
      direction: DismissDirection.startToEnd,
      child: CheckboxListTile(
        title:
            Text(_toDolist[index]['title'] + ' - ' + _toDolist[index]['data']),
        value: _toDolist[index]["ok"],
        secondary: CircleAvatar(
          child: Icon(_toDolist[index]["ok"] ? Icons.check : Icons.error),
        ),
        onChanged: (c) {
          setState(() {
            _toDolist[index]["ok"] = c;
            _saveData();
          });
        },
      ),
      onDismissed: (direction) {
        setState(() {
          _lastRemoved = Map.from(_toDolist[index]);
          _lastRemovedPost = index;
          _toDolist.removeAt(index);
          _saveData();
        });

        final snack = SnackBar(
          content: Text("Tarefa \"${_lastRemoved["title"]}\" removida!"),
          action: SnackBarAction(
              label: "Desfazer",
              onPressed: () {
                setState(() {
                  _toDolist.insert(_lastRemovedPost, _lastRemoved);
                  _saveData();
                });
              }),
          duration: Duration(seconds: 2),
        );
        Scaffold.of(context).removeCurrentSnackBar(); // ADICIONE ESTE COMANDO
        Scaffold.of(context).showSnackBar(snack);
      },
    );
  }

  void _addToDo() {
    setState(() {
      Map<String, dynamic> newToDo = Map();
      newToDo["title"] = _toDoController.text;
      newToDo["data"] = _txtDataControler.text;
      _toDoController.text = "";
      newToDo["ok"] = false;
      _toDolist.add(newToDo);
      _saveData();

      print(_toDolist);
    });
  }

  Future<File> _getFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File("${directory.path}/data.json");
  }

  Future<File> _saveData() async {
    String data = json.encode(_toDolist);
    final file = await _getFile();
    return file.writeAsString(data);
  }

  Future<String> _readData() async {
    try {
      final file = await _getFile();
      return file.readAsString();
    } catch (e) {
      return null;
    }
  }
}
