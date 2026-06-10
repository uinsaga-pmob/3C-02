import 'package:flutter/material.dart';
import '../database/db_helper.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _namaController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> _register() async {
    if (_namaController.text.isEmpty || _emailController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Semua field wajib diisi")));
      return;
    }
    await DBHelper.instance.registerUser(_namaController.text, _emailController.text, _passwordController.text);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Pendaftaran berhasil! Silakan Login."), backgroundColor: Colors.green));
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _namaController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // --- ADAPTIF WARNA TEMA ---
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black87;
    final cardColor = isDark ? const Color(0XFF1E1E1E) : Colors.white;

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0, iconTheme: IconThemeData(color: textColor)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text("Create Account", style: TextStyle(color: textColor, fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 30),
            TextField(
              controller: _namaController,
              style: TextStyle(color: textColor),
              decoration: InputDecoration(labelText: "Nama Lengkap", filled: true, fillColor: cardColor, border: const OutlineInputBorder()),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _emailController,
              style: TextStyle(color: textColor),
              decoration: InputDecoration(labelText: "Email", filled: true, fillColor: cardColor, border: const OutlineInputBorder()),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _passwordController,
              obscureText: true,
              style: TextStyle(color: textColor),
              decoration: InputDecoration(labelText: "Password", filled: true, fillColor: cardColor, border: const OutlineInputBorder()),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _register,
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0XFF015E67), minimumSize: const Size(double.infinity, 50)),
              child: const Text("Daftar", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}