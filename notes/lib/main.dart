import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes/ajouternotes.dart';
import 'package:notes/data/notes.dart';
import 'package:notes/data/notesDatabase.dart';
import 'package:notes/modifiernotes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Home();
  }
}

class _Home extends State<Home> {
  List<DataNotes>? menotes = []; //pour gerer l'actualisation
  List<DataNotes>? compteur = []; //pour gerer les id uniques
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  // void _openDrawer() {
  //   _scaffoldKey.currentState!.openDrawer();
  // }

  void _closeDrawer() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color(0xFF1F1D2B),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.note_add,
          color: Colors.white70,
          size: 40,
        ),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => AjouteNote()));
        },
        elevation: 10.0,
        backgroundColor: Color(0xFF4f4bbd),
      ),
      appBar: AppBar(
        backgroundColor: Color(0xFF1F1D2B),
        elevation: 0,
        toolbarHeight: 10,
      ),
      body: Column(
        children: [
          Flexible(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.all(10.0),
                  color: Colors.transparent,
                  child: Align(
                    alignment: Alignment(0.00, 0.00),
                    child: Text(
                      'Notes',
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Container(
                  color: Colors.transparent,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon: Icon(
                        Icons.settings,
                        size: 30,
                        color: Colors.white,
                      ),
                      onPressed: () => _scaffoldKey.currentState!.openDrawer(),
                      highlightColor: Color(0xFFFFFF),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            flex: 7,
            child: Container(
              padding: EdgeInsets.only(
                right: 15,
                left: 15,
                top: 35,
                bottom: 20,
              ),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xFF1F1D2B),
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(40.0),
                ),
              ),
              child: FutureBuilder<List<DataNotes>>(
                future: NotesDataBase.instance.notes(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<DataNotes>> snapshot) {
                  if (snapshot.hasData) {
                    menotes = snapshot.data;
                    compteur = menotes;
                    return GridView.builder(
                        itemCount: menotes!.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisExtent: 250.0,
                          // if (menotes!.notes.length > 20) {
                          //   mainAxisExtent: 250.0,
                          // } else {
                          // }
                        ),
                        itemBuilder: (BuildContext context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => ModifierNotes(
                                            dataNotes: menotes![index],
                                          )));
                            },
                            child: Container(
                              margin: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Color(0xFF272636),
                                // border: Border.all(
                                //     width: 0.5, color: const Color(0xFFFFFFFF)),
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20.0),
                                  bottom: Radius.circular(20.0),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 0.2,
                                    offset: Offset(1.0, 1.0),
                                    spreadRadius: 0.2,
                                    color: Color(0xFFFFFF),
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      child: Text(
                                        capitalize(" ${menotes![index].note} "),
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white70,
                                        ),
                                        maxLines: 5,
                                        textAlign: TextAlign.justify,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          capitalize(
                                              '${menotes![index].j}/${menotes![index].m}'),
                                          maxLines: 1,
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.white70,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          "  ${menotes![index].titre}  ",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 10,
                                          ),
                                          maxLines: 1,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
      // endDrawerEnableOpenDragGesture: false,
      endDrawer: Drawer(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('This is the Drawer'),
              ElevatedButton(
                onPressed: _closeDrawer,
                child: const Text('Close Drawer'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String capitalize(String s) {
    var newS;
    newS = s[0].toUpperCase() + s.substring(1);
    return newS;
  }

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        menotes;
      });
    });
  }
}
