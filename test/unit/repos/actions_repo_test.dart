import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:showcase_app/models/user.dart';
import 'package:showcase_app/repos/actions_repo.dart';
import 'package:showcase_app/services/actions_api.dart';

// Mock ActionsAPI class
class MockActionsAPI extends Mock implements ActionsAPI {}

void main() {
  late ActionsRepo actionsRepo;
  late MockActionsAPI mockActionsAPI;

  setUp(() {
    mockActionsAPI = MockActionsAPI();
    actionsRepo = ActionsRepo(actionsAPI: mockActionsAPI);
  });

  group('ActionsRepo', () {
    test('should return a User when submitDetails is successful', () async {
      final user = User(name: 'John Doe', nationality: 'American');
      final response = {
        'user': {
          '_id': '123',
          'name': 'John Doe',
          'nationality': 'American',
        }
      };

      // Mock the postActions method to return a successful response
      when(() => mockActionsAPI.postActions(user))
          .thenAnswer((_) async => response);

      final result = await actionsRepo.submitDetails(user);

      // Assert that the returned User is correctly mapped
      expect(result, isA<User>());
      expect(result?.id, '123');
      expect(result?.name, 'John Doe');
      expect(result?.nationality, 'American');
      verify(() => mockActionsAPI.postActions(user)).called(1);
    });

    test('should return null when submitDetails fails', () async {
      final user = User(name: 'John Doe', nationality: 'American');

      // Mock the postActions method to throw an error
      when(() => mockActionsAPI.postActions(user))
          .thenThrow(Exception('Failed to submit details'));

      final result = await actionsRepo.submitDetails(user);

      // Assert that the result is null when an error occurs
      expect(result, isNull);
      verify(() => mockActionsAPI.postActions(user)).called(1);
    });

    test('should return null when submitDetails gets an unexpected response',
        () async {
      final user = User(name: 'John Doe', nationality: 'American');
      final invalidResponse = {'user': null}; // Invalid response

      // Mock the postActions method to return an invalid response
      when(() => mockActionsAPI.postActions(user))
          .thenAnswer((_) async => invalidResponse);

      final result = await actionsRepo.submitDetails(user);

      // Assert that the result is null when the response is invalid
      expect(result, isNull);
      verify(() => mockActionsAPI.postActions(user)).called(1);
    });

    test('should log the error when submitDetails fails with an error',
        () async {
      final user = User(name: 'John Doe', nationality: 'American');

      // Mock the postActions method to throw an error
      when(() => mockActionsAPI.postActions(user))
          .thenThrow(Exception('Error during API call'));

      // We can mock log to check if the error was logged
      final logSpy = SpyLog();
      actionsRepo.submitDetails(user);

      // Assert that the error is logged
      expect(logSpy.lastLog, contains('Error during API call'));
    });
  });
}

// A simple spy to check the logs
class SpyLog {
  String? lastLog;

  void log(String message) {
    lastLog = message;
  }
}
