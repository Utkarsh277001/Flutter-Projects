import 'package:ai_rdio/RootAdmin/fitsyncadmin.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../Utils/Constant.dart';
import 'admin-gymlist.dart';
import 'admin-userlist.dart';
import 'admin-gymownerlist.dart';

class SuperAdminHomePage extends StatefulWidget {
  @override
  _SuperAdminHomePageState createState() => _SuperAdminHomePageState();
}

class _SuperAdminHomePageState extends State<SuperAdminHomePage> {
  int _totalGyms = 0;
  int _users = 0;
  int _totalGymOwners = 0;

  final List<String> _images = [
    'assets/images2/user-admin-1.jpg',
    'assets/images2/Mobile-login.jpg',
    'assets/images2/user-admin-2.jpg',
    'assets/images2/user-admin-3.jpg',
  ];

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final response =
        await http.get(Uri.parse('${Constant.url}/super/getStats'));
    final data = jsonDecode(response.body);
    print("Api called");
    setState(() {
      print("Setstate");
      _totalGyms = data['totalGyms'];
      _users = data['totalUsers'];
      _totalGymOwners = data['totalGymOwners'];
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            // height: size.height / .6,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images2/analyze-2.jpg'),
                // fit: BoxFit.cover,
              ),
            ),
          ),
          // AnimatedSwitcher(
          //     duration: Duration(milliseconds: 300),
          //     child: Container(
          //       key: ValueKey<int>(_currentIndex),
          //       height: size.height / 1.6,
          //       width: size.width,
          //       decoration: BoxDecoration(
          //         image: DecorationImage(
          //           image: AssetImage(_images[_currentIndex]),
          //           fit: BoxFit.cover,
          //         ),
          //       ),
          //     ),
          //   ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 100),
              Text(
                'FitSync',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Access Gyms Anywhere',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
              ),
              Spacer(),
              // Spacer(),
              SizedBox(height: 50),
              Expanded(
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  margin: const EdgeInsets.all(21.0),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(40),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(255, 75, 75, 75).withOpacity(0.5),
                        spreadRadius: .5,
                        blurRadius: 3,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 0, horizontal: 21.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.people, color: Colors.black),
                                SizedBox(width: 8),
                                Text(
                                  'Total Users',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => UserListPage()),
                                );

                                // handle button press
                              },
                              child: Text(
                                '$_users',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.fitness_center, color: Colors.black),
                                SizedBox(width: 8),
                                Text(
                                  'Total Gyms',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                              ),
                              onPressed: () {
                                // handle button press
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => GymList()),
                                );
                              },
                              child: Text('$_totalGyms',
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.person_pin_circle,
                                    color: Colors.black),
                                SizedBox(width: 8),
                                Text(
                                  'Total GymOwners',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                              ),
                              onPressed: () {
                                // handle button press
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => GymOwnersPage()),
                                );
                              },
                              child: Text('$_totalGymOwners',
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.shopping_cart, color: Colors.black),
                                SizedBox(width: 8),
                                Text(
                                  'FitSync Products',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                              ),
                              onPressed: () {
                                // handle button press
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => fitsyncadmin()),
                                );
                              },
                              child: Text('$_totalGymOwners',
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
