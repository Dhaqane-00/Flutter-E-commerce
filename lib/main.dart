// main.dart

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shop_app/firebase_options.dart';
import 'package:shop_app/provider/loginProvider.dart';
import 'package:shop_app/screens/init_screen.dart';
import 'package:shop_app/screens/splash/splash_screen.dart';
import 'package:shop_app/screens/sign_in/sign_in_screen.dart';
import 'package:shop_app/screens/home/home_screen.dart';
import 'routes.dart';
import 'theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: Consumer<UserProvider>(
        builder: (context, userProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'The Flutter Way - Template',
            theme: AppTheme.lightTheme(context),
            initialRoute: userProvider.isLoggedIn
                ? InitScreen.routeName
                : SplashScreen.routeName,
            routes: routes,
          );
        },
      ),
    );
  }
}
