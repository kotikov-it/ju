import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_leckortung/features/home/screens/home_screen.dart';

import '../../features/auth/screens/login_screen.dart';
import '../../features/licence/screens/license_request_screen.dart';
import '../../features/licence/screens/license_screen.dart';
import '../../features/order/screens/simplified_creation_order_screen.dart';
import '../../features/registration/screens/registration_screen.dart';

@immutable
class AppRoutes {
  const AppRoutes._(); // Private constructor to prevent instantiation

  static const String login = '/login';
  static const String registration = '/register';
  static const String licenseKey = '/license-key';
  static const String licenseRequest = '/license-request';
  static const String createOrder = '/create-order';
  static const String home = '/'; // Beispiel für eine Startseite nach Login
}

class AppRouter {
  // Singleton pattern für einfachen Zugriff (optional)
  AppRouter._();

  static final AppRouter instance = AppRouter._();

  // Navigator key
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static Future<void> navigateToRouteAfterDelay(BuildContext context, String targetRoute) async {
    // Warte 3 Sekunden
    await Future.delayed(const Duration(seconds: 3));

    // WICHTIG: Prüfe, ob das Widget noch "mounted" ist, bevor du context
    // in einem asynchronen Gap verwendest. Sonst könnte es zu Fehlern kommen,
    // wenn der Benutzer in der Zwischenzeit wegnavigiert hat.
    if (context.mounted) {
      // Navigiere zur Zielroute und ersetze den aktuellen Navigationsstack
      context.go(targetRoute);
      // Alternativ: context.push(targetRoute); // Fügt die Route zum Stack hinzu
    } else {
      // Optional: Logge, dass die Navigation abgebrochen wurde, da das Widget nicht mehr mounted war.
      debugPrint("Navigation zu '$targetRoute' abgebrochen: Widget nicht mehr mounted.");
    }
  }

  late final GoRouter router = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: AppRoutes.home, // Startroute
    routes: <RouteBase>[
      GoRoute(
        path: AppRoutes.login,
        builder: (BuildContext context, GoRouterState state) {
          return LoginScreen();
        },
      ),

      GoRoute(
        path: AppRoutes.registration,
        builder: (BuildContext context, GoRouterState state) {
          return RegistrationScreen();
        },
      ),

      GoRoute(
        path: AppRoutes.licenseKey,
        builder: (BuildContext context, GoRouterState state) {
          return LicenseKeyScreen();
        },
      ),

      GoRoute(
        path: AppRoutes.licenseRequest,
        builder: (BuildContext context, GoRouterState state) {
          return LicenseRequestScreen();
        },
      ),
      GoRoute(
        path: AppRoutes.home,
        builder: (BuildContext context, GoRouterState state) {
          return HomeScreen();
        },
      ),
      GoRoute(
        path: AppRoutes.createOrder,
        builder: (BuildContext context, GoRouterState state) {
          return SimplifiedOrderCreationScreen();
        },
      ),
      // Beispiel für eine Home-Route nach erfolgreichem Login/Lizenz
      // GoRoute(
      //   path: AppRoutes.home,
      //   builder: (BuildContext context, GoRouterState state) {
      //     // return const HomeScreen();
      //     return Scaffold(appBar: AppBar(title: const Text('Home')), body: const Center(child: Text('Willkommen!')));
      //   },
      // ),
    ],
    // Optional: Fehlerseite
    errorBuilder: (context, state) => FScaffold(
      header: AppBar(title: const Text('Fehler')),
      content: Center(child: Text('Route nicht gefunden: ${state.error}')),
    ),
  );
}
