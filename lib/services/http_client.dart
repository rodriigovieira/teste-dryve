import 'package:dio/dio.dart';

class ClientHttpService {
  Dio dio;

  ClientHttpService({String baseUrl = ""}) {
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        receiveTimeout: 10000,
      ),
    );
  }

  Future get(String path) async {
    Response response = await dio.get(path);

    return response.data;
  }
}
