import 'package:flutter/material.dart';
import 'package:shop_app/screens/forgot_password/components/new_pass_form.dart';

class NewPassForget extends StatelessWidget {
  static String routeName = "/New_Pass_Forget";

  const NewPassForget({super.key});

  @override
  Widget build(BuildContext context) {
    final String email = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Forget Password"),
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  const Text(
                    "Reset Your Password",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    "Enter New Password",
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  NewPasswordForm(email: email), // Pass the email to the form
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
