import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class WelcomeAPI {
  final dio = Dio();
  final url = dotenv.get('BASE_URL');

  Future<dynamic> getWelcomeMessage(String id) async {
    try {
      Response response = await dio.get("$url/welcome?id=$id");
      if (response.statusCode != 200) {
        throw Exception(["Error: ${response.statusCode}"]);
      }
      return response.data;
    } catch (error) {
      return error;
    }
  }
}
