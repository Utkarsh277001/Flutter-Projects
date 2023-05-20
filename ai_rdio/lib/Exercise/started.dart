//import 'package:fitness_app/HomeScreen.dart';
//import 'package:fitness_app/const.dart';
import 'package:flutter/material.dart';

import 'HomeScreen.dart';
import 'const.dart';

class GetStarted extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: size.height / 20,
          ),
          Container(
            height: size.height / 1.5,
            width: size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/cover-2.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            height: size.height / 30,
          ),
          Container(
            width: size.width / 1.15,
            child: Text(
              "Get to your ideal body",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: color[2],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Container(
              width: size.width / 1.15,
              child: Text(
                "by exercising",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                  color: color[2],
                ),
              ),
            ),
          ),
          Container(
            width: size.width / 1.15,
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: () => Navigator.push(
                  context, MaterialPageRoute(builder: (_) => HomeScreen())),
              child: Container(
                height: size.height / 15,
                width: size.height / 15,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromARGB(255, 43, 42, 42),
                ),
                child: Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
