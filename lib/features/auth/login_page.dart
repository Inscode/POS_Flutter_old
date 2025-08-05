import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/services/auth_service.dart';

class LoginPage extends StatefulWidget {
  final String role; // The role passed from POSHomePage

  const LoginPage({super.key, required this.role});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _error;

  // Submit login credentials
  void _submitLogin() async {
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();
    final auth = Provider.of<AuthService>(context, listen: false);

    bool success = await auth.login(username, password);

    if (success) {
      final loggedInRole = auth.currentUser!.role;

      // Only allow login if the role matches
      if (loggedInRole != widget.role) {
        setState(() => _error = "You are not authorized for this role.");
        auth.logout();
        return;
      }

      // Navigate to the correct dashboard
      switch (loggedInRole) {
        case 'StockKeeper':
          Navigator.pushReplacementNamed(context, '/stockkeeper');
          break;
        case 'Cashier':
          Navigator.pushReplacementNamed(context, '/cashier');
          break;
        case 'Admin':
          Navigator.pushReplacementNamed(context, '/admin');
          break;
        case 'Manager':
          Navigator.pushReplacementNamed(context, '/manager');
          break;
      }
    } else {
      setState(() => _error = 'Invalid username or password');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 600;

    return Scaffold(
      backgroundColor: const Color(0xFF0D1B2A),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            constraints: BoxConstraints(maxWidth: isWide ? 400 : double.infinity),
            padding: const EdgeInsets.all(32),
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              elevation: 10,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${widget.role} Login',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        labelText: 'Username',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      textInputAction: TextInputAction.done,
                      onSubmitted: (_) => _submitLogin(),
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    if (_error != null) ...[
                      const SizedBox(height: 8),
                      Text(_error!, style: const TextStyle(color: Colors.red)),
                    ],
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _submitLogin,
                        child: const Text('Login'),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Back to Role Selection'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
