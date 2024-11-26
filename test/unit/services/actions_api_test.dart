import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:showcase_app/models/user.dart';
import 'package:showcase_app/services/actions_api.dart';

// Mock Dio class
class MockDio extends Mock implements Dio {}

void main() {
  late ActionsAPI actionsAPI;
  late MockDio mockDio;

  // Set up dotenv mock
  setUpAll(() {
    dotenv.load();
    when(() => dotenv.get('BASE_URL')).thenReturn('https://fakeapi.com');
  });

  setUp(() {
    mockDio = MockDio();
    actionsAPI = ActionsAPI();
  });

  group('ActionsAPI', () {
    test('should return response data when postActions is successful',
        () async {
      final user = User(name: 'John Doe', nationality: 'American');
      final mockResponse = Response(
        requestOptions: RequestOptions(path: ''),
        statusCode: 200,
        data: {'message': 'success'},
      );

      // Mock the Dio post method to return a successful response
      when(() => mockDio.post(any(), data: any(named: 'data'))).thenAnswer(
        (_) async => mockResponse,
      );

      // Perform the actual test
      final result = await actionsAPI.postActions(user);

      expect(result, {'message': 'success'});
      verify(() => mockDio.post('https://fakeapi.com/actions',
          data: {'name': 'John Doe', 'nationality': 'American'})).called(1);
    });

    test('should throw error when postActions returns non-200 status code',
        () async {
      final user = User(name: 'John Doe', nationality: 'American');
      final mockResponse = Response(
        requestOptions: RequestOptions(path: ''),
        statusCode: 400,
        data: {'message': 'bad request'},
      );

      // Mock the Dio post method to return a response with a non-200 status code
      when(() => mockDio.post(any(), data: any(named: 'data'))).thenAnswer(
        (_) async => mockResponse,
      );

      // Perform the actual test
      expect(() => actionsAPI.postActions(user), throwsA(isA<Exception>()));
    });

    test('should handle exception and return the error', () async {
      final user = User(name: 'John Doe', nationality: 'American');

      // Mock the Dio post method to throw an error
      when(() => mockDio.post(any(), data: any(named: 'data')))
          .thenThrow(DioException(
        requestOptions: RequestOptions(path: ''),
        type: DioExceptionType.badResponse,
        error: 'Network Error',
      ));

      // Perform the actual test
      final result = await actionsAPI.postActions(user);

      expect(result, isA<DioException>());
    });
  });
}
