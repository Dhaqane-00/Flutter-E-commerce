import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/components/custom_surfix_icon.dart';
import 'package:shop_app/components/form_error.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/provider/loginProvider.dart';
import 'package:shop_app/screens/profile/profile_screen.dart';

class CompleteProfileForm extends StatefulWidget {
  const CompleteProfileForm({Key? key}) : super(key: key);

  @override
  _CompleteProfileFormState createState() => _CompleteProfileFormState();
}

class _CompleteProfileFormState extends State<CompleteProfileForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String?> errors = [];
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Fetch user data from provider
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      if (userProvider.isLoggedIn) {
        setState(() {
          fullNameController.text = userProvider.user.name ?? '';
          emailController.text = userProvider.user.email ?? '';
          addressController.text = userProvider.user.address ?? '';
        });
      }
    });
  }

  void addError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        return Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: fullNameController,
                onSaved: (newValue) => fullNameController.text = newValue ?? '',
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    removeError(error: kNamelNullError);
                  }
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    addError(error: kNamelNullError);
                    return "";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: "Full Name",
                  hintText: "Enter your full name",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: emailController,
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: "Email",
                  hintText: "Enter your email",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: addressController,
                onSaved: (newValue) => addressController.text = newValue ?? '',
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    removeError(error: kAddressNullError);
                  }
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    addError(error: kAddressNullError);
                    return "";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: "Address",
                  hintText: "Enter your address",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Location point.svg"),
                ),
              ),
              FormError(errors: errors),
              const SizedBox(height: 20),
              userProvider.updateState == LoginState.loading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          // Update user data in provider
                          userProvider
                              .updateUser(
                                name: fullNameController.text,
                                address: addressController.text,
                              )
                              .then((_) {
                                // Show success snackbar
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Profile updated successfully!"),
                                    backgroundColor: Colors.green,
                                  ),
                                );
                              })
                              .catchError((e) {
                                print(e);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Error updating profile: $e"),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              });
                        }
                      },
                      child: const Text("Update"),
                    ),
            ],
          ),
        );
      },
    );
  }
}
