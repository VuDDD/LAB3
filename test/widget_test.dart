// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:dice/main.dart';

void main() {
  testWidgets('two dice can be rerolled by tapping a die', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const DiceApp());

    expect(find.text('Dice'), findsOneWidget);
    expect(find.byType(Image), findsNWidgets(2));

    List<int> visibleValues() {
      final labels = tester
          .widgetList<Semantics>(find.byType(Semantics))
          .map((widget) => widget.properties.label)
          .where((label) => label?.startsWith('Xúc xắc') ?? false)
          .cast<String>();
      return labels
          .map(
            (label) =>
                int.parse(RegExp(r'mặt ([1-6])').firstMatch(label)!.group(1)!),
          )
          .toList();
    }

    expect(visibleValues(), hasLength(2));
    expect(visibleValues(), everyElement(inInclusiveRange(1, 6)));

    await tester.tap(find.byType(InkWell).first);
    await tester.pump();

    expect(visibleValues(), hasLength(2));
    expect(visibleValues(), everyElement(inInclusiveRange(1, 6)));
  });
}
