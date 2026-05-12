import 'package:flutter/material.dart';
import 'login.dart';

void main() {
  runApp(const TaskuyApp());
}

class TaskuyApp extends StatelessWidget {
  const TaskuyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Taskuy',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0XFF015E67),
      ),
      home: const LoginPage(),
    );
  }
}