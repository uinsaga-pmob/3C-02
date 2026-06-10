import 'package:flutter/material.dart';
import '../database/db_helper.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _emailController = TextEditingController();
  final _newPasswordController = TextEditingController();

  Future<void> _reset() async {
    if (_emailController.text.isEmpty || _newPasswordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Email dan Kata Sandi Baru wajib diisi")));
      return;
    }
    bool isSuccess = await DBHelper.instance.resetPassword(_emailController.text, _newPasswordController.text);
    if (!mounted) return;
    if (isSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Kata sandi berhasil diubah! Silakan login kembali."), backgroundColor: Colors.green));
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Email tidak terdaftar!"), backgroundColor: Colors.red));
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _newPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // --- ADAPTIF WARNA TEMA ---
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black87;
    final subTextColor = isDark ? Colors.white70 : Colors.black54;
    final cardColor = isDark ? const Color(0XFF1E1E1E) : Colors.white;

    return Scaffold(
      appBar: AppBar(
        title: Text("Reset Password", style: TextStyle(color: textColor)), 
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: textColor),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text("Masukkan email akun Anda dan kata sandi baru untuk mereset.", style: TextStyle(color: subTextColor, fontSize: 16)),
            const SizedBox(height: 30),
            TextField(
              controller: _emailController,
              style: TextStyle(color: textColor),
              decoration: InputDecoration(labelText: "Email Terdaftar", filled: true, fillColor: cardColor, border: const OutlineInputBorder()),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _newPasswordController,
              obscureText: true,
              style: TextStyle(color: textColor),
              decoration: InputDecoration(labelText: "Kata Sandi Baru", filled: true, fillColor: cardColor, border: const OutlineInputBorder()),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _reset,
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0XFF015E67), minimumSize: const Size(double.infinity, 50)),
              child: const Text("Reset Kata Sandi", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}