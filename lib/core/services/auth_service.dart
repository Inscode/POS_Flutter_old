import 'package:flutter/material.dart';

// User model to store the logged-in user's details
class User {
  final String username;
  final String role;
  User(this.username, this.role);
}

class AuthService with ChangeNotifier {
  User? _currentUser;

  User? get currentUser => _currentUser;

  // Hardcoded user credentials
  final Map<String, Map<String, String>> _users = {
    'cashier': {'password': 'cash123', 'role': 'Cashier'},
    'stock': {'password': 'stock123', 'role': 'StockKeeper'},
    'manager': {'password': 'manager123', 'role': 'Manager'},
    'admin': {'password': 'admin123', 'role': 'Admin'},
  };

  // Login method that checks credentials
  Future<bool> login(String username, String password) async {
    final user = _users[username];

    // Check if the username exists and the password matches
    if (user != null && user['password'] == password) {
      _currentUser = User(username, user['role']!);
      notifyListeners();
      return true;
    }
    return false;
  }

  // Logout method to clear the user data
  void logout() {
    _currentUser = null;
    notifyListeners();
  }
}
