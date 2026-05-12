import 'package:flutter/material.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF161618),
      appBar: AppBar(title: const Text("Reset Password"), backgroundColor: Colors.transparent),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const TextField(decoration: InputDecoration(labelText: "Masukkan Email", filled: true, fillColor: Color(0XFF1E1E1E), border: OutlineInputBorder())),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0XFF015E67), minimumSize: const Size(double.infinity, 50)),
              child: const Text("Kirim Link Reset", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}