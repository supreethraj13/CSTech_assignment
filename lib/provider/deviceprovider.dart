import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<void> sendDeviceInfo() async {
    final url = Uri.parse('http://devapiv4.dealsdray.com/api/v2/user/device/add');

    final body = jsonEncode({
      "device_token": "dummy_device_token",
      "device_type": "android"
    });

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: body,
      );

      if (response.statusCode == 200) {
        print("Device Info Sent: ${response.body}");
      } else {
        print("Failed to send device info: ${response.statusCode}");
      }
    } catch (e) {
      print("Error in device info API: $e");
    }
  }
}