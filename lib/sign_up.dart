import 'package:flutter/material.dart';
import 'login.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF161618),
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Text("Create Account", style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 30),
            const TextField(decoration: InputDecoration(labelText: "Nama Lengkap", filled: true, fillColor: Color(0XFF1E1E1E), border: OutlineInputBorder())),
            const SizedBox(height: 15),
            const TextField(decoration: InputDecoration(labelText: "Email", filled: true, fillColor: Color(0XFF1E1E1E), border: OutlineInputBorder())),
            const SizedBox(height: 15),
            const TextField(obscureText: true, decoration: InputDecoration(labelText: "Password", filled: true, fillColor: Color(0XFF1E1E1E), border: OutlineInputBorder())),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => Navigator.pop(context), // Kembali ke Login
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0XFF015E67), minimumSize: const Size(double.infinity, 50)),
              child: const Text("Daftar", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}