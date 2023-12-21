import 'dart:convert';

import 'package:email_otp/email_otp.dart';
import 'package:ai_rdio/Utils/Dialog.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;

import '../Utils/Constant.dart';
import 'Otpp.dart';

class Visit {
  final String id;
  final String email;
  final String location;
  final String date;
  final bool visited;

  Visit(
      {required this.email,
      required this.id,
      required this.location,
      required this.date,
      required this.visited});

  factory Visit.fromJson(Map<String, dynamic> json) {
    return Visit(
        id: json['_id'],
        email: json['userEmail'],
        location: json['location'],
        date: json['date'],
        visited: json['Visited']);
  }
}

class TodayVisit extends StatefulWidget {
  final String ownerEmail;
  final String gymName;
  final String location;
  final String date;

  TodayVisit(
      {required this.date,
      required this.gymName,
      required this.location,
      required this.ownerEmail});

  @override
  _TodayVisitState createState() => _TodayVisitState();
}

class _TodayVisitState extends State<TodayVisit> {
  List<Visit> _userData = [];

  Future<void> _fetchData() async {
    http.Response res = await http.post(
      Uri.parse('${Constant.url}/gymData/ownerHistory'),
      body: jsonEncode({
        'ownerEmail': widget.ownerEmail,
        'gymName': widget.gymName,
        'location': widget.location,
        'date': widget.date,
      }),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
    );

    if (res.statusCode == 200) {
      final List<dynamic> data = jsonDecode(res.body);
      final List<Visit> visits = [];

      for (final item in data) {
        final visit = Visit.fromJson(item);
        visits.add(visit);
      }

      setState(() {
        _userData = visits;
      });
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  @override
  void initState() {
    super.initState();
    EasyLoading.show(status: "Loading Today's Visitor");

    _fetchData();
    EasyLoading.dismiss();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Today\'s Schedules',
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: ListView.builder(
        itemCount: _userData.length,
        itemBuilder: (context, index) =>
            DataContainer(userData: _userData[index]),
      ),
    );
  }
}

class DataContainer extends StatefulWidget {
  final Visit userData;

  const DataContainer({Key? key, required this.userData}) : super(key: key);
  @override
  _DataContainerState createState() => _DataContainerState();
}

class _DataContainerState extends State<DataContainer> {
  bool _visited = false;
  EmailOTP myauth = EmailOTP();

  Future updateVisited() async {
    http.Response res = await http.put(
      Uri.parse('${Constant.url}/gymData/updateVisited/${widget.userData.id}'),
      body: jsonEncode({
        'Visited': true,
      }),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
    );

    try {
      if (res.statusCode == 200) {
        print("Data updated successfully");
      } else if (res.statusCode == 400) {
        print("No data found with the given ID");
      } else {
        throw Exception("Failed to update data: ${res.statusCode}");
      }
    } catch (error) {
      print("Error while updating gym data: $error");
    }
  }

  @override
  void initState() {
    super.initState();
    _visited = widget.userData.visited;
  }

  void _markVisited() {
    print("fuction called");
    // updateGymData();
    updateVisited();
    setState(() {
      _visited = true;
    });
    msgPop(context, "Otp Verified", "Visitor Authenticated Successfully",
        DialogType.success, () {}, "ok");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 247, 246, 246),
        // border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
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
              Icon(Icons.email),
              SizedBox(width: 8),
              Text('Email: ${widget.userData.email}'),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.location_on),
              SizedBox(width: 8),
              Text('Location: ${widget.userData.location}'),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.calendar_today),
              SizedBox(width: 8),
              Text('Date: ${widget.userData.date}'),
            ],
          ),
          SizedBox(height: 16),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
            ),
            onPressed: _visited
                ? null
                : () async {
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) => OtpDialog()));
                    EasyLoading.show(status: "Sending OTP....");
                    myauth.setConfig(
                        appEmail: "contact@hdevcoder.com",
                        appName: "Fit-Sync OTP Verification",
                        userEmail: widget.userData.email,
                        otpLength: 4,
                        otpType: OTPType.digitsOnly);
                    EasyLoading.dismiss();
                    if (await myauth.sendOTP() == true) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("OTP has been sent"),
                          backgroundColor: Colors.green));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Oops, OTP send failed"),
                        backgroundColor: Colors.red,
                      ));
                    }
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OtpScreen(
                                  myauth: myauth,
                                  callback: _markVisited,
                                  subject: "Visitor Authentication OTP : ",
                                )));
                  },
            child: Text(_visited ? 'Visited' : 'Not Visited'),
          ),
        ],
      ),
    );
  }
}

// List<Visit> _dummyData = [
//   Visit(
//       email: 'john.doe@example.com',
//       location: 'New York City',
//       date: '2023-05-08'),
//   Visit(
//       email: 'jane.doe@example.com',
//       location: 'Los Angeles',
//       date: '2023-05-08'),
//   Visit(
//       email: 'bill.smith@example.com', location: 'Chicago', date: '2023-05-08'),
//   Visit(
//       email: 'mary.johnson@example.com',
//       location: 'San Francisco',
//       date: '2023-05-08'),
// ];
