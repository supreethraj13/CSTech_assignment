import 'package:flutter/material.dart';
import 'package:flutter_assignment_internship/model/api_sevice.dart';
class numberscreen extends StatefulWidget {
  const numberscreen({super.key});

  @override
  State<numberscreen> createState() => _numberScreenState();
}

class _numberScreenState extends State<numberscreen> {
  bool isPhoneSelected =true;
  final numbercontroller = TextEditingController();
  bool _isLoading = false;

  void _sendOTP() async {
    String phone = numbercontroller.text.trim();

    if (phone.isEmpty || phone.length != 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Enter a valid 10-digit phone number')),
      );
      return;
    }

    setState(() => _isLoading = true);

    bool success = await ApiService_OTP.sendOTP(phone);

    setState(() => _isLoading = false);

    if (success) {
      Navigator.pushReplacementNamed(context, '/login/otp',arguments: phone); 
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to send OTP')),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                  const Text(
                  "DealsDray", 
                  style: TextStyle(
                    fontSize: 30, 
                    fontWeight: FontWeight.bold
                  )
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildToggleButton("Phone", isPhoneSelected),
                    SizedBox(width: 12,),
                    _buildToggleButton("Email", !isPhoneSelected),
                  ],
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                  Column(
                    children: [
                      const Text(
                      'Glad to see you!',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    const Text(
                      'Please provide your phone number',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w100
                      ),
                    ),
                  ],
                ), 
              ],
            ),
            SizedBox(height: 8,),
            TextField(
              controller: numbercontroller,
              decoration: InputDecoration(
                hintText: 'Phone'
              ),
            ),
            SizedBox(height: 8,),
            ElevatedButton(
              onPressed: _sendOTP,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                minimumSize: Size(double.infinity, 50),
              ),
              child: Text('SEND CODE'),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildToggleButton(String label,bool selected){
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor:selected?Colors.redAccent:Colors.grey,
        shape: StadiumBorder(),
      ),
      onPressed: (){
      setState(() {
        isPhoneSelected = label == "Phone";
      });
    }, child: Text(label)
    );
  }
}


