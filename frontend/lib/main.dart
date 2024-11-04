import 'package:flutter/material.dart';
import 'package:frontend/pages/main_screen.dart';
import 'package:frontend/pages/sign_in.dart';
import 'package:frontend/pages/sign_up.dart';
import 'package:frontend/pages/splash.dart';
import 'package:frontend/pages/user_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Butex',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      // https://docs.flutter.dev/cookbook/navigation/named-routes
      routes: {
        '/': (context) => SplashPage(),
        '/signin': (context) => SignIn(),
        '/signup': (context) => SignUp(),
        '/main': (context) => MainScreen(),
        '/user_page': (context) => UserPage(),
      },
    );
  }
}
