import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/provider/loginProvider.dart';
import 'package:shop_app/screens/init_screen.dart';
import 'package:shop_app/screens/splash/splash_screen.dart';

class LogoSplash extends StatelessWidget {
  static const String routeName = "/LogoSplash"; 
  const LogoSplash({super.key});

  Future<Widget> _loadNextScreen(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    await Future.delayed(
        Duration(seconds: 2)); // Simulate a delay for the splash screen
    return userProvider.isLoggedIn ? InitScreen() : SplashScreen();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Widget>(
      future: _loadNextScreen(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return AnimatedSplashScreen(
            splash: Column(
              children: [
                Center(
                  child: LottieBuilder.asset(
                    "assets/lotties/splash_screen.json",
                    width: MediaQuery.of(context).size.width *
                        0.8,
                    height: MediaQuery.of(context).size.height * 0.4,
                  ),
                ),
              ],
            ),
            nextScreen:
                Container(), // This will be replaced once the Future completes
            splashIconSize: 400,
            backgroundColor: Colors.white,
          );
        } else {
          return snapshot.data!;
        }
      },
    );
  }
}
