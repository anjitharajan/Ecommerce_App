import 'package:e_commerce_app/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'Screens/auth/login.dart';
import 'Screens/home/home_page.dart';

//------ Providers-------\\
import 'providers/cart_provider.dart';
import 'providers/order_provider.dart';
import 'providers/user_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //------- Initialize Firebase -------\\
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //------- Initialize Hive-------\\
  await Hive.initFlutter();
  await Hive.openBox('userBox');
  await Hive.openBox('cartBox');
  await Hive.openBox('orderBox');

 //------- multiprovider setup -------\\  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => OrderProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //--------Access Hive box -------\\
    final userBox = Hive.box('userBox');
    bool isLoggedIn = userBox.get('isLoggedIn', defaultValue: false);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-Commerce App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: isLoggedIn ? HomePage() : LoginPage(),
    );
  }
}
