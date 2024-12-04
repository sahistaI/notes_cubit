
import 'package:notes_cubit/note_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DbHelper {

  DbHelper._();

static DbHelper getInstance() =>DbHelper._();

Database? mDb;
  static final String TABLE_NOTE = "cubnote";
  static final String NOTE_COLUMN_ID = "n_id";
  static final String NOTE_COLUMN_TITLE = "n_title";
  static final String NOTE_COLUMN_DESC = "n_desc";

Future<Database> initDB() async {
mDb = mDb ?? await openDB();
print("db Opened!!");
return mDb!;
}


Future<Database> openDB() async {

  var dirPath =await getApplicationDocumentsDirectory();
  var dbPath =join(dirPath.path, "cubnote.db");

  return openDatabase(dbPath, version: 1, onCreate: (db, version){
  print("db Created");
  db.execute("create table $TABLE_NOTE ( $NOTE_COLUMN_ID integer primary key autoincrement, $NOTE_COLUMN_TITLE text, $NOTE_COLUMN_DESC text)");
  });

}


// insert
Future<bool> addNote(NoteModel newnote) async{

Database db = await initDB();

int rowsEffected = await db.insert(TABLE_NOTE, newnote.toMap());
return rowsEffected>0;
}
// select

Future<List<NoteModel>>fetchNote() async {

  Database db = await initDB();
  List<NoteModel> mNotes = [];

  List<Map<String,dynamic>> allNotes =await db.query(TABLE_NOTE);

  for(Map<String,dynamic> eachData in allNotes){
  NoteModel eachNote =NoteModel.fromMap(eachData);
  mNotes.add(eachNote);

  }

  return mNotes;

}
//update

 Future<bool> updateNote({required NoteModel updateNote}) async{

  Database db =await initDB();

  int rowsEffected = await db.update(TABLE_NOTE, updateNote.toMap(),where: "$NOTE_COLUMN_ID =?", whereArgs: [updateNote.id]);

  return rowsEffected>0;
}
// delete

Future<bool> deleteNotes({required int id}) async{

  Database db = await initDB();

  int rowsEffected = await db.delete(TABLE_NOTE,where: "$NOTE_COLUMN_ID =?",whereArgs:['$id']);

  return rowsEffected >0;

}

}




