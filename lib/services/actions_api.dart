import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:showcase_app/models/user.dart';

class ActionsAPI {
  ActionsAPI({
    Dio? dio,
    String? url,
  })  : dio = dio ?? Dio(),
        url = dotenv.get('BASE_URL');

  final Dio dio;
  final String url;

  Future<dynamic> postActions(User user) async {
    try {
      final data = {'name': user.name, 'nationality': user.nationality};
      Response response = await dio.post(
        "$url/actions",
        data: data,
      );
      if (response.statusCode != 200) {
        throw DioException(
            message: "Error: ${response.statusCode}",
            requestOptions: RequestOptions(path: '/actions', data: data));
      }
      return response.data;
    } catch (error) {
      rethrow;
    }
  }
}
