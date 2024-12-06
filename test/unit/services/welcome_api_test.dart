import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:showcase_app/services/welcome_api.dart';

import 'actions_api_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  late MockDio mockDio;
  late WelcomeAPI welcomeAPI;

  setUp(() async {
    await dotenv.load(fileName: '.env');
    mockDio = MockDio();
    welcomeAPI = WelcomeAPI(dio: mockDio); // Inject the mocked Dio
  });

  group('WelcomeAPI', () {
    test('getWelcomeMessage returns a user on success', () async {
      final mockData = {"message": "123"};
      const String mockId = "123";
      final mockResponse = Response(
        requestOptions: RequestOptions(path: ''),
        statusCode: 200,
        data: mockData,
      );

      when(mockDio.get(
        any,
        data: anyNamed('data'),
      )).thenAnswer((_) async => mockResponse);

      final result = await welcomeAPI.getWelcomeMessage(mockId);

      expect(result["message"], isNotNull);
      expect(result["message"], equals('123'));
    });

    test('getWelcomeMessage throws an exception on error', () async {
      when(mockDio.get(
        any,
        data: anyNamed('data'),
      )).thenThrow(DioException(
        requestOptions: RequestOptions(
          path: '',
        ),
        error: 'Network Error',
      ));

      expect(() async => await welcomeAPI.getWelcomeMessage("??????"),
          throwsA(isA<DioException>()));
    });
  });
}
