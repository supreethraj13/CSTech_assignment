import 'package:flutter/material.dart';
import 'package:flutter_assignment_internship/screen/home_page.dart';
import 'package:flutter_assignment_internship/screen/login_screen.dart';
import 'package:flutter_assignment_internship/screen/otp_screen.dart';
import 'package:flutter_assignment_internship/screen/register_screen.dart';
import 'package:flutter_assignment_internship/screen/splash.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const numberscreen(),
        '/login/otp':(context)=> OTPVerificationScreen(),
        '/register':(context)=>RegisterScreen(),
        '/home':(context)=>HomeScreen(),
      }
    );
  }
}
