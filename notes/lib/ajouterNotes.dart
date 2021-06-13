import 'package:flutter/material.dart';
import 'package:notes/data/notes.dart';
import 'package:notes/data/notesDatabase.dart';
import 'package:flutter/cupertino.dart';
import "package:date_time_format/date_time_format.dart";

class AjouteNote extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AjouterNote();
  }
}

class _AjouterNote extends State<AjouteNote> {
  var titre;
  var note;
  var id;
  List<DataNotes>? menotes = []; //pour gerer l'actualisation
  List<DataNotes>? compteur = []; //pour gerer les id uniques
  String datetoday() {
    DateTime t = DateTime.now();
    return t.format("j M   H:i ");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1F1D2B),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFF1F1D2B),
        actions: [
          // ignore: deprecated_member_use
          FlatButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  if (titre != "" && note != "" || titre == "" || note == "") {
                    NotesDataBase.instance.insertNote(
                      DataNotes(
                        id: id,
                        titre: titre,
                        note: note,
                        dateEnr: datetoday(),
                      ),
                    );
                  }
                });
              },
              child: Text(
                'Enregistrer',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Container(
                    child: TextField(
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration(
                        hintStyle: TextStyle(
                          color: Colors.white70,
                        ),
                        hintText: 'Titre',
                        border: InputBorder.none,
                        // filled: true,
                        // fillColor: Color(0xFF272636),
                      ),
                      style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white70),
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      onChanged: (t) {
                        setState(() {
                          titre = t;
                        });
                      },
                    ),
                  ),
                  Container(
                    child: TextField(
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration(
                        hintStyle: TextStyle(
                          color: Colors.white70,
                        ),
                        hintText: 'Ecrivez quelque choses...',
                        border: InputBorder.none,
                        // filled: true,
                        // fillColor: Color(0xFF1F1D2B),
                      ),
                      style: TextStyle(
                        color: Colors.white70,
                      ),
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      onChanged: (n) {
                        setState(() {
                          note = n;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
