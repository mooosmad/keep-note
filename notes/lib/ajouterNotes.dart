import 'package:flutter/material.dart';
import 'package:notes/data/notes.dart';
import 'package:notes/data/notesDatabase.dart';
import 'package:flutter/cupertino.dart';

class AjouteNote extends StatefulWidget{
  @override
  State<StatefulWidget>createState(){
    return _AjouterNote();
  }
}

class _AjouterNote extends State<AjouteNote> {
  var titre ;
  var note;
  List<DataNotes>? menotes = []; //pour gerer l'actualisation
  List<DataNotes>? compteur = []; //pour gerer les id uniques
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(30, 80, 200, 1),
        actions: [
          FlatButton(
              onPressed: (){
            Navigator.pop(context);
             setState((){
               if (titre != null && note != null ) {
                 NotesDataBase.instance.insertNote(
                     DataNotes(
                       id: compteur!.isEmpty
                           ? 1
                           : (compteur?[compteur!.length - 1].id)! + 1,
                       titre: titre.toUpperCase(),
                       note: note,
                       j: datetoday().day,
                       m:datetoday().month,
                       y: datetoday().year,
                       heure: datetoday().hour,
                       minute: datetoday().minute,
                     ),
                 );
               }
            });
          }, child: Text(
            'Enregistrer',
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
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
                    onChanged: (t) {
                      setState(() {
                        titre = t;
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
                    onChanged: (n) {
                      setState(() {
                        note = n;
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

