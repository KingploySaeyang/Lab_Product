import 'package:flutter/material.dart';
import 'package:fluttersuccess/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'HomePage.dart';
//import 'LoginPage.dart';
//import 'RegisterPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      //ครอบด้วยProvider
      create: (context) =>
          UserProvider(), //กำลังจะสร้างProviderตัวใหม่ ให้ติดตามUserProvider
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.pink,
        ),
        home: HomePage(),
      ),
    );
  }
}
