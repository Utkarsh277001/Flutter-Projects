import 'package:ai_rdio/gymOwner/ownermain.dart';
import 'package:ai_rdio/screen/user-choice.dart';
import 'package:flutter/material.dart';

import 'dart:async';

import 'package:ai_rdio/navbar/main_page.dart';
import 'package:ai_rdio/screen/RegLoginUi.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    validation();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    _animationController.repeat();
    // Future.delayed(Duration(seconds: 3), () {
    //   Navigator.pushReplacement(
    //       context, MaterialPageRoute(builder: (_) => Main()));
    // });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(255, 12, 12, 12)!,
                  Color.fromARGB(255, 4, 4, 4)!
                ],
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RotationTransition(
                  turns: Tween<double>(begin: 0, end: 0)
                      .animate(_animationController),
                  child: Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/logo-gym.png')),
                    ),
                  ),
                ),
                SizedBox(height: 40),
                Text(
                  'Loading...',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'Pacifico',
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60),
                  child: LinearProgressIndicator(
                    backgroundColor: Color.fromARGB(255, 57, 57, 57),
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
                // SizedBox(height: 40),
                // TextButton(
                //   onPressed: () {
                //     Navigator.pushReplacement(
                //         context, MaterialPageRoute(builder: (_) => HomePage()));
                //   },
                //   style: ButtonStyle(
                //     foregroundColor:
                //         MaterialStateProperty.all<Color>(Colors.white),
                //     backgroundColor:
                //         MaterialStateProperty.all<Color>(Colors.purple[200]!),
                //     shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                //       RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(20.0),
                //       ),
                //     ),
                //   ),
                //   child: Padding(
                //     padding: const EdgeInsets.symmetric(horizontal: 30),
                //     child: Text(
                //       'SKIP',
                //       style: TextStyle(
                //         fontSize: 20,
                //         fontWeight: FontWeight.bold,
                //         fontFamily: 'Montserrat',
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void validation() async {
    Timer(Duration(milliseconds: 500), () async {
      final prefs = await SharedPreferences.getInstance();
      if (prefs.getString('id') != null) {
        Navigator.pushReplacement(
            context as BuildContext,
            MaterialPageRoute(
              builder: (context) => MainPage(),
            ));
      } else if (prefs.getString("ownerEmail") != null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => OwnerMainPage()));
      } else {
        Navigator.pushReplacement(
            context as BuildContext,
            MaterialPageRoute(
              builder: (context) => Userchoice(),
            ));
      }
    });
  }
}
