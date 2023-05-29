import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../RootAdmin/admin-gym-all-user-history.dart';
import '../RootAdmin/admin-user-all-history.dart';
import '../Utils/Constant.dart';
import 'ownerhistory-2.dart';

class OwnerHistoryPage extends StatefulWidget {
  @override
  _OwnerHistoryPageState createState() => _OwnerHistoryPageState();
}

class _OwnerHistoryPageState extends State<OwnerHistoryPage> {
  bool _isLoading = false;
  List<dynamic> _gyms = [];

  void _getGyms(String ownerEmail) async {
    setState(() {
      _isLoading = true;
    });
    final response = await http.get(
        Uri.parse('${Constant.url}/gymInfo/ownerGymDetails/' + ownerEmail));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        _gyms = data;
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      // handle error
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchOwnerEmail();
  }

  void _fetchOwnerEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final ownerEmail = prefs.getString('ownerEmail');
    if (ownerEmail != null) {
      _getGyms(ownerEmail);
    } else {
      // handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Center(
          child: Text(
            'Gym List',
            style: TextStyle(color: Colors.black),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: [
          SizedBox(height: 16.0),
          Expanded(
            child: _isLoading
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: _gyms.length,
                    itemBuilder: (BuildContext context, int index) {
                      final gym = _gyms[index];
                      return Container(
                        margin: EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
                        padding: EdgeInsets.all(11.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset:
                                  Offset(0, 1), // changes position of shadow
                            ),
                          ],
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: ListTile(
                          leading: Image.network(gym['Image']),
                          title: Text(gym['gymName']),
                          subtitle: Text('${gym['City']}, ${gym['State']}'),
                          trailing: ElevatedButton(
                            onPressed: () {
                              print(gym['gymName']);
                              print(gym['ownerEmail']);
                              var space = " " + "," + " ";
                              var location = gym['City'] + space + gym['State'];
                              print(location);

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => OwnerGymHistory(
                                        ownerEmail: gym['ownerEmail'],
                                        gymName: gym['gymName'],
                                        location: location)),
                              );
                              // navigate to history page
                            },
                            child: Text('History'),
                            // style: TextButton.styleFrom(
                            //   primary: Colors.black,
                            //   backgroundColor: Colors.white,
                            //   side: BorderSide(color: Colors.black),
                            // ),
                            style: TextButton.styleFrom(
                              primary: Colors.white,
                              backgroundColor: Colors
                                  .black, //set the background color to black
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
