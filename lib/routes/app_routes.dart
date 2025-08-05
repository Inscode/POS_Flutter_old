import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/services/auth_service.dart';
import '../features/home/pos_home.dart';
import '../features/auth/login_page.dart';
import '../features/stockkeeper/stockkeeper_dashboard.dart';
import '../features/cashier/cashier_dashboard.dart';
// import '../features/admin/admin_dashboard.dart';

class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings, BuildContext context) {
    final auth = Provider.of<AuthService>(context, listen: false);
    final user = auth.currentUser;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const POSHomePage());
      case '/login':
        return MaterialPageRoute(builder: (_) => const LoginPage(role: 'StockKeeper'));
      case '/stockkeeper':
        if (user != null && user.role == 'StockKeeper') {
          return MaterialPageRoute(builder: (_) => const StockkeeperDashboard());
        }
        break;
      case '/cashier':
        if (user != null && user.role == 'Cashier') {
          return MaterialPageRoute(builder: (_) => const CashierDashboard());
        }
        break;
      // 
      
    }

    return MaterialPageRoute(builder: (_) => const POSHomePage());
  }
}
