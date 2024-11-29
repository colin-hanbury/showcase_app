import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:showcase_app/showcase_app.dart';

Future<void> main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  setUp(() async {
    dotenv.testLoad(fileInput: '''
    BASE_URL=https://example.com
  ''');
  });
  group('HomePage Integration Test', () {
    testWidgets('handles submit button tap with empty input',
        (WidgetTester tester) async {
      await tester.pumpWidget(const ShowcaseApp());
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Submit'), findsAny);
      await tester.tap(find.text('Submit'));
      await tester.pump();
      expect(find.text('Invalid input'), findsAny);
    });
  });
}
