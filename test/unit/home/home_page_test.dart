import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:showcase_app/blocs/actions/actions_bloc.dart';
import 'package:showcase_app/blocs/actions/actions_event.dart';
import 'package:showcase_app/blocs/actions/actions_state.dart';
import 'package:showcase_app/blocs/welcome/welcome_bloc.dart';
import 'package:showcase_app/blocs/welcome/welcome_event.dart';
import 'package:showcase_app/blocs/welcome/welcome_state.dart';
import 'package:showcase_app/models/user.dart';
import 'package:showcase_app/views/home_page.dart';

class MockActionsBloc extends MockBloc<ActionsEvent, ActionsState>
    implements ActionsBloc {}

class MockWelcomeBloc extends MockBloc<WelcomeEvent, WelcomeState>
    implements WelcomeBloc {}

void main() {
  late MockActionsBloc mockActionsBloc;
  late MockWelcomeBloc mockWelcomeBloc;

  setUp(() {
    mockActionsBloc = MockActionsBloc();
    mockWelcomeBloc = MockWelcomeBloc();
  });

  testWidgets('HomePage renders widgets and validates form and welcome message',
      (WidgetTester tester) async {
    // Mock bloc states
    when(() => mockWelcomeBloc.state).thenReturn(
      WelcomeState(
        status: WelcomeStatus.success,
        message: "Welcome",
      ),
    );
    when(() => mockActionsBloc.state).thenReturn(
      ActionsState(
        status: ActionsStatus.loading,
        user: User(),
      ),
    );

    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider<WelcomeBloc>.value(value: mockWelcomeBloc),
          BlocProvider<ActionsBloc>.value(value: mockActionsBloc),
        ],
        child: Builder(
          builder: (_) => const MaterialApp(
            home: Scaffold(
              body: HomePage(),
            ),
          ),
        ),
      ),
    );
    expect(find.text('Welcome'), findsOneWidget);
    expect(find.text('Enter your name'), findsOneWidget);
    expect(find.text('Enter your nationality'), findsOneWidget);
    expect(find.text('Submit'), findsOneWidget);
  });

  testWidgets('HomePage loading welcome message', (WidgetTester tester) async {
    when(() => mockWelcomeBloc.state).thenReturn(
      WelcomeState(
        status: WelcomeStatus.loading,
        message: "Welcome",
      ),
    );
    when(() => mockActionsBloc.state).thenReturn(
      ActionsState(
        status: ActionsStatus.loading,
        user: User(),
      ),
    );
    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider<WelcomeBloc>.value(value: mockWelcomeBloc),
          BlocProvider<ActionsBloc>.value(value: mockActionsBloc),
        ],
        child: Builder(
          builder: (_) => const MaterialApp(
            home: Scaffold(
              body: HomePage(),
            ),
          ),
        ),
      ),
    );
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsAny);
  });
}
