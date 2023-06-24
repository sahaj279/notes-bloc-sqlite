import 'package:bloc_and_notes/models/note_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
class NotesDatabase{
  static final NotesDatabase instance=NotesDatabase._init();
  static Database? _database;

  NotesDatabase._init();
  //opening database
  Future<Database> get database async{
    if(_database!=null)return _database!;
    _database=await _initDB('notes1.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath)async{
    final dbPath=await getDatabasesPath(); 
    String path=join(dbPath,filePath);
    return await openDatabase(path,version: 1,onCreate: _createDB);
  }

//creating the table
  Future _createDB(Database db, int version)async{
    const idType='INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType='TEXT NOT NULL';
    await db.execute('''CREATE TABLE $tableNotes (
      ${NoteFiels.id} $idType,
      ${NoteFiels.title} ,
      ${NoteFiels.desc} ,
      ${NoteFiels.datetime} $textType,
      ${NoteFiels.date} $textType

      ) ''');
  }

  //creating a new note
  Future <Note> create(Note note)async{
    final db=await instance.database;
    final id=await db.insert(tableNotes, note.toMap());
    return note.copy(id:id);
  }

  //reading note by id
  Future<List<Note>> readNoteForDate(String date)async{
    final db=await instance.database;
    final maps=await db.query(tableNotes, columns: NoteFiels.values,where: '${NoteFiels.date} = ?', whereArgs: [date]);
    return maps.map((json)=>Note.fromJson(json)).toList();
  }

  //reading all notes
  Future<List<Note>> readAllNotes()async{
    final db=await instance.database;
    final result=await db.query(tableNotes);
    return result.map((json)=>Note.fromJson(json)).toList();
  }
  //getting list of distinct dates for marking on calendar
  Future<List<String>> getDistinctDates()async{
    final db=await instance.database;
    final dates=await db.rawQuery('''SELECT DISTINCT ${NoteFiels.date} from $tableNotes ''');
    return dates.map((json)=>json['date'].toString()).toList();
  }
//closing database
  Future close()async{
    final db=await instance.database;
    db.close();
  }
}