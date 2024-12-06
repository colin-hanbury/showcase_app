import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcase_app/showcase_app.dart';

Future<void> main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  setUp(() async {
    dotenv.testLoad(fileInput: '''
    BASE_URL=http://localhost:8080
  ''');
    SharedPreferences.setMockInitialValues(
        {"userId": "abc1234-ab12-12ab-abc1-4321dcbaqqq1"});
  });

  group('HomePage Integration Test', () {
    testWidgets('handles submit button tap with empty input',
        (WidgetTester tester) async {
      await tester.pumpWidget(const ShowcaseApp());
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      final submitButton = find.text('Submit');
      expect(submitButton, findsOneWidget);
      await tester.tap(submitButton);
      await tester.pump();
      expect(find.text('Invalid input'), findsAny);
    });

    /// Server must be running for this test to pass
    testWidgets('handles submit button tap with valid input',
        (WidgetTester tester) async {
      await tester.pumpWidget(const ShowcaseApp());
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      final nameField = find.byKey(const Key('name-field'));
      expect(nameField, findsOneWidget);
      final nationalityField = find.byKey(const Key('nationality-field'));
      expect(nationalityField, findsOneWidget);
      await tester.enterText(nameField, "Test");
      await tester.enterText(nationalityField, "Testlandish");
      final submitButton = find.text('Submit');
      expect(submitButton, findsOneWidget);
      await tester.tap(submitButton);
      await tester.pump();
      expect(find.byType(CircularProgressIndicator), findsAtLeast(1));
      await tester.pumpAndSettle();
      expect(
          find.text('Welcome back Test my Testlandish friend'), findsOneWidget);
    });
  });
}
