import 'package:app_taxis/views/home_page.dart';
import 'package:app_taxis/views/login_page.dart';
import 'package:app_taxis/views/splash_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Material App",
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const SplashPage(),
        '/home': (context) => const HomePage(),
        '/login': (_) => const LoginPage(),
      },
    );
  }
}
