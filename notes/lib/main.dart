import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes/ajouterNotes.dart';
import 'package:notes/data/notes.dart';
import 'package:notes/data/notesDatabase.dart';

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
                    List<DataNotes>? mesNotes = snapshot.data;
                    return  GridView.builder(
                        itemCount: mesNotes!.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                        itemBuilder: (context,index){
                          return Center(
                            child: Container(
                              margin: EdgeInsets.all(8),
                              height: 200,
                              color: Colors.grey[200],
                              child: Text(
                                mesNotes[index].titre.toUpperCase(),
                                style: TextStyle(
                                    color: Colors.white),
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
    );
  }
}