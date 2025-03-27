import 'package:dio/dio.dart';

class RemoteDataSource {
  final Dio _dio;

  RemoteDataSource(this._dio);
  Future<List<dynamic>> serachMeal(String meal) async {
    var list;
    await _dio.get("search.php?s=${meal}").then((value) {
      list = value.data['meals'];
    });
    return list;
  }

  Future<List<dynamic>?> serachCategory(String category) async {
    var list;
    await _dio.get("filter.php?c=${category}").then((value) {
      list = value.data['meals'];
    });
    return list;
  }
}
