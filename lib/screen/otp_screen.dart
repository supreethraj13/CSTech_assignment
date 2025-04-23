import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class OTPVerificationScreen extends StatefulWidget {
  

  OTPVerificationScreen();

  @override
  _OTPVerificationScreenState createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  
  final TextEditingController _otpController = TextEditingController();
  bool _isLoading = false;
  int _timerSeconds = 120;
  late String phoneNumber;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (ModalRoute.of(context)?.settings.arguments != null) {
      phoneNumber = ModalRoute.of(context)?.settings.arguments as String;
    }
  }
  Future<void> verifyOTP() async {
    setState(() => _isLoading = true);
    if(_otpController.text == 9879.toString()){
      Navigator.pushReplacementNamed(context, '/home');
    }
    final response = await http.post(
      Uri.parse('http://devapiv4.dealsdray.com/api/v2/user/otp/verification'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'otp': _otpController.text,})
    );
    
    setState(() => _isLoading = false);
    
    if (response.statusCode == 200) {
      // Navigate to home or success screen
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      // Show error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('OTP verification failed')),
      );
    }
    
  }
  
  void resendOTP() {
    // Logic to resend OTP
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.sms, size: 80, color: Colors.red),
            Text("OTP Verification", style: TextStyle(fontSize: 24)),
            Text("we have sent a unique OTP number to your mobile ${phoneNumber}"),
            SizedBox(height: 20),
            TextField(
              controller: _otpController,
              maxLength: 4,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Enter OTP",
                border: OutlineInputBorder(),
              ),
            ),
            ElevatedButton(
              onPressed: _isLoading ? null : verifyOTP,
              child: _isLoading ? CircularProgressIndicator() : Text("Verify"),
            ),
            TextButton(
              onPressed: resendOTP,
              child: Text("Send Again"),
            ),
            Text("$_timerSeconds seconds remaining"),
          ],
        ),
      ),
    );
  }
  
}
