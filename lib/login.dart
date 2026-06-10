import 'package:flutter/material.dart';
import 'beranda.dart';
import 'reset.dart';
import 'sign_up.dart';
import '../database/db_helper.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> _login() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Email dan Password wajib diisi")));
      return;
    }
    bool isSuccess = await DBHelper.instance.loginUser(_emailController.text, _passwordController.text);
    if (!mounted) return;
    if (isSuccess) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Beranda()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Email atau Password salah!"), backgroundColor: Colors.red));
    }
  }

  @override
  void dispose() {
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 60),
            Image.asset('asset/images/Taskuy.jpeg', height: 180),
            const SizedBox(height: 30),
            Align(
              alignment: Alignment.centerLeft,
              child: Text("Log in", style: TextStyle(color: textColor, fontSize: 32, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _emailController,
              style: TextStyle(color: textColor),
              decoration: InputDecoration(labelText: 'Email', filled: true, fillColor: cardColor, border: const OutlineInputBorder()),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              obscureText: true,
              style: TextStyle(color: textColor),
              decoration: InputDecoration(labelText: 'Kata sandi', filled: true, fillColor: cardColor, border: const OutlineInputBorder()),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ResetPasswordPage())),
                child: const Text("Lupa kata sandi?", style: TextStyle(color: Color(0XFF018592))),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0XFF015E67), minimumSize: const Size(double.infinity, 50)),
              child: const Text("Log In", style: TextStyle(color: Colors.white)),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Belum punya akun? ", style: TextStyle(color: textColor)),
                GestureDetector(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SignUpPage())),
                  child: const Text("Sign up", style: TextStyle(color: Color(0XFF018592), fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}