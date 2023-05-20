import 'dart:async';

import 'package:ai_rdio/navbar/main_page.dart';
import 'package:ai_rdio/screen/RegLoginUi.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class splash extends StatefulWidget {
  const splash({super.key});

  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> {
  @override
  void initState() {
    super.initState();
    validation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 235, 179, 252),
      body: Container(
        // ignore: prefer_const_constructors
        child: Center(
            child: const Text(
          "GymMate",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        )),
      ),
    );
  }

  void validation() async {
    Timer(Duration(milliseconds: 500), () async {
      final prefs = await SharedPreferences.getInstance();
      if (prefs.getString('id') != null) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => MainPage(),
            ));
      } else {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => RegLoginUi(),
            ));
      }
    });
  }
}
