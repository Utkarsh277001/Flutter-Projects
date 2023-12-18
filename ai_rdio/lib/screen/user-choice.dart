import 'package:ai_rdio/gymOwner/owner-login.dart';
import 'package:ai_rdio/screen/RegLoginUi.dart';
import 'package:flutter/material.dart';

import '../RootAdmin/admin-login.dart';

class Userchoice extends StatefulWidget {
  @override
  _UserchoiceState createState() => _UserchoiceState();
}

class _UserchoiceState extends State<Userchoice> {
  final List<String> _images = [
    'assets/images2/user-admin-1.jpg',
    'assets/images2/Mobile-login.jpg',
    'assets/images2/user-admin-2.jpg',
    'assets/images2/user-admin-3.jpg',
  ];

  int _currentIndex = 0;

  List<String> _loginOptions = ["User", "Admin"];

  String _selectedOption = "User";

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    Future.delayed(Duration(seconds: 3)).then((value) {
      setState(() {
        if (_currentIndex < _images.length - 1) {
          _currentIndex++;
        } else {
          _currentIndex = 0;
        }
      });
      _startTimer();
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
              child: Container(
                key: ValueKey<int>(_currentIndex),
                height: size.height / 1.6,
                width: size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(_images[_currentIndex]),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: size.height / 39,
            ),
            Column(
              children: [
                Container(
                  width: size.width / 1.15,
                  child: Text(
                    "Welcome To Fit-Sync",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(
                  height: 7,
                ),
                Container(
                  width: size.width / 1.15,
                  // child: Text(
                  //   "Login/Signup as",
                  //   textAlign: TextAlign.center,
                  //   style: TextStyle(
                  //     fontSize: 24,
                  //     // fontWeight: FontWeight.bold,
                  //     color: Colors.black,
                  //   ),
                  // ),
                  child: Column(children: [
                    Text(
                      "Login/Signup as",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        // fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    // Icon(Icons.account_box)
                    GestureDetector(
                      onTap: () {
                        print("Admin button clicked");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AdminRegLoginUi()),
                        );
                      },
                      child: Icon(Icons.account_circle),
                    )
                  ]),
                ),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: (_selectedOption == "User")
                                ? Color.fromARGB(255, 228, 226, 226)
                                : Colors.transparent,
                            spreadRadius: 0,
                            blurRadius: 0,
                            offset: Offset(0, 3),
                          )
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                _selectedOption = "User";
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.person,
                                    size: 50,
                                    color: (_selectedOption == "User"
                                        ? Colors.black
                                        : Colors.grey),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    " Gym User  ",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: (_selectedOption == "User"
                                          ? Colors.black
                                          : Colors.grey),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: (_selectedOption == "Admin")
                                ? Color.fromARGB(255, 228, 226, 226)
                                    .withOpacity(1)
                                : Colors.transparent,
                            spreadRadius: 2,
                            blurRadius: 0,
                            offset: Offset(0, 3),
                          )
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                _selectedOption = "Admin";
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.analytics,
                                    size: 50,
                                    color: (_selectedOption == "Admin"
                                        ? Colors.black
                                        : Colors.grey),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    "Gym Owner",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: (_selectedOption == "Admin"
                                          ? Colors.black
                                          : Colors.grey),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_selectedOption == "Admin") {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => OwnerRegLoginUi()));
                    } else {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => RegLoginUi()));
                    }
                  },
                  child: Text(
                    'Login/Signup',
                    style: TextStyle(fontSize: 20),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                    padding:
                        EdgeInsets.symmetric(vertical: 12.0, horizontal: 60.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
