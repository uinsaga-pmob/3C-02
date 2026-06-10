import 'package:flutter/material.dart';
import 'login.dart';

final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.dark);

void main() {
  runApp(const TaskuyApp());
}

class TaskuyApp extends StatelessWidget {
  const TaskuyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (_, ThemeMode currentMode, __) {
        return MaterialApp(
          title: 'Taskuy',
          debugShowCheckedModeBanner: false,
          themeMode: currentMode,
          // Konfigurasi Tema Terang (Light Mode)
          theme: ThemeData(
            brightness: Brightness.light,
            primaryColor: const Color(0XFF015E67),
            scaffoldBackgroundColor: const Color(0XFFF5F5F7),
          ),
          // Konfigurasi Tema Gelap (Dark Mode)
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            primaryColor: const Color(0XFF015E67),
            scaffoldBackgroundColor: const Color(0XFF161618),
          ),
          home: const LoginPage(),
        );
      },
    );
  }
}