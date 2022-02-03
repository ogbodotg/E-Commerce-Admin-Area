import 'package:ahia_admin/Pages/Administrators.dart';
import 'package:ahia_admin/Pages/BannerManager.dart';
import 'package:ahia_admin/Pages/DeliveryAgents.dart';
import 'package:ahia_admin/Pages/HomeScreen.dart';
import 'package:ahia_admin/Pages/LoginPage.dart';
import 'package:ahia_admin/Pages/NotificationScreen.dart';
import 'package:ahia_admin/Pages/Orders.dart';
import 'package:ahia_admin/Pages/ProductCategories.dart';
import 'package:ahia_admin/Pages/SettingScreen.dart';
import 'package:ahia_admin/Pages/SplashScreen.dart';
import 'package:ahia_admin/Pages/VendorScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Wiwa Admin Area',
        theme: ThemeData(
          // primarySwatch: Colors.blue,
          primaryColor: Colors.purple,
          // primaryColor: Color(0xFF84c225),
        ),
        // home: LoginPage(),
        home: SplashScreen(),
        routes: {
          HomeScreen.id: (context) => HomeScreen(),
          SplashScreen.id: (context) => SplashScreen(),
          LoginPage.id: (context) => LoginPage(),
          BannerScreen.id: (context) => BannerScreen(),
          ProductCategoryScreen.id: (context) => ProductCategoryScreen(),
          Orders.id: (context) => Orders(),
          NotificationScreen.id: (context) => NotificationScreen(),
          AdminUsers.id: (context) => AdminUsers(),
          SettingScreen.id: (context) => SettingScreen(),
          VendorScreen.id: (context) => VendorScreen(),
          DeliveryAgents.id: (context) => DeliveryAgents(),
        });
  }
}
