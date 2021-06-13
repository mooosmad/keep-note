import 'package:flutter/material.dart';
import 'package:notes/data/notes.dart';
import 'package:notes/data/notesDatabase.dart';
import "package:date_time_format/date_time_format.dart";

// ignore: must_be_immutable
class ModifierNotes extends StatefulWidget {
  DataNotes dataNotes;
  ModifierNotes({required this.dataNotes});
  @override
  _ModifierNotesState createState() => _ModifierNotesState();
}

class _ModifierNotesState extends State<ModifierNotes> {
  var NewTitre, NewNote, NewID, NewDateEnr;
  @override
  void initState() {
    NewTitre = widget.dataNotes.titre;
    NewNote = widget.dataNotes.note;
    NewID = widget.dataNotes.id;
    NewDateEnr = widget.dataNotes.dateEnr;
    super.initState();
  }

  String datetoday() {
    DateTime t = DateTime.now();
    return t.format("j M Y  H:i");
  }

  List<DataNotes>? menotes = [];
  var titre;
  var note;
  var newData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1F1D2B),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              backgroundColor: Color(0xFF272636),
              title: const Text(
                'Enregistrer',
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
              content: const Text(
                'Voulez vous enregistrez ?',
                style: TextStyle(color: Colors.white70),
                textAlign: TextAlign.center,
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, 'Non');
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Non',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      DataNotes newData = DataNotes(
                        id: widget.dataNotes.id,
                        titre: NewTitre,
                        note: NewNote,
                        dateEnr: datetoday(),
                      );
                      NotesDataBase.instance.updateNote(newData);
                      Navigator.pop(context);
                      Navigator.pop(context);
                    });
                  },
                  child: const Text(
                    'Oui',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        elevation: 0,
        backgroundColor: Color(0xFF1F1D2B),
        actions: [
          // ignore: deprecated_member_use
          IconButton(
            onPressed: () {
              setState(() {
                DataNotes newData = DataNotes(
                  id: widget.dataNotes.id,
                  titre: NewTitre,
                  note: NewNote,
                  dateEnr: datetoday(),
                );
                NotesDataBase.instance.updateNote(newData);
                Navigator.pop(context);
              });
            },
            icon: Icon(Icons.save),
          ),
          IconButton(
            onPressed: () => showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                backgroundColor: Color(0xFF272636),
                title: const Text(
                  'Supprimer',
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                content: const Text(
                  'Êtes vous sûr de vouloir supprimer la note ?',
                  style: TextStyle(color: Colors.white70),
                  textAlign: TextAlign.center,
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'Non'),
                    child: const Text(
                      'Non',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        NotesDataBase.instance.deleteNote(NewID);
                        Navigator.pop(context);
                        Navigator.pop(context);
                      });
                    },
                    child: const Text(
                      'Oui',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
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
      bottomSheet: Container(
        color: Color(0xFF1F1D2B),
        alignment: Alignment.bottomCenter,
        height: 50,
        child: Column(
          children: [
            Text(
              'Dernière modification: ${NewDateEnr}',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
