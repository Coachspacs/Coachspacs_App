import 'package:flutter_test/flutter_test.dart';

import 'package:coachspacs/main.dart';

void main() {
  testWidgets('App renders successfully', (WidgetTester tester) async {
    await tester.pumpWidget(const CoachSpacsApp());
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
