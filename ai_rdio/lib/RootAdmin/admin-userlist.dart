import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../Utils/Constant.dart';
import 'admin-user-all-history.dart';

Future<SubscriptionData> fetchSubscriptionData(String email) async {
  final response = await http
      .get(Uri.parse('${Constant.url}/super/getSubscriptionData/$email'));
  print("API CAlled");
  if (response.statusCode == 200) {
    return SubscriptionData.fromJson(jsonDecode(response.body));
  } else {
    print("error");
    throw Exception('Failed to load subscription data');
  }
}

class SubscriptionData {
  final String startDate;
  final String endDate;

  SubscriptionData({required this.startDate, required this.endDate});

  factory SubscriptionData.fromJson(Map<String, dynamic> json) {
    return SubscriptionData(
      startDate: json['startDate'],
      endDate: json['endDate'],
    );
  }
}

class User {
  final String id;
  final String name;
  final String email;
  // final String password;
  final int age;
  final String gender;

  User({
    required this.id,
    required this.name,
    required this.email,
    // required this.password,
    required this.age,
    required this.gender,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      name: json['name'] ?? 'No name',
      email: json['email'] ?? "No email",
      // password: json['password'],
      age: int.parse(json['age'] ?? '0'),
      gender: json['gender'] ?? "Male",
    );
  }
}

class UserListPage extends StatefulWidget {
  @override
  _UserListPageState createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  List<User> _users = [];

  Future<List<User>> fetchUsers() async {
    try {
      var response =
          await http.get(Uri.parse('${Constant.url}/super/getAllUsers'));
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        List<User> users = [];
        for (var u in jsonData) {
          User user = User.fromJson(u);

          // check if user is already present in list before adding
          if (!_users.any((existingUser) => existingUser.email == user.email)) {
            users.add(user);
          }
        }
        return users;
      } else {
        throw Exception('Failed to load users: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load users: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      var connected = await checkInternetConnection();
      if (connected) {
        var users = await fetchUsers();
        setState(() {
          _users = users; // assign fetched users to _users
        });
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Internet Connection Error'),
            content:
                Text('Please check your internet connection and try again.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('$e'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  Future<bool> checkInternetConnection() async {
    try {
      var response = await http.get(Uri.parse('https://www.google.com'));
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  AssetImage _getProfileImageByGender(String gender) {
    return gender == 'male'
        ? AssetImage('assets/images/male-dp.png')
        : AssetImage('assets/images/female-dp.png');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'User List',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: FutureBuilder<List<User>>(
        future: fetchUsers(),
        builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
          if (snapshot.hasData) {
            _users.addAll(snapshot.data!);
            return ListView.builder(
              itemCount: _users.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  padding: EdgeInsets.all(11.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: Offset(0, 1), // changes position of shadow
                      ),
                    ],
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage:
                          _getProfileImageByGender(_users[index].gender),
                    ),
                    title: Text(
                      _users[index].name,
                    ),
                    subtitle: Text(
                        '${_users[index].email}, ${_users[index].age} years'),
                    onTap: () async {
                      var selectedUser = _users[index];
                      print(selectedUser.email);
                      await showDialog(
                        context: context,
                        builder: (context) {
                          String assetName = selectedUser.gender == 'male'
                              ? 'assets/images/male-dp.png'
                              : 'assets/images/female-dp.png';
                          return AlertDialog(
                            title: Row(
                              children: [
                                Image.asset(assetName, width: 32, height: 32),
                                SizedBox(width: 8),
                                Text(selectedUser.name),
                              ],
                            ),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Email: ${selectedUser.email}'),
                                SizedBox(height: 8),
                                Text('Age: ${selectedUser.age}'),
                                SizedBox(height: 8),
                                Text('Gender: ${selectedUser.gender}'),
                                SizedBox(height: 8),
                                FutureBuilder(
                                  future:
                                      fetchSubscriptionData(selectedUser.email),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      SubscriptionData? subscriptionData =
                                          snapshot.data;
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              'Start date: ${subscriptionData?.startDate}'),
                                          SizedBox(height: 8),
                                          Text(
                                              'End date: ${subscriptionData?.endDate}'),
                                        ],
                                      );
                                    } else if (snapshot.hasError) {
                                      return Text(
                                          'Error fetching subscription data');
                                    } else {
                                      return Text('No subscription');
                                    }
                                  },
                                ),
                              ],
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text('OK'),
                                style: TextButton.styleFrom(
                                  primary: Colors.white,
                                  backgroundColor: Colors
                                      .black, //set the background color to black
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => GymUserHistoryPage(
                                        userEmail: selectedUser.email,
                                        name: selectedUser.name,
                                      ),
                                    ),
                                  );
                                },
                                child: Text('History'),
                                style: TextButton.styleFrom(
                                  primary: Colors.black,
                                  backgroundColor: Colors.white,
                                  side: BorderSide(color: Colors.black),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Failed to load users: ${snapshot.error}'),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
