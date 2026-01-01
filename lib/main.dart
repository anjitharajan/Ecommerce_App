import 'package:e_commerce_app/Screens/auth/login.dart';
import 'package:e_commerce_app/Screens/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/hive_flutter.dart';



void main() async {
WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp();
await Hive.initFlutter();
await Hive.openBox('userBox');
await Hive.openBox('cartBox');
await Hive.openBox('orderBox');


runApp(MyApp());
}


class MyApp extends StatelessWidget {
@override
Widget build(BuildContext context) {
final userBox = Hive.box('userBox');
bool isLoggedIn = userBox.get('isLoggedIn', defaultValue: false);


return MaterialApp(
debugShowCheckedModeBanner: false,
title: 'E-Commerce App',
home: isLoggedIn ? HomePage() : LoginPage(),
);
}
}