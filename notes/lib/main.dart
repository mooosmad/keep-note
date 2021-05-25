import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes/ajouterNotes.dart';
import 'package:notes/data/notes.dart';
import 'package:notes/data/notesDatabase.dart';
import 'package:notes/modifierNotes.dart';

void main (){
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

class Home extends StatefulWidget{
  @override
  State<StatefulWidget>createState(){
    return _Home() ;
  }
}
class _Home extends State<Home>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(30, 80, 200, 1),
      floatingActionButton: FloatingActionButton(child: Icon(Icons.add),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (_)=>AjouteNote()));
        },
        backgroundColor: Color.fromRGBO(30, 80, 200, 1),),
      appBar: new AppBar(
        backgroundColor: Color.fromRGBO(30, 80, 200, 1),
        elevation: 0,
        toolbarHeight: 10,
      ),
      body: Column(
        children: [
          Flexible(
            flex: 1,
            child: Container(
              color: Colors.transparent,
              child: Center(
                child: Text(
                  'Activités',
                  style: TextStyle(
                    fontSize: 29, color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Flexible(
            flex: 7,
            child: Container(
              padding: EdgeInsets.only(
                right: 25,
                left: 25,
                top: 35,
                bottom: 20,
              ),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(40),
                  )
              ),
              child: FutureBuilder<List<DataNotes>>(
                future: NotesDataBase.instance.notes(),
                builder: (BuildContext context, AsyncSnapshot<List<DataNotes>>snapshot) {
                  if(snapshot.hasData){
                    List<DataNotes>? database_notes = snapshot.data;
                    return  GridView.builder(
                        itemCount: database_notes!.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                        itemBuilder: (BuildContext context,index){
                          return GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (_)=>ModifierNotes(dataNotes: database_notes[index],)));
                            },
                            child: Container(
                                margin: EdgeInsets.all(8),
                                height: 400,
                                width: 400,
                                color: Colors.grey[200],
                                child: Column(
                                  children: [
                                    Text(database_notes[index].titre.toUpperCase()),
                                    Text(database_notes[index].note.toUpperCase()),
                                  ],
                                ),
                                // child: Text(
                                //   database_notes[index].titre.toUpperCase(),
                                //   style: TextStyle(
                                //       color: Colors.black),
                                // ),
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
    );
  }
}