import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcase_app/blocs/welcome/welcome_bloc.dart';
import 'package:showcase_app/blocs/welcome/welcome_event.dart';
import 'package:showcase_app/blocs/welcome/welcome_state.dart';
import 'package:showcase_app/repos/welcome_repo.dart';

class MockWelcomeRepo extends Mock implements WelcomeRepo {}

void main() {
  late MockWelcomeRepo mockWelcomeRepo;
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    mockWelcomeRepo = MockWelcomeRepo();
  });

  blocTest<WelcomeBloc, WelcomeState>(
    'emits [loading, success] when GetWelcomeMessage is successful',
    build: () {
      SharedPreferences.setMockInitialValues({"userId": "123"});
      when(() => mockWelcomeRepo.getWelcomeMessage("123"))
          .thenAnswer((_) async => "Welcome Test");
      return WelcomeBloc(welcomeRepo: mockWelcomeRepo);
    },
    act: (bloc) => bloc.add(GetWelcomeMessage()),
    expect: () => [
      WelcomeState(status: WelcomeStatus.loading),
      WelcomeState(status: WelcomeStatus.success, message: "Welcome Test")
    ],
  );

  blocTest<WelcomeBloc, WelcomeState>(
    'emits [loading, error] when GetWelcomeMessage fails',
    build: () {
      SharedPreferences.setMockInitialValues({"userId": ""});
      when(() => mockWelcomeRepo.getWelcomeMessage(""))
          .thenThrow(Exception("Error"));
      return WelcomeBloc(welcomeRepo: mockWelcomeRepo);
    },
    act: (bloc) => bloc.add(GetWelcomeMessage()),
    expect: () => [
      WelcomeState(status: WelcomeStatus.loading),
      WelcomeState(status: WelcomeStatus.error, message: "Exception: Error")
    ],
  );
}
