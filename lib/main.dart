import 'package:batch16/signup/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'gen/assets.gen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHome(),
      );
  }
}

