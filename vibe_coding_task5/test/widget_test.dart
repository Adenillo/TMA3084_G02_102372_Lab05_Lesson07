import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:vibe_coding_task5/main.dart';

void main() {
  testWidgets('Bottom navigation switches tabs', (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (context) => TabModel(),
        child: const MaterialApp(
          home: BottomNavLab(),
        ),
      ),
    );

    expect(
      tester.widget<BottomNavigationBar>(
        find.byType(BottomNavigationBar),
      ).currentIndex,
      0,
    );

    await tester.tap(find.text('Alarm').last);
    await tester.pumpAndSettle();

    expect(
      tester.widget<BottomNavigationBar>(
        find.byType(BottomNavigationBar),
      ).currentIndex,
      1,
    );
  });
}