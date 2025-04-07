import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:mobile_leckortung/features/auth/screens/login_screen.dart';

import 'core/navigation/routes.dart';
import 'core/theme/forui.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp.router(
      title: 'Meine Flutter App',
      debugShowCheckedModeBanner: false,
      // Hier den Router übergeben
      routerConfig: AppRouter.instance.router, // Dein GoRouter-Objekt
      builder: (context, child) =>  FTheme(
        data: FThemes.zinc.light,
        child: child!,
      ),
    );


  }
}
