import 'package:flutter/material.dart';
import 'package:flutter_assignment_internship/provider/deviceprovider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    _initApp();
  }


  Future<void> _initApp() async {
    super.initState();
    await ApiService.sendDeviceInfo();
    await Future.delayed(Duration(seconds: 2));
    Navigator.pushReplacementNamed(context, '/login'); 
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 20,),
            Text("DealsDray", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
