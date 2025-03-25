import 'package:get_it/get_it.dart';
import 'package:meal_tracking_app/data/db_factory.dart';
import 'package:meal_tracking_app/data/db_service_client.dart';
import 'package:sqflite/sqflite.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  final Database database = await DbFactory().getDatabase();
  instance.registerSingleton<DbServiceClient>(DbServiceClient(database));
}
