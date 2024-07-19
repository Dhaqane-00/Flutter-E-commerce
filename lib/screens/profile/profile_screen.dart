import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/provider/loginProvider.dart';
import 'package:shop_app/screens/cart/components/OrdersScreen.dart';
import 'package:shop_app/screens/cart/components/PaymentSuccessScreen.dart';
import 'package:shop_app/screens/complete_profile/complete_profile_screen.dart';
import 'package:shop_app/screens/profile/components/helpCenter.dart';
import 'package:shop_app/screens/profile/components/notification.dart';
import 'package:shop_app/screens/profile/components/setting.dart';
import 'package:shop_app/screens/sign_in/sign_in_screen.dart';

import 'components/profile_menu.dart';
import 'components/profile_pic.dart';

class ProfileScreen extends StatelessWidget {
  static String routeName = "/profile";

  const ProfileScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    // Retrieve user information from the UserProvider
    String? userName = Provider.of<UserProvider>(context).userName;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile",style: TextStyle(fontSize: 20),),
        centerTitle: true,
        leading: Container(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            const ProfilePic(),
            const SizedBox(height: 10,),
            Text(
              "$userName", // Display user's name
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ProfileMenu(
              text: "My Account",
              icon: "assets/icons/User Icon.svg",
              press: () => {
                Navigator.pushNamed(context, CompleteProfileScreen.routeName),
              },
            ),
            ProfileMenu(
              text: "My Orders",
              icon: "assets/icons/Cart Icon.svg",
              press: () => {
                Navigator.pushNamed(context, OrdersScreen.routeName),
              },
            ),

            ProfileMenu(
              text: "Notifications",
              icon: "assets/icons/Bell.svg",
              press: () {
                Navigator.pushNamed(context, NotificationPage.routeName);
              },
            ),
            ProfileMenu(
              text: "Settings",
              icon: "assets/icons/Settings.svg",
              press: () {
                Navigator.pushNamed(context, Setting.routeName);
              },
            ),
            ProfileMenu(
              text: "Help Center",
              icon: "assets/icons/Question mark.svg",
              press: () {
                Navigator.pushNamed(context, HelpCenter.routeName);
              },
            ),
            ProfileMenu(
              text: "Log Out",
              icon: "assets/icons/Log out.svg",
              press: () {
                Provider.of<UserProvider>(context, listen: false).logout();
                Navigator.pushReplacementNamed(context, SignInScreen.routeName);
              },
            ),
          ],
        ),
      ),
    );
  }
}
