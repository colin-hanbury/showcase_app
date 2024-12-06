import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:showcase_app/repos/welcome_repo.dart';
import 'package:showcase_app/services/welcome_api.dart';

class MockWelcomeAPI extends Mock implements WelcomeAPI {}

void main() {
  late MockWelcomeAPI mockWelcomeAPI;
  late WelcomeRepo welcomeRepo;

  setUp(() {
    mockWelcomeAPI = MockWelcomeAPI();
    welcomeRepo = WelcomeRepo(welcomeApi: mockWelcomeAPI);
  });

  setUpAll(() {
    registerFallbackValue("test");
  });

  test('getWelcomeMessage returns a message when API call is successful',
      () async {
    final mockResponse = {"message": "123"};

    when(() => mockWelcomeAPI.getWelcomeMessage(any<String>()))
        .thenAnswer((_) async => mockResponse);

    final message = await welcomeRepo.getWelcomeMessage("123");

    expect(message, isNotNull);
    expect(message, "123");
  });

  test('submitDetails returns null when API call fails', () async {
    when(() => mockWelcomeAPI.getWelcomeMessage(any<String>()))
        .thenThrow(Exception("Error"));

    final user = await welcomeRepo.getWelcomeMessage("?????");

    expect(user, isNull);
  });
}
