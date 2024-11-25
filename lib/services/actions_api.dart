import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:showcase_app/models/visitor.dart';

class ActionsAPI {
  final dio = Dio();
  final url = dotenv.get('BASE_URL');

  Future<dynamic> postActions(Visitor visitor) async {
    try {
      Response response = await dio.post(
        "$url/actions",
        data: {'name': visitor.name, 'nationality': visitor.nationality},
      );
      if (response.statusCode != 200) {
        throw Exception(["Error: ${response.statusCode}"]);
      }
      return response.data;
    } catch (error) {
      return error;
    }
  }
}
