import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:showcase_app/models/user.dart';
import 'package:showcase_app/services/actions_api.dart';

import 'actions_api_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  late MockDio mockDio;
  late ActionsAPI actionsAPI;
  late User mockUser;

  setUp(() async {
    await dotenv.load(fileName: '.env');
    mockDio = MockDio();
    actionsAPI = ActionsAPI(dio: mockDio); // Inject the mocked Dio
    mockUser = User(id: '123', name: 'John Doe', nationality: 'American');
  });

  group('ActionsAPI', () {
    test('postActions returns a user on success', () async {
      final mockData = {
        "user": {
          "_id": "123",
          "name": "John Doe",
          "nationality": "American",
        },
      };
      final mockResponse = Response(
        requestOptions: RequestOptions(path: ''),
        statusCode: 200,
        data: mockData,
      );

      when(mockDio.post(
        any,
        data: anyNamed('data'),
      )).thenAnswer((_) async => mockResponse);

      final result = await actionsAPI.postActions(mockUser);

      expect(result["user"], isNotNull);
      expect(result["user"]["_id"], equals('123'));
      expect(result["user"]["name"], equals('John Doe'));
      expect(result["user"]["nationality"], equals('American'));
    });

    test('postActions throws an exception on error', () async {
      when(mockDio.post(
        any,
        data: anyNamed('data'),
      )).thenThrow(DioException(
        requestOptions: RequestOptions(
          path: '',
        ),
        error: 'Network Error',
      ));

      expect(() async => await actionsAPI.postActions(mockUser),
          throwsA(isA<DioException>()));
    });
  });
}
