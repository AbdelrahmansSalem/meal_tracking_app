import 'package:sqflite/sqflite.dart';

class DbFactory {
  Future<Database> getDatabase() async {
    return await openDatabase(
      'Meals.db',
      version: 1,
      onCreate: (db, version) {
        print("Database Created");
        db.execute(
            'CREATE TABLE meals (id INTEGER PRIMARY KEY, name TEXT, calories TEXT, time TEXT,image BLOB)');
      },
      onOpen: (db) {},
    );
  }
}
