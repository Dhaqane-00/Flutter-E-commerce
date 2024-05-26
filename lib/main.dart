import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import the provider package
import 'package:shop_app/firebase_options.dart';
import 'package:shop_app/screens/splash/splash_screen.dart';
import 'package:shop_app/provider/loginProvider.dart'; // Import the UserProvider
import 'routes.dart';
import 'theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()), // Add UserProvider here
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'The Flutter Way - Template',
        theme: AppTheme.lightTheme(context),
        initialRoute: SplashScreen.routeName,
        routes: routes,
      ),
    );
  }
}
