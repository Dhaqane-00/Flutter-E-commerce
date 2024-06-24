import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shop_app/SplashLogo.dart';
import 'package:shop_app/firebase_options.dart';
import 'package:shop_app/provider/CartProvider.dart';
import 'package:shop_app/provider/ProductProvider.dart';
import 'package:shop_app/provider/loginProvider.dart';
import 'package:shop_app/screens/init_screen.dart';
import 'package:shop_app/screens/splash/splash_screen.dart';
import 'routes.dart';
import 'theme.dart';

void main() async {
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
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => CartNotifier()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SAMAWADE SHOPING',
        theme: AppTheme.lightTheme(context),
        initialRoute: LogoSplash.routeName,
        routes: routes,
      ),
    );
  }
}
