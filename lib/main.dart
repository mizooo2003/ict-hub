import 'package:flutter/material.dart';
import 'package:flutter_application_1/ui/buttom_navgationbar.dart';
import 'package:flutter_application_1/ui/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
     
      home: CustomButtomNavigationBar() ,
    );
  }
}


  

