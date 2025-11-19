import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

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
                "Register",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins', 
                ),
              ),
              const SizedBox(height: 30),

              TextField(
                decoration: const InputDecoration(
                  labelText: "Nama",
                  labelStyle: TextStyle(fontFamily: 'Poppins'),
                ),
              ),
              const SizedBox(height: 15),

              TextField(
                decoration: const InputDecoration(
                  labelText: "Email",
                  labelStyle: TextStyle(fontFamily: 'Poppins'),
                ),
              ),
              const SizedBox(height: 15),

              TextField(
                decoration: const InputDecoration(
                  labelText: "Password",
                  labelStyle: TextStyle(fontFamily: 'Poppins'),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 25),

              ElevatedButton(
                onPressed: () => Navigator.pushReplacementNamed(context, "/login"),
                child: const Text(
                  "Daftar",
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
