import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseHelper {
  static final DataBaseHelper _instance = DataBaseHelper.internal();

  factory DataBaseHelper() => _instance;

  static Database? db;

  Future<Database> getDb() async {
    if (db != null) {
      return db!;
    }
    db = await initDb();
    return db!;
  }

  DataBaseHelper.internal();

  Future<Database> initDb() async {
    try {
      String databasePath = await getDatabasesPath();
      String path = join(databasePath, 'users.db');

      db = await openDatabase(path, version: 1, onCreate: _onCreate);
      print('INITDB COMPLETED ##############');
      return db!;
    } catch (e) {
      throw Exception('INITDB FAILED ^^^^^^^^^^^ $e');
    }
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
        '''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY,
        name TEXT,
        username TEXT,
        email TEXT,
        street TEXT,
        suite TEXT,
        city TEXT,
        zipcode TEXT,
        lat TEXT,
        lng TEXT,
        phone TEXT,
        website TEXT,
        companyName TEXT,
        catchPhrase TEXT,
        bs TEXT
      )
    ''');
  }
}
