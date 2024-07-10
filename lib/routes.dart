import 'package:flutter/material.dart';
import 'package:shop_app/SplashLogo.dart';
import 'package:shop_app/screens/forgot_password/new_pass.dart';
import 'package:shop_app/screens/forgot_password/otp_screen.dart';
import 'package:shop_app/screens/products/products_screen.dart';
import 'package:shop_app/screens/profile/components/helpCenter.dart';
import 'package:shop_app/screens/profile/components/notification.dart';
import 'package:shop_app/screens/profile/components/setting.dart';


import 'screens/cart/cart_screen.dart';
import 'screens/complete_profile/complete_profile_screen.dart';
import 'screens/details/details_screen.dart';
import 'screens/forgot_password/forgot_password_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/init_screen.dart';
import 'screens/login_success/login_success_screen.dart';
import 'screens/otp/otp_screen.dart';
import 'screens/profile/profile_screen.dart';
import 'screens/sign_in/sign_in_screen.dart';
import 'screens/sign_up/sign_up_screen.dart';
import 'screens/splash/splash_screen.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  InitScreen.routeName: (context) => const InitScreen(),
  SplashScreen.routeName: (context) => const SplashScreen(),
  SignInScreen.routeName: (context) => const SignInScreen(),
  ForgotPasswordScreen.routeName: (context) => const ForgotPasswordScreen(),
  LoginSuccessScreen.routeName: (context) => const LoginSuccessScreen(),
  SignUpScreen.routeName: (context) => const SignUpScreen(),
  CompleteProfileScreen.routeName: (context) => const CompleteProfileScreen(),
  OtpScreen.routeName: (context) => const OtpScreen(),
  HomeScreen.routeName: (context) => const HomeScreen(),
  ProductsScreen.routeName: (context) => const ProductsScreen(),
  DetailsScreen.routeName: (context) => const DetailsScreen(),
  CartScreen.routeName: (context) => const CartScreen(),
  ProfileScreen.routeName: (context) => const ProfileScreen(),
  HelpCenter.routeName: (context) => const HelpCenter(),
  Setting.routeName: (context) => const Setting(),
  OtpScreenForget.routeName: (context) {
    // Extract the email argument from the ModalRoute settings
    final args = ModalRoute.of(context)!.settings.arguments as String;
    return OtpScreenForget(email: args); // Pass the email to the widget
  },
  NewPassForget.routeName: (context) => const NewPassForget(),
  LogoSplash.routeName:(context) => const LogoSplash(),
  NotificationPage.routeName:(context) => const NotificationPage(),
};
