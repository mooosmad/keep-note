import 'package:flutter/material.dart';
import 'package:notes/data/notes.dart';
import 'package:notes/data/notesDatabase.dart';

// ignore: must_be_immutable
class ModifierNotes extends StatefulWidget {
  DataNotes dataNotes;
  ModifierNotes({required this.dataNotes});
  @override
  _ModifierNotesState createState() => _ModifierNotesState();
}

class _ModifierNotesState extends State<ModifierNotes> {
  var NewTitre, NewNote, NewID;
  @override
  void initState() {
    NewTitre = widget.dataNotes.titre;
    NewNote = widget.dataNotes.note;
    NewID = widget.dataNotes.id;
    super.initState();
  }

  var titre;
  var note;
  var newData;
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
                setState(() {
                  DataNotes newData = DataNotes(
                    id: widget.dataNotes.id,
                    titre: NewTitre,
                    note: NewNote,
                    j: widget.dataNotes.j,
                    m: widget.dataNotes.m,
                    y: widget.dataNotes.y,
                    heure: widget.dataNotes.heure,
                    minute: widget.dataNotes.minute,
                  );
                  NotesDataBase.instance.updateNote(newData);
                  Navigator.pop(context);
                });
              },
              child: Text(
                'Enregistrer',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              )),
          IconButton(
            onPressed: () {
              setState(() {
                NotesDataBase.instance.deleteNote(NewID);
                Navigator.pop(context);
              });
            },
            icon: Icon(Icons.delete),
          )
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Container(
                    child: TextFormField(
                      initialValue: "$NewTitre",
                      decoration: InputDecoration(
                        hintStyle: TextStyle(
                          color: Colors.white70,
                        ),
                        hintText: 'Titre',
                        border: InputBorder.none,
                      ),
                      style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white70),
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      onChanged: (titre) {
                        setState(() {
                          NewTitre = titre;
                        });
                      },
                    ),
                  ),
                  Container(
                    child: TextFormField(
                      scrollPhysics: ScrollPhysics(),
                      initialValue: "$NewNote",
                      decoration: InputDecoration(
                        hintStyle: TextStyle(
                          color: Colors.white70,
                        ),
                        hintText: 'Ecrivez quelque choses...',
                        border: InputBorder.none,
                      ),
                      style: TextStyle(
                        color: Colors.white70,
                      ),
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      onChanged: (note) {
                        setState(() {
                          NewNote = note;
                        });
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  DateTime datetoday() {
    DateTime t = DateTime.now();
    return t;
  }
}
