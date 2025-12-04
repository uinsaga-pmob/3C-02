import 'package:flutter/material.dart';
import 'beranda.dart';
import 'reset.dart';
import 'sign_up.dart';
import 'auth_local_service.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  void _login(BuildContext context, String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Email dan password harus diisi!")),
      );
      return;
    }

    // Cek login pakai local storage
    final success = await AuthLocalService.login(email, password);

    if (success) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Beranda()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Email atau password salah!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      backgroundColor: Color(0XFF161618),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            Image.asset('asset/images/Taskuy.jpeg', height: 200, width: 200),
            SizedBox(height: 50),

            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Log in",
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Poppins',
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 20),

            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: 'Email',
                filled: true,
                fillColor: Color(0XFF1E1E1E),
                labelStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),

            TextField(
              controller: passwordController,
              obscureText: true,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: 'Kata sandi',
                filled: true,
                fillColor: Color(0XFF1E1E1E),
                labelStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 15),

            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ResetPasswordPage(),
                  ),
                );
              },

              child: const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Lupa kata sandi?",
                  style: TextStyle(
                    color: Color(0XFF018592),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
            SizedBox(height: 60),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0XFF015E67),
                foregroundColor: Colors.white,
                minimumSize: Size(500, 54),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              onPressed: () {
                _login(
                  context,
                  emailController.text.trim(),
                  passwordController.text.trim(),
                );
              },
              child: const Text(
                "Log In",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),

            SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  "Belum punya akun? ",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignUpPage(),
                      ),
                    );
                  },

                  child: const Text(
                    "Sign up",
                    style: TextStyle(
                      color: Color(0XFF018592),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
