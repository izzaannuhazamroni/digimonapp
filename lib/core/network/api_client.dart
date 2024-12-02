import 'package:dio/dio.dart';

class ApiClient {
  static Dio createClient() {
    final dio = Dio();
    dio.options.baseUrl = 'https://digimon-api.vercel.app';
    dio.options.connectTimeout = const Duration(seconds: 5); // 5 seconds
    dio.options.receiveTimeout = const Duration(seconds: 3); // 3 seconds
    return dio;
  }
}
