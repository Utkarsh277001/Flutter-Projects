import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ai_rdio/gymOwner/gymregister.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Utils/Constant.dart';
import '../screen/user-choice.dart';

class AdminProfilePage extends StatefulWidget {
  @override
  _AdminProfilePageState createState() => _AdminProfilePageState();
}

class _AdminProfilePageState extends State<AdminProfilePage> {
  // Set to false if user doesn't have a subscription
  int _totalGyms = 0;
  int _users = 0;
  int _totalGymOwners = 0;
  bool isgGymReg = true;
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Center(
          child: Text(
            'Admin Profile',
            // style: TextStyle(color: Colors.black),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
          child: Column(
            children: [
              SizedBox(height: 11),
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(100),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(255, 75, 75, 75).withOpacity(0.5),
                        spreadRadius: .5,
                        blurRadius: 3,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    radius: 75,
                    backgroundImage: AssetImage('assets/images/admin-dp.jpg'),
                  ),
                ),
              ),
              SizedBox(height: 18),
              Center(
                child: Text(
                  'Admin',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              SizedBox(height: 7),
              Center(
                child: Text(
                  'admin@gmail.com',
                  style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                ),
              ),
              SizedBox(height: 30),
              // Container(
              //   padding: EdgeInsets.symmetric(horizontal: 16, vertical: 11),
              //   decoration: BoxDecoration(
              //     color: Color.fromARGB(255, 247, 246, 246),
              //     borderRadius: BorderRadius.circular(21),
              //     boxShadow: [
              //       BoxShadow(
              //         color: Colors.black.withOpacity(0.5),
              //         spreadRadius: 1,
              //         blurRadius: 7,
              //         offset: Offset(0, 3), // changes position of shadow
              //       ),
              //     ],
              //   ),
              //   child: Row(
              //     children: [
              //       Icon(Icons.person, color: Colors.black),
              //       SizedBox(width: 21),
              //       Text(
              //         '',
              //         style: TextStyle(fontSize: 18, color: Colors.grey[700]),
              //       ),
              //     ],
              //   ),
              // ),
              // SizedBox(height: 21),
              // Container(
              //   padding: EdgeInsets.symmetric(horizontal: 16, vertical: 11),
              //   decoration: BoxDecoration(
              //     color: Color.fromARGB(255, 247, 246, 246),
              //     borderRadius: BorderRadius.circular(21),
              //     boxShadow: [
              //       BoxShadow(
              //         color: Colors.black.withOpacity(0.5),
              //         spreadRadius: 1,
              //         blurRadius: 7,
              //         offset: Offset(0, 3), // changes position of shadow
              //       ),
              //     ],
              //   ),
              //   child: Row(
              //     children: [
              //       Icon(Icons.cake, color: Colors.black),
              //       SizedBox(width: 21),
              //       Text(
              //         ' years old',
              //         style: TextStyle(fontSize: 18, color: Colors.grey[700]),
              //       ),
              //     ],
              //   ),
              // ),
              SizedBox(height: 32),
              Container(
                padding: EdgeInsets.all(21),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 247, 246, 246),
                  borderRadius: BorderRadius.circular(21),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.subscriptions, color: Colors.black),
                        SizedBox(width: 21),
                        Text(
                          'GymMate Stats ',
                          style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Text(
                      'No. of Gym Resgister : $_totalGyms',
                      style: TextStyle(fontSize: 17, color: Colors.grey[700]),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'No. of Gym Owners : $_totalGymOwners',
                      style: TextStyle(fontSize: 17, color: Colors.grey[700]),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'No. of Gym Owners : $_users',
                      style: TextStyle(fontSize: 17, color: Colors.grey[700]),
                    ),
                    SizedBox(height: 16),
                  ],
                ),
              ),
              SizedBox(height: 32),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255),
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(24)),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: ElevatedButton(
                    onPressed: () async {
                      final prefs = await SharedPreferences.getInstance();
                      prefs.remove('ownerId');
                      prefs.remove('ownerName');
                      prefs.remove('ownerEmail');
                      prefs.remove('ownerAge');
                      prefs.remove('ownerGender');
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Userchoice()));
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.logout, color: Colors.white),
                        SizedBox(width: 12),
                        Text('Logout',
                            style:
                                TextStyle(fontSize: 18, color: Colors.white)),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(21.0),
                      ),
                      padding: EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 10.0),
                      minimumSize: Size(300, 20),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
