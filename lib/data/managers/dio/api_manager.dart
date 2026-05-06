import 'package:dio/dio.dart';

class ApiManager {
  ApiManager(this._dio);

  final Dio _dio;

  Future<Response<dynamic>> post({
    required String path,
    required Map<String, dynamic> data,
  }) {
    return _dio.post<dynamic>(path, data: data);
  }
}
