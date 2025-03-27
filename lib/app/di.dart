import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:meal_tracking_app/data/local_data/db_factory.dart';
import 'package:meal_tracking_app/data/local_data/db_service_client.dart';
import 'package:meal_tracking_app/data/remote_data/dio_helper.dart';
import 'package:meal_tracking_app/data/remote_data/remote_data_source.dart';
import 'package:sqflite/sqflite.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  final Database database = await DbFactory().getDatabase();
  instance
      .registerLazySingleton<DbServiceClient>(() => DbServiceClient(database));

  final Dio dio = await DioFactory().getDio();
  instance.registerLazySingleton<RemoteDataSource>(() => RemoteDataSource(dio));
}
