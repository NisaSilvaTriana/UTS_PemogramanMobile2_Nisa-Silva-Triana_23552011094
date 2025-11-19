import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Login",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                ),
              ),
              const SizedBox(height: 30),

              TextField(
                decoration: InputDecoration(
                  labelText: "Email",
                  labelStyle: const TextStyle(fontFamily: 'Poppins'),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(color: Color(0xFFB3D8FF)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(color: Color(0xFF72B4FF), width: 2),
                  ),
                ),
              ),
              const SizedBox(height: 15),

              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Password",
                  labelStyle: const TextStyle(fontFamily: 'Poppins'),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(color: Color(0xFFB3D8FF)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(color: Color(0xFF72B4FF), width: 2),
                  ),
                ),
              ),
              const SizedBox(height: 25),

              ElevatedButton(
                onPressed: () => Navigator.pushReplacementNamed(context, "/home"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFB3D8FF),
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  "Login",
                  style: TextStyle(fontFamily: 'Poppins', fontSize: 16),
                ),
              ),

              TextButton(
                onPressed: () => Navigator.pushNamed(context, "/register"),
                child: const Text(
                  "Belum punya akun? Register",
                  style: TextStyle(fontFamily: 'Poppins'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
