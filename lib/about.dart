import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Tentang Aplikasi",
          style: TextStyle(fontFamily: 'Poppins'), 
        ),
        backgroundColor: const Color(0xFFB3D8FF), 
      ),
      body: const Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),

            Text(
              "Aplikasi ini dibuat untuk memenuhi Ujian Tengah Semester Ganjil.\n"
              "Mata Kuliah Pemograman Mobile 2.\n"
              "Mengambil tema Gemini.",
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 18,
                height: 1.4,
              ),
            ),

            SizedBox(height: 32),

            Text(
              "© 2025 | Copyright by Nisa Silva Triana_23552011094",
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
