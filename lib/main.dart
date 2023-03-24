import 'package:acme_corp_interview/presentation/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp(
    name: 'name',
    email: 'email',
    phone: 'phone',
  ));
}

class MyApp extends StatefulWidget {
  const MyApp(
      {super.key,
      required this.name,
      required this.email,
      required this.phone});

  final String name;
  final String email;
  final String phone;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(
        name: widget.name,
        email: widget.email,
        phone: widget.phone,
      ),
    );
  }
}
