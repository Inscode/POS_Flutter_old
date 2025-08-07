// // This is a basic Flutter widget test.
// //
// // To perform an interaction with a widget in your test, use the WidgetTester
// // utility in the flutter_test package. For example, you can send tap and scroll
// // gestures. You can also use WidgetTester to find child widgets in the widget
// // tree, read text, and verify that the values of widget properties are correct.

// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';

// import 'package:pos_system/main.dart';

// void main() {
//   testWidgets('Counter increments smoke test', (WidgetTester tester) async {
//     // Build our app and trigger a frame.
//     await tester.pumpWidget(const MyApp());

//     // Verify that our counter starts at 0.
//     expect(find.text('0'), findsOneWidget);
//     expect(find.text('1'), findsNothing);

//     // Tap the '+' icon and trigger a frame.
//     await tester.tap(find.byIcon(Icons.add));
//     await tester.pump();

//     // Verify that our counter has incremented.
//     expect(find.text('0'), findsNothing);
//     expect(find.text('1'), findsOneWidget);
//   });
// }

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:pos_system/lib/main.dart'; // Update if your path is different
import 'package:pos_system/lib/core/services/auth_service.dart'; // Update if needed

// A minimal mock AuthService that mimics login behavior
class MockAuthService extends ChangeNotifier implements AuthService {
  @override
  User? _currentUser;

  @override
  User? get currentUser => _currentUser;

  @override
  Future<bool> login(String username, String password) async {
    _currentUser = User('testUser', 'Cashier');
    notifyListeners();
    return true;
  }

  @override
  void logout() {
    _currentUser = null;
    notifyListeners();
  }
}

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Wrap MyApp in ChangeNotifierProvider with mock AuthService
    await tester.pumpWidget(
      ChangeNotifierProvider<AuthService>(
        create: (_) => MockAuthService(),
        child: const MyApp(),
      ),
    );

    // Find '0' and '1' text to simulate counter test
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}

