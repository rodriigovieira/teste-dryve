import 'package:dio/dio.dart';
import 'package:dryve_test/interfaces/http_client.dart';

class ClientHttpService implements IClientHttp {
  Dio dio;

  ClientHttpService({String baseUrl = ""}) {
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        receiveTimeout: 10000,
      ),
    );
  }

  @override
  Future get(String path) async {
    Response response = await dio.get(path);

    return response.data;
  }
}
