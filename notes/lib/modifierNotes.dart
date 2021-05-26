import 'package:flutter/material.dart';
import 'package:notes/data/notes.dart';
import 'package:notes/data/notesDatabase.dart';

class ModifierNotes extends StatefulWidget {
   DataNotes dataNotes;
   ModifierNotes({required this.dataNotes});
  @override
  _ModifierNotesState createState() => _ModifierNotesState();
}

class _ModifierNotesState extends State<ModifierNotes> {
  var NewTitre, NewNote;
  @override
  void initState() {
    super.initState();
    NewTitre = widget.dataNotes.titre;
    NewNote = widget.dataNotes.note;
  }

  var titre ;
  var note;
  var newData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(30, 80, 200, 1),
        actions: [
          FlatButton(
              onPressed: (){
                setState((){
                  DataNotes newData = DataNotes(
                    id:widget.dataNotes.id,
                    titre: NewTitre,
                    note: NewNote,
                    j: widget.dataNotes.j,
                    m: widget.dataNotes.m,
                    y: widget.dataNotes.y,
                    heure: widget.dataNotes.heure,
                    minute: widget.dataNotes.minute,
                  );
                });
                NotesDataBase.instance.updateNote(newData);
                Navigator.pop(context);
              }, child: Text(
            'Enregistrer',
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ))
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Container(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Titre',
                      hintStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      border : InputBorder.none,
                    ),
                    onChanged: (titre) {
                      setState(() {
                        NewTitre = titre;
                      });
                    },
                    keyboardType: TextInputType.text,
                    obscureText: false,
                    maxLength: 20,
                    maxLines: 1,
                    autocorrect: true,
                  ),
                ),
                Container(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Notes',
                      hintStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      border : InputBorder.none,
                    ),
                    onChanged: (note) {
                      setState(() {
                        NewNote = note;
                      });
                    },
                    keyboardType: TextInputType.text,
                    autocorrect: true,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  DateTime datetoday() {
    DateTime t = DateTime.now();
    return t;
  }

}
