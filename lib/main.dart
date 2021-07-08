import 'package:flutter/material.dart';
import './view/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Mersin Üniversitesi",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "CustomFont",
        primarySwatch: Colors.blueGrey,
      ),
      home: const LoginPage(),
    );
  }
}
