import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop_app/screens/forgot_password/new_pass.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/server/UserLogin.dart';

class OtpForgetForm extends StatefulWidget {
  final String email; // Declare email variable

  const OtpForgetForm({Key? key, required this.email}) : super(key: key);

  @override
  _OtpFormState createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForgetForm> {
  final TextEditingController _pin1Controller = TextEditingController();
  final TextEditingController _pin2Controller = TextEditingController();
  final TextEditingController _pin3Controller = TextEditingController();
  final TextEditingController _pin4Controller = TextEditingController();

  final FocusNode _pin1FocusNode = FocusNode();
  final FocusNode _pin2FocusNode = FocusNode();
  final FocusNode _pin3FocusNode = FocusNode();
  final FocusNode _pin4FocusNode = FocusNode();

  bool _isLoading = false;
  final _userService = UserServices();

  @override
  void dispose() {
    _pin1Controller.dispose();
    _pin2Controller.dispose();
    _pin3Controller.dispose();
    _pin4Controller.dispose();
    _pin1FocusNode.dispose();
    _pin2FocusNode.dispose();
    _pin3FocusNode.dispose();
    _pin4FocusNode.dispose();
    super.dispose();
  }

  void nextField(String value, FocusNode focusNode) {
    if (value.length == 1) {
      focusNode.requestFocus();
    }
  }

  Future<void> _verifyOtp() async {
    String otp = _pin1Controller.text +
        _pin2Controller.text +
        _pin3Controller.text +
        _pin4Controller.text;

    setState(() {
      _isLoading = true;
    });

    try {
      await _userService.ForgetVerifyOtp(email: widget.email, otp: otp);
      Navigator.pushNamed(context, NewPassForget.routeName,arguments: widget.email, );
      
    } catch (error) {
      // Handle error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error.toString())),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
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
                  focusNode: _pin1FocusNode,
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
                    nextField(value, _pin2FocusNode);
                  },
                ),
              ),
              SizedBox(
                width: 60,
                child: TextFormField(
                  controller: _pin2Controller,
                  focusNode: _pin2FocusNode,
                  obscureText: true,
                  style: const TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(1),
                  ],
                  onChanged: (value) => nextField(value, _pin3FocusNode),
                ),
              ),
              SizedBox(
                width: 60,
                child: TextFormField(
                  controller: _pin3Controller,
                  focusNode: _pin3FocusNode,
                  obscureText: true,
                  style: const TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(1),
                  ],
                  onChanged: (value) => nextField(value, _pin4FocusNode),
                ),
              ),
              SizedBox(
                width: 60,
                child: TextFormField(
                  controller: _pin4Controller,
                  focusNode: _pin4FocusNode,
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
                    if (value.length == 1) {
                      _pin4FocusNode.unfocus();
                    }
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          ElevatedButton(
            onPressed: _isLoading ? null : _verifyOtp,
            child: _isLoading
                ? CircularProgressIndicator() // Show loading indicator if _isLoading is true
                : const Text("Continue"),
          ),
        ],
      ),
    );
  }
}
