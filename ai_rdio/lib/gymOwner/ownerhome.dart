import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../Utils/Constant.dart';
import 'gym-owner-gym-page.dart';
import 'gymregister.dart';

class AdminHomePage extends StatefulWidget {
  @override
  _AdminHomePageState createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  bool _hasRegisteredGym = true;
  List<GymInfo> _gymData = [];
  String ownerName = '';
  String ownerEmail = '';
  String totalgym = '';

  @override
  void initState() {
    super.initState();
    EasyLoading.show(status: 'Loading Gym details...');
    _getGyms();
  } 

  Future<void> _getGyms() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    ownerName = prefs.getString('ownerName') ?? '';
    ownerEmail = prefs.getString('ownerEmail') ?? '';
    print(ownerEmail);

    String url = '${Constant.url}/gymInfo/ownerGymDetails/' + ownerEmail;
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        // var jsonData = json.decode(response.body);
        EasyLoading.dismiss();
        setState(() {
          _gymData = (json.decode(response.body) as List)
              .map((data) => GymInfo.fromJson(data))
              .toList();
          print("successfully retrive");
          print(_gymData);
          print(_gymData.length);
          _hasRegisteredGym = true;
        });
      } else {
        _hasRegisteredGym = false;
        print('Failed to load gyms: ${response.statusCode}');
      }
      setLen();
    } catch (error) {
      print('Error loading gyms: $error');
    }
  }

  Future<void> setLen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('len', _gymData.length.toString());
    totalgym = prefs.getString('len') ?? '';
    print("total Gym");
    print(totalgym);
  }

  @override
  Widget build(BuildContext context) {
    print(ownerEmail);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Center(
          child: Text(
            "My Gyms",
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
            ),
          ),
        ),
        actions: [
          Container(
            child: IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                // Navigate to gym registration screen
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => GymRegistrationPage()));
              },
            ),
          ),
        ],
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: _hasRegisteredGym
          ? ListView.builder(
              itemCount: _gymData.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GymOwnerPage(
                                  gymData: _gymData[index],
                                )));
                    print(_gymData[index]);
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    height: MediaQuery.of(context).size.width *
                        0.8, // set the height to be more than width
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      // color: Colors.white,
                      image: DecorationImage(
                        image: NetworkImage(_gymData[index].gymPic),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          bottom: 20,
                          left: 20,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    // _gymData[index]["gymName"] as String,
                                    _gymData[index].gymName,
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Icon(Icons.location_on,
                                      size: 18, color: Colors.white),
                                  SizedBox(width: 5),
                                  Text(
                                    // _gymData[index]["City"] as String,
                                    _gymData[index].location.trim(),
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images2/no-gym.jpg'),
                Container(
                  padding: EdgeInsets.all(16.0),
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Text(
                        'You have not registered any gym!',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16.0),
                      ElevatedButton(
                        onPressed: () {
                          print("logout");
                          // TODO: Implement logout functionality
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => GymRegistrationPage()));
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.app_registration, color: Colors.white),
                            SizedBox(width: 12),
                            Text('Register Now',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white)),
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
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}

class GymInfo {
  var id;
  final String owneremail;
  final String gymPic;

  final String gymName;

  final String location;

  var contactDetails;

  final String perDayRate;

  GymInfo({
    required this.owneremail,
    required this.id,
    required this.gymPic,
    required this.gymName,
    required this.location,
    required this.contactDetails,
    required this.perDayRate,
  });

  factory GymInfo.fromJson(Map<String, dynamic> json) {
    return GymInfo(
      id: json['_id'],
      owneremail: json['ownerEmail'],
      gymPic: json['Image'],
      gymName: json['gymName'],
      location: "${json['City'] ?? ''} , ${json['State'] ?? ''}".trim(),
      perDayRate: json['perDayRate'],
      contactDetails: json['contactDetails'],
    );
  }
}
