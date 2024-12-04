import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcase_app/blocs/actions/actions_bloc.dart';
import 'package:showcase_app/blocs/actions/actions_event.dart';
import 'package:showcase_app/blocs/actions/actions_state.dart';
import 'package:showcase_app/models/user.dart';
import 'package:showcase_app/repos/actions_repo.dart';

class MockActionsRepo extends Mock implements ActionsRepo {}

void main() {
  late MockActionsRepo mockActionsRepo;
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    mockActionsRepo = MockActionsRepo();
  });

  blocTest<ActionsBloc, ActionsState>(
    'emits [loading, success] when SubmitDetails is successful',
    build: () {
      SharedPreferences.setMockInitialValues({"test": "id"});
      when(() => mockActionsRepo
              .submitDetails(User(name: 'John', nationality: 'US')))
          .thenAnswer(
              (_) async => User(id: "123", name: "John", nationality: "US"));
      return ActionsBloc(actionsRepo: mockActionsRepo);
    },
    act: (bloc) =>
        bloc.add(SubmitDetails(user: User(name: "John", nationality: "US"))),
    expect: () => [
      ActionsState(status: ActionsStatus.loading),
      ActionsState(
          status: ActionsStatus.success,
          user: User(id: "123", name: "John", nationality: "US"))
    ],
  );

  blocTest<ActionsBloc, ActionsState>(
    'emits [loading, error] when SubmitDetails fails',
    build: () {
      when(() => mockActionsRepo.submitDetails(User()))
          .thenThrow(Exception("Error"));
      return ActionsBloc(actionsRepo: mockActionsRepo);
    },
    act: (bloc) =>
        bloc.add(SubmitDetails(user: User(name: "John", nationality: "US"))),
    expect: () => [
      ActionsState(status: ActionsStatus.loading),
      ActionsState(status: ActionsStatus.error)
    ],
  );
}
