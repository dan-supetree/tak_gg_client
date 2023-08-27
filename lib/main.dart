import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:tak_gg/screens/splash_screen.dart';

Future<void> main() async {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'TakGG',
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
              iconTheme: IconThemeData(color: Colors.black),
              color: Colors.white,
              elevation: 0,
              toolbarHeight: 56),
          scaffoldBackgroundColor: const Color(0xffffffff)),
      home: const SplashScreen(),
    );
  }
}
