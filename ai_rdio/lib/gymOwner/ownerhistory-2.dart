import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Utils/Constant.dart';

class OwnerGymHistory extends StatefulWidget {
  final String ownerEmail;
  final String gymName;
  final String location;

  OwnerGymHistory(
      {required this.ownerEmail,
      required this.gymName,
      required this.location});

  @override
  _OwnerGymHistoryState createState() => _OwnerGymHistoryState();
}

class _OwnerGymHistoryState extends State<OwnerGymHistory> {
  List<dynamic> gyms = [];
  dynamic _selectedUser;

  Future<List<dynamic>> getUsers(String userEmail) async {
    try {
      final response =
          await http.get(Uri.parse('${Constant.url}/super/getUser/$userEmail'));
      if (response.statusCode == 200) {
        return json.decode(response.body)['user'];
      } else {
        throw Exception('Failed to get user: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Error getting user: $e');
    }
  }

  String getUserProfileImage(dynamic user) {
    if (user != null && user['gender'] == 'male') {
      return 'assets/images/male-dp.png';
    } else if (user != null && user['gender'] == 'female') {
      return 'assets/images/female-dp.png';
    } else {
      return 'assets/images/default_profile.png';
    }
  }

  @override
  void initState() {
    super.initState();
    getGyms();
  }

  Future<void> getGyms() async {
    try {
      final response = await http.get(Uri.parse(
          '${Constant.url}/super/GymHistoryRecordForGymOwner/${widget.ownerEmail}/${widget.gymName}/${widget.location}'));
      if (response.statusCode == 200) {
        setState(() {
          gyms = json.decode(response.body);
        });
      } else {
        throw Exception('Failed to get gyms: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Error getting gyms: $e');
    }
  }

  void _showUserDialog(dynamic user) {
    showDialog(
      context: context,
      builder: (_) => UserDialog(user: user),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('${widget.gymName} History',
            style: TextStyle(color: Colors.black)),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              getGyms();
            },
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: ListView.builder(
        itemCount: gyms.length,
        itemBuilder: (BuildContext context, int index) {
          String userEmail = gyms[index]['userEmail'];
          return Container(
            margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            padding: EdgeInsets.all(7.0),
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
            child: FutureBuilder<List<dynamic>>(
              future: getUsers(userEmail),
              builder: (BuildContext context,
                  AsyncSnapshot<List<dynamic>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return ListTile(
                    leading: CircularProgressIndicator(),
                    title: Text(userEmail),
                    subtitle: Text(
                        '${gyms[index]['date']} at ${gyms[index]['time']}'),
                    trailing: gyms[index]['Visited']
                        ? ElevatedButton(
                            onPressed: () {},
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Color.fromARGB(255, 206, 206, 206)),
                            ),
                            child: Text(
                              'Visited',
                              style: TextStyle(color: Colors.black),
                            ),
                          )
                        : ElevatedButton(
                            onPressed: () {},
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.black),
                            ),
                            child: Text(
                              'Not Visited',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                  );
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  // User not found or data is empty
                  return ListTile(
                    leading: Image.asset('assets/images/default_profile.png'),
                    title: Text(userEmail),
                    subtitle: Text(
                        '${gyms[index]['date']} at ${gyms[index]['time']}'),
                    trailing: gyms[index]['Visited']
                        ? ElevatedButton(
                            onPressed: () {},
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Color.fromARGB(255, 206, 206, 206)),
                            ),
                            child: Text(
                              'Visited',
                              style: TextStyle(color: Colors.black),
                            ),
                          )
                        : ElevatedButton(
                            onPressed: () {},
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.black),
                            ),
                            child: Text(
                              'Not Visited',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                  );
                }

                var user = snapshot.data?.first;
                return ListTile(
                  onTap: () {
                    setState(() {
                      _selectedUser = user;
                    });
                    _showUserDialog(user);
                  },
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(getUserProfileImage(user)),
                  ),
                  title: Text(userEmail),
                  subtitle:
                      Text('${gyms[index]['date']} at ${gyms[index]['time']}'),
                  trailing: gyms[index]['Visited']
                      ? ElevatedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color.fromARGB(255, 206, 206, 206)),
                          ),
                          child: Text(
                            'Visited',
                            style: TextStyle(color: Colors.black),
                          ),
                        )
                      : ElevatedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.black),
                          ),
                          child: Text(
                            'Not Visited',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class UserDialog extends StatelessWidget {
  final dynamic user;

  const UserDialog({required this.user});

  String getUserProfileImage() {
    if (user != null && user['gender'] == 'male') {
      return 'assets/images/male-dp.png';
    } else if (user != null && user['gender'] == 'female') {
      return 'assets/images/female-dp.png';
    } else {
      return 'assets/images/default_profile.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(child: Text('User Info')),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                backgroundImage: AssetImage(getUserProfileImage()),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Text(
                  user['name'] ?? user['email'],
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Text('Email: ${user['email']}'),
          SizedBox(height: 8),
          Text('Gender: ${user['gender'] ?? 'Unknown'}'),
          SizedBox(height: 8),
          Text('Age: ${user['age'] ?? 'Unknown'}'),
        ],
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK'),
            style: TextButton.styleFrom(
              primary: Colors.white,
              backgroundColor: Colors.black, //set the background color to black
            )),
      ],
    );
  }
}
