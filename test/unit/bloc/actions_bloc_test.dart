import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:showcase_app/blocs/actions/actions_bloc.dart';
import 'package:showcase_app/blocs/actions/actions_event.dart';
import 'package:showcase_app/blocs/actions/actions_state.dart';
import 'package:showcase_app/models/user.dart';
import 'package:showcase_app/repos/actions_repo.dart';

// Mock the ActionsRepo
class MockActionsRepo extends Mock implements ActionsRepo {}

// Create a fake User instance for mocktail
class FakeUser extends Fake implements User {}

void main() {
  // Register the fallback value before running the tests
  setUpAll(() {
    registerFallbackValue(FakeUser());
  });

  late ActionsBloc actionsBloc;
  late MockActionsRepo mockActionsRepo;

  // Initialize the mock repository and bloc before each test
  setUp(() {
    mockActionsRepo = MockActionsRepo();
    actionsBloc = ActionsBloc(actionsRepo: mockActionsRepo);
  });

  // Clean up after each test
  tearDown(() {
    actionsBloc.close();
  });

  group('ActionsBloc', () {
    test('initial state is ActionsState()', () {
      expect(actionsBloc.state, equals(ActionsState()));
    });

    blocTest<ActionsBloc, ActionsState>(
      'emits [loading, success] when SubmitDetails event is added and repository returns a user',
      build: () {
        // Mock the repository to return a user
        when(() => mockActionsRepo.submitDetails(any())).thenAnswer(
          (_) async => User(id: '123', name: 'John Doe'),
        );
        return actionsBloc;
      },
      act: (bloc) =>
          bloc.add(SubmitDetails(user: User(id: '123', name: 'John Doe'))),
      expect: () => [
        ActionsState(status: ActionsStatus.loading),
        ActionsState(
            status: ActionsStatus.success,
            user: User(id: '123', name: 'John Doe')),
      ],
    );

    blocTest<ActionsBloc, ActionsState>(
      'emits [loading, error] when SubmitDetails event is added and repository returns null',
      build: () {
        // Mock the repository to return null (user not found)
        when(() => mockActionsRepo.submitDetails(any())).thenAnswer(
          (_) async => null,
        );
        return actionsBloc;
      },
      act: (bloc) =>
          bloc.add(SubmitDetails(user: User(id: '123', name: 'John Doe'))),
      expect: () => [
        ActionsState(status: ActionsStatus.loading),
        ActionsState(status: ActionsStatus.error, user: null),
      ],
    );

    blocTest<ActionsBloc, ActionsState>(
      'emits [loading, error] when SubmitDetails event is added and repository throws an exception',
      build: () {
        // Mock the repository to throw an exception
        when(() => mockActionsRepo.submitDetails(any())).thenThrow(
          Exception('Error submitting details'),
        );
        return actionsBloc;
      },
      act: (bloc) =>
          bloc.add(SubmitDetails(user: User(id: '123', name: 'John Doe'))),
      expect: () => [
        ActionsState(status: ActionsStatus.loading),
        ActionsState(status: ActionsStatus.error, user: null),
      ],
    );
  });
}
