import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'splash.dart';
import 'login.dart';
import 'register.dart';
import 'home.dart';
import 'list_info.dart';
import 'about.dart';

const apiKey = 'AIzaSyAnHKAGH276G_-RByNpUip1ISd9fUXHyA0'; 

void main() {
  
  Gemini.init(apiKey: apiKey, enableDebugging: true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins', 
        primaryColor: const Color(0xFFB3D8FF),
        scaffoldBackgroundColor: const Color(0xFFEAF4FF),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFB3D8FF),
          foregroundColor: Colors.black,
          elevation: 0,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFB3D8FF),
            foregroundColor: Colors.black,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(14)),
            ),
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(14)),
            borderSide: BorderSide(color: Color(0xFFB3D8FF)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(14)),
            borderSide: BorderSide(color: Color(0xFF72B4FF), width: 2),
          ),
        ),
      ),

      
      routes: {
        "/": (_) => const SplashScreen(),
        "/login": (_) => const LoginPage(),
        "/register": (_) => const RegisterPage(),
        "/home": (_) => const HomePage(),
        "/list": (_) => const ListInfoPage(),
        "/about": (_) => const AboutPage(),
      },
    );
  }
}
