import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:showcase_app/showcase_app.dart';

void main() {
  group('end-to-end', () {
    testWidgets('tap on the floating action button, verify counter',
        (tester) async {
      await tester.pumpWidget(const ShowcaseApp());

      expect(find.text('Submit'), findsOneWidget);
      expect(find.text('Welcome'), findsOneWidget);
      expect(find.text('Hi'), findsOneWidget);

      final submitButton = find.byKey(const ValueKey('submit'));
      final visitorName = find.byKey(const ValueKey('name'));
      final visitorNationality = find.byKey(const ValueKey('nationality'));

      tester.enterText(visitorName, 'Tester');
      tester.enterText(visitorNationality, 'est');
      await tester.tap(submitButton);

      await tester.pumpAndSettle();

      expect(find.text('Welcome Tester'), findsOneWidget);
      expect(find.text("It's a great day to alive and test"), findsOneWidget);
    });
  });
}
