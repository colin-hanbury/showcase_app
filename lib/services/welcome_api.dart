import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class WelcomeAPI {
  WelcomeAPI({
    Dio? dio,
    String? url,
  })  : dio = dio ?? Dio(),
        url = dotenv.get('BASE_URL');

  final Dio dio;
  final String url;

  Future<dynamic> getWelcomeMessage(String id) async {
    try {
      Response response = await dio.get("$url/welcome?id=$id");
      if (response.statusCode != 200) {
        throw DioException(
          message: "Error: ${response.statusCode}",
          requestOptions: RequestOptions(
            path: '/welcome',
          ),
        );
      }
      return response.data;
    } catch (error) {
      rethrow;
    }
  }
}
