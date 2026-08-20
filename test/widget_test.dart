import 'package:flutter_test/flutter_test.dart';

import 'package:coach_space/core/di/injection_container.dart';
import 'package:coach_space/main.dart';

void main() {
  setUpAll(setupLocator);

  testWidgets('Coach Space app smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const CoachSpaceApp());

    expect(find.byType(CoachSpaceApp), findsOneWidget);
  });
}
