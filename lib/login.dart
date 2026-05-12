import 'package:flutter/material.dart';
import 'beranda.dart';
import 'reset.dart';
import 'sign_up.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      backgroundColor: const Color(0XFF161618),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 60),
            Image.asset('asset/images/Taskuy.jpeg', height: 180),
            const SizedBox(height: 30),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text("Log in", style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email', filled: true, fillColor: Color(0XFF1E1E1E), border: OutlineInputBorder()),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Kata sandi', filled: true, fillColor: Color(0XFF1E1E1E), border: OutlineInputBorder()),
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
              onPressed: () {
                // Langsung masuk ke Beranda
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Beranda()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0XFF015E67),
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text("Log In", style: TextStyle(color: Colors.white)),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Belum punya akun? ", style: TextStyle(color: Colors.white)),
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