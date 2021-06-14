import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes/ajouternotes.dart';
import 'package:notes/data/notes.dart';
import 'package:notes/data/notesDatabase.dart';
import 'package:notes/modifiernotes.dart';
import "package:date_time_format/date_time_format.dart";
import 'package:animated_text_kit/animated_text_kit.dart';
import "package:url_launcher/url_launcher.dart";
import 'package:package_info/package_info.dart';

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
  void _openEndDrawer() {
    _scaffoldKey.currentState!.openEndDrawer();
  }

  String datetoday() {
    DateTime t = DateTime.now();
    return t.format("j M H:i");
  }

  void lauchWhatssap({@required number, @required message}) async {
    String url = "https://wa.me/$number?text=$message";

    await canLaunch(url) ? launch(url) : print("pas de connection");
  }

  void lauchTelephone({@required mail, @required message}) async {
    var url = "mailto:$mail?subject=$message";
    await canLaunch(url) ? launch("$url") : print("no connection");
  }
  // void _closeEndDrawer() {
  //   Navigator.of(context).pop();
  // }

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
        brightness: Brightness.dark,
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
                      onPressed: _openEndDrawer,
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
                          mainAxisExtent: 200.0,
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
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                      capitalize("${menotes![index].note}"),
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white70,
                                      ),
                                      maxLines: 6,
                                      // textAlign: TextAlign.justify,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: 60,
                                        padding: EdgeInsets.all(10),
                                        child: Text(
                                          capitalize(
                                              '${menotes![index].dateEnr}'),
                                          maxLines: 1,
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: Colors.white70,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 60,
                                        padding: EdgeInsets.all(10),
                                        child: Text(
                                          "${menotes![index].titre}",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold),
                                          maxLines: 1,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
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
        child: Container(
          color: Color(0xFF272636),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    DrawerHeader(
                      child: TextLiquidFill(
                        loadDuration: Duration(seconds: 2),
                        boxBackgroundColor: Color(0xFF272636),
                        waveColor: Colors.white,
                        text: "Paramètres",
                        textStyle: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                        ),
                        boxHeight: 90,
                        boxWidth: 300,
                      ),
                    ),
                    ListTile(
                      title: Text(
                        'Share...',
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                      ),
                      leading: Icon(
                        Icons.share,
                        color: Colors.white,
                      ),
                      onTap: () {
                        print("Clicked");
                      },
                    ),
                    ListTile(
                      title: Text(
                        'archive',
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                      ),
                      leading: Icon(
                        Icons.archive,
                        color: Colors.white,
                      ),
                      onTap: () {
                        print("Clicked");
                      },
                    ),
                    ListTile(
                      title: Text(
                        'Corbeille',
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                      ),
                      leading: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                      onTap: () {
                        print("Clicked");
                      },
                    ),
                    ListTile(
                      title: Text(
                        'info. developpeur',
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                      ),
                      leading: Icon(
                        Icons.info_rounded,
                        color: Colors.white,
                      ),
                      onTap: () => showDialog(
                        context: context,
                        builder: (c) {
                          return AlertDialog(
                            backgroundColor: Color(0xFF272636),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            title: Text(
                              "Information développeur",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            content: Text(
                              "@copyright by  Mo Smad\n\nNous contacter : ",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 16,
                              ),
                            ),
                            actions: [
                              GestureDetector(
                                onTap: () {
                                  lauchTelephone(
                                    mail: "mohamedsmad13@gmail.com",
                                    message: "À propos de l'appli de note !",
                                  );
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 30,
                                    vertical: 10,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: Image.asset(
                                          "assets/gmail.png",
                                        ),
                                        width: 25,
                                        height: 25,
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        'Mail',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                  lauchWhatssap(
                                    number: "22501145515",
                                    message: "Hi Smad!",
                                  ); //aller sur whatssap
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 30,
                                    vertical: 10,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: Image.asset("assets/wha.png"),
                                        width: 25,
                                        height: 25,
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        'whatsapp',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                // This align moves the children to the bottom
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  // This container holds all the children that will be aligned
                  // on the bottom and should not scroll with the above ListView
                  child: Container(
                    margin: EdgeInsets.all(50),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FutureBuilder(
                          future: PackageInfo.fromPlatform(),
                          builder: (BuildContext context,
                              AsyncSnapshot<PackageInfo> snaphot) {
                            if (snaphot.hasData)
                              return Column(
                                children: [
                                  Text(
                                      "BuilderName : ${snaphot.data!.buildNumber}",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16.0)),
                                  Text("Version : ${snaphot.data!.version}",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16.0)),
                                  Text("AppName : ${snaphot.data!.appName}",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16.0)),
                                ],
                              );
                            return Container();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
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
