import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:showcase_app/models/user.dart';
import 'package:showcase_app/repos/actions_repo.dart';
import 'package:showcase_app/services/actions_api.dart';

class MockActionsAPI extends Mock implements ActionsAPI {}

void main() {
  late MockActionsAPI mockActionsAPI;
  late ActionsRepo actionsRepo;

  setUp(() {
    mockActionsAPI = MockActionsAPI();
    actionsRepo = ActionsRepo(actionsAPI: mockActionsAPI);
  });

  setUpAll(() {
    registerFallbackValue(User(name: "Test", nationality: "Test"));
  });

  test('submitDetails returns a User when API call is successful', () async {
    final mockResponse = {
      "user": {
        "_id": "123", // Changed key to match the code in ActionsRepo
        "name": "John",
        "nationality": "US",
      }
    };

    when(() => mockActionsAPI.postActions(any<User>()))
        .thenAnswer((_) async => mockResponse);

    final user =
        await actionsRepo.submitDetails(User(name: "John", nationality: "US"));

    expect(user, isNotNull);
    expect(user!.id, "123");
    expect(user.name, "John");
    expect(user.nationality, "US");
  });

  test('submitDetails returns null when API call fails', () async {
    when(() => mockActionsAPI.postActions(any<User>()))
        .thenThrow(Exception("Error"));

    final user =
        await actionsRepo.submitDetails(User(name: "John", nationality: "US"));

    expect(user, isNull);
  });
}
