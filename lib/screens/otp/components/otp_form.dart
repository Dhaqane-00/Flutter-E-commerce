import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop_app/screens/home/home_screen.dart';
import 'package:shop_app/screens/init_screen.dart';
import 'package:shop_app/server/UserSignup.dart';

import '../../../constants.dart';

class OtpForm extends StatefulWidget {
  const OtpForm({Key? key}) : super(key: key);

  @override
  _OtpFormState createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  final TextEditingController _pin1Controller = TextEditingController();
  final TextEditingController _pin2Controller = TextEditingController();
  final TextEditingController _pin3Controller = TextEditingController();
  final TextEditingController _pin4Controller = TextEditingController();

  @override
  void dispose() {
    _pin1Controller.dispose();
    _pin2Controller.dispose();
    _pin3Controller.dispose();
    _pin4Controller.dispose();
    super.dispose();
  }

  void nextField(String value, TextEditingController controller) {
    if (value.length == 1) {
      controller.text = '';
      FocusScope.of(context).requestFocus(FocusNode());
    }
  }
    Future<void> _verifyOTP() async {
    String otp = _pin1Controller.text +
                 _pin2Controller.text +
                 _pin3Controller.text +
                 _pin4Controller.text;

    var result = await OTP.otpVerification(otp);

    if (result['status'] == 'success') {
      // OTP verification successful
      // Add your navigation logic or any other actions here
      Navigator.pushNamed(context, InitScreen.routeName);
    } else {
      // OTP verification failed
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${result['message']}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 60,
                child: TextFormField(
                  controller: _pin1Controller,
                  autofocus: true,
                  obscureText: true,
                  style: const TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(1),
                  ],
                  onChanged: (value) {
                    nextField(value, _pin2Controller);
                  },
                ),
              ),
              SizedBox(
                width: 60,
                child: TextFormField(
                  controller: _pin2Controller,
                  obscureText: true,
                  style: const TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(1),
                  ],
                  onChanged: (value) => nextField(value, _pin3Controller),
                ),
              ),
              SizedBox(
                width: 60,
                child: TextFormField(
                  controller: _pin3Controller,
                  obscureText: true,
                  style: const TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(1),
                  ],
                  onChanged: (value) => nextField(value, _pin4Controller),
                ),
              ),
              SizedBox(
                width: 60,
                child: TextFormField(
                  controller: _pin4Controller,
                  obscureText: true,
                  style: const TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(1),
                  ],
                  onChanged: (value) {},
                ),
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          ElevatedButton(
            onPressed: _verifyOTP,
            child: const Text("Continue"),
          ),
        ],
      ),
    );
  }
}
