import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:notes/data/notes.dart';

class NotesDataBase {
  NotesDataBase._();
  static NotesDataBase instance = NotesDataBase._();

  static Database? db;

  Future<Database> get database async {
    if (db != null) {
      return db!;
    } else {
      db = await initDB();
      return db!;
    }
  }

  initDB() async {
    WidgetsFlutterBinding.ensureInitialized();
    return await openDatabase(
      join(await getDatabasesPath(), "database_notes.db"),
      onCreate: (db, i) {
        return db.execute(
          "CREATE TABLE note(titre TEXT,note TEXT,name TEXT,jour INT,mois INT,annee INT,heure INT,minute INT)",
        );
      },
      version: 1,
    );
  }

  insertNote(DataNotes dataNotes) async {
    final Database tdb = await database;
    await tdb.insert(
      "note",
      dataNotes.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  updateNote(DataNotes dataNotes) async {
    final Database tdb = await database;
    await tdb.update(
      "note",
      dataNotes.toMap(),
      where: "titre=?",
      whereArgs: [dataNotes.titre],
    );
  }

  deleteNote(String titre) async {
    final Database tdb = await database;
    tdb.delete(
      "note",
      where: "titre=?",
      whereArgs: [titre],
    );
  }

  Future<List<DataNotes>> notes() async {
    final Database tdb = await database;
    List<Map<String, dynamic>> maps = await tdb.query("note");
    List<DataNotes> mesnotes = List.generate(
      maps.length,
          (index) {
        return DataNotes.fromMap(maps[index]);
      },
    );
    /* if (mesnotes.isEmpty) {
       for (MiniCont m in defaultNotes) {
         insertNote(m);
       }
       mesnotes = defaultNotes;
     }
    ON ELEVE LE RETOUR OBLIGATOIRE(POUR NE PAS QUE LES ELEMENTS PAR DEFAULT REAPPARAISSE UNE FOIS SUPPRIMER)
    */
    return mesnotes;
  }
  
}
