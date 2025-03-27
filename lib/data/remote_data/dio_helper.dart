import 'package:dio/dio.dart';

class DioFactory {
  Future<Dio> getDio() async {
    Dio dio = Dio();

    dio.options = BaseOptions(
        baseUrl: 'https://www.themealdb.com/api/json/v1/1/',
        receiveTimeout: Duration(milliseconds: 5000),
        sendTimeout: Duration(milliseconds: 5000));
    return dio;
  }
}
