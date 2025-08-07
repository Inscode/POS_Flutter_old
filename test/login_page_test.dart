import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:pos_system/core/services/auth_service.dart';
import 'package:pos_system/features/auth/login_page.dart';

class FakeAuthService extends ChangeNotifier implements AuthService {
  bool shouldLoginSucceed = false;

  @override
  Future<bool> login(String username, String password) async {
    return shouldLoginSucceed;
  }

  @override
  void logout() {}

  @override
  // Just mock this however your AuthService defines it
  var currentUser;
}

void main() {
  testWidgets('Login page shows error on failed login', (
    WidgetTester tester,
  ) async {
    final fakeAuth = FakeAuthService();

    await tester.pumpWidget(
      ChangeNotifierProvider<AuthService>.value(
        value: fakeAuth,
        child: MaterialApp(home: const LoginPage(role: 'Cashier')),
      ),
    );

    // Enter username and password
    await tester.enterText(find.byType(TextField).at(0), 'user');
    await tester.enterText(find.byType(TextField).at(1), 'wrongpass');

    // Tap login
    await tester.tap(find.text('Login'));
    await tester.pump(); // wait for setState

    // Should show error (since shouldLoginSucceed = false)
    expect(find.text('Invalid username or password'), findsOneWidget);
  });
}
