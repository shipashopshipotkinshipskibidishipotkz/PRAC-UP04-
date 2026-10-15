import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:calc_web/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const CalcApp(isDarkMode: false));

    expect(find.text('Калькулятор и конвертер'), findsOneWidget);
    expect(find.text('Калькулятор'), findsOneWidget);
    expect(find.text('Конвертер валют'), findsOneWidget);
  });
}