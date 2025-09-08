// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:skill_up/main.dart';
import 'package:skill_up/core/state/app_state.dart';
import 'package:skill_up/core/services/prefs_service.dart';

void main() {
  testWidgets('App renders without errors', (WidgetTester tester) async {
    final appState = AppState(PrefsService());
    // Avoid awaiting load to keep test simple; theme defaults to system.
    await tester.pumpWidget(SkillUpApp(appState: appState));
    // First pump builds FutureBuilder, second resolves microtasks.
    await tester.pump(const Duration(milliseconds: 100));
    // Should show either onboarding, login, or home shell; just ensure MaterialApp present.
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
