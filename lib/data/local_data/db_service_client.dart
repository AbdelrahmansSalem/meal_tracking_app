import 'package:meal_tracking_app/domain/models.dart';
import 'package:sqflite/sqflite.dart';

class DbServiceClient {
  DbServiceClient(this._database);
  final Database _database;

  Future<void> insertToDatabase(Meal meal) async {
    await _database.transaction((txn) async {
      await txn
          .insert(
        'meals',
        {
          'name': meal.name,
          'calories': meal.calories,
          'time': meal.time,
          'image': meal.image,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      )
          .then((value) {
        print("$value inserted successfully");
      }).catchError((onError) {
        print("Inserting error: ${onError.toString()}");
      });
    });
  }

  Future<List<Map<String, dynamic>>> getData() async {
    return await _database.query('meals');
  }

  deleteFromDatabase({required int id}) async {
    await _database.rawDelete("delete from meals where id=?", [id]);
  }
}
