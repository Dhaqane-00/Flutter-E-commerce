import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shop_app/SplashLogo.dart';
import 'package:shop_app/firebase_options.dart';
import 'package:shop_app/provider/CartProvider.dart';
import 'package:shop_app/provider/OrderProvider.dart';
import 'package:shop_app/provider/ProductProvider.dart';
import 'package:shop_app/provider/UserOrderProvider.dart';
import 'package:shop_app/provider/loginProvider.dart';
import 'package:shop_app/screens/cart/components/LocationProvider.dart';
import 'package:shop_app/screens/init_screen.dart';
import 'package:shop_app/screens/splash/splash_screen.dart';
import 'package:shop_app/server/dependency_injection.dart';
import 'routes.dart';
import 'theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final fcmToken = await FirebaseMessaging.instance.getToken();
  print("""FCM token: $fcmToken"""); // Print the fcmToken); 
  await GetStorage.init();
  runApp(const MyApp());
  DependencyInjection.init();
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
        ChangeNotifierProvider(create: (_) => LocationProvider()),
        ChangeNotifierProvider(create: (_) => OrderProvider()),
        ChangeNotifierProvider(create: (_) => UserOrderProvider()),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'E-COMMERCE SHOPING',
        theme: AppTheme.lightTheme(context),
        initialRoute: LogoSplash.routeName,
        routes: routes,
      ),
    );
  }
}
