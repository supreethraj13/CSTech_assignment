import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService_OTP{
  static Future<bool> sendOTP(String phone) async {
  final url = Uri.parse('http://devapiv4.dealsdray.com/api/v2/user/otp');

  try {
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({"mobileNumber": phone}),
    );

    if (response.statusCode == 200) {
      print("OTP Sent: ${response.body}");
      return true;
    } else {
      print("OTP Send Failed: ${response.statusCode}");
      print("Body: ${response.body}");
      return false;
    }
  } catch (e) {
    print("Error sending OTP: $e");
    return false;
  }
}

}
