import 'package:flutter/material.dart';
import 'package:flutter_application_1/ui/Profile_screen.dart';
import 'package:flutter_application_1/ui/home_screen.dart';
import 'package:flutter_application_1/ui/setting.dart';

class CustomButtomNavigationBar extends StatefulWidget {
  const CustomButtomNavigationBar({super.key});

  @override
  State<CustomButtomNavigationBar> createState() => _CustomButtomNavigationBarState();
}

class _CustomButtomNavigationBarState extends State<CustomButtomNavigationBar> {
  List screenList = [
    const  HomeScreen(),
    const ProfileScreen(),
    const SettingScreen(),
  ];
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:screenList[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (value) {
          currentIndex = value;
          setState(() {});
        },
        backgroundColor: Colors.black,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.white,
        items:const [
        BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home"),
         BottomNavigationBarItem(icon: Icon(Icons.person),label: "Proile"),
         BottomNavigationBarItem(icon: Icon(Icons.settings),label: "Setting"),
    ]),
    );
  }
}

