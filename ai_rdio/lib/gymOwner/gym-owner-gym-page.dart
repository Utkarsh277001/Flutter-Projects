import 'dart:convert';
// import 'dart:html';

import 'package:ai_rdio/gymOwner/ownerhome.dart';
import 'package:ai_rdio/gymOwner/today-visit.dart';
import 'package:ai_rdio/gymOwner/update-gym.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Utils/Constant.dart';
import '../Utils/Dialog.dart';
import 'ownermain.dart';

class GymOwnerPage extends StatefulWidget {
  final GymInfo gymData;

  GymOwnerPage({super.key, required this.gymData});

  @override
  State<GymOwnerPage> createState() => _GymOwnerPageState();
}

class _GymOwnerPageState extends State<GymOwnerPage> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  // List<VisitorData> visitorItems = [];
  String ownerName = '';
  String ownerEmail = '';
  String gymName = '';
  String location = '';
  String finaldate = '';

  Future<void> deleteGym() async {
    EasyLoading.show(status: 'Deleting Gym...');
    final url = '${Constant.url}/gymInfo/deleteGymData/' + widget.gymData.id;
    final response = await http.delete(Uri.parse(url));

    if (response.statusCode == 200) {
      EasyLoading.showSuccess('Gym Deleted Successfully..');
      EasyLoading.dismiss();
      // Gym was deleted successfully
      // return true;
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => OwnerMainPage()));
    } else {
      // Something went wrong with the API request
      final responseBody = json.decode(response.body);
      final errorMessage =
          responseBody['message'] ?? 'An error occurred while deleting the gym';
      throw Exception(errorMessage);
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked =
        await showTimePicker(context: context, initialTime: selectedTime);
    if (picked != null && picked != selectedTime)
      setState(() {
        selectedTime = picked;
      });
  }

  // Future<void> getHistoryData() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   // id = prefs.getString('id')!;
  //   gymName = widget.gymData.gymName;
  //   ownerEmail = prefs.getString('ownerEmail')!;
  //   location = widget.gymData.location;

  //   print(gymName);
  //   print(ownerEmail);
  //   print(finaldate);
  //   print(location);
  //   // print(id + '  hai');
  //   var url = Uri.parse(
  //       '${Constant.url}/gymDatas/ownerHistory'); // Replace with your backend URL
  //   var response = await http.post(url);
  //   if (response.statusCode == 200) {
  //     print(response.statusCode);
  //     setState(() {
  //       visitorItems = (json.decode(response.body) as List)
  //           .map((data) => VisitorData.fromJson(data))
  //           .toList();
  //       visitorItems = visitorItems.reversed.toList();
  //       // var res = json.decode(response.body);
  //       print(visitorItems);
  //     });
  //   } else {
  //     print('Request failed with status: ${response.statusCode}.');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    String date = DateFormat.yMd().format(selectedDate);
    String time = selectedTime.format(context);
    finaldate = date;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Gym Profile",
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white, // make Appbar transparent
        actions: [
          IconButton(
            icon: Icon(
              Icons.edit,
              color: Colors.black,
            ),
            onPressed: () {
              print(widget.gymData.id);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Gymupdate(
                            id: widget.gymData.id,
                          )));
            },
          ),
          IconButton(
            icon: Icon(
              Icons.delete,
              color: Colors.black,
            ),
            onPressed: () {
              msgPop(context, "Delete Gym", "Are you want to delete you gym",
                  DialogType.warning, deleteGym, "Delete");
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => Gymupdate(
              //               id: widget.gymData.id,
              //             )));
              // handle edit button press
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.width *
                  1.4, // set the height to be more than width
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: NetworkImage(widget.gymData.gymPic),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(children: [
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    width: double.infinity,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "Gym Details ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 28.0,
                          ),
                        ),
                        // InkWell(
                        //   onTap: () => _selectDate(context),
                        //   child: Column(
                        //     mainAxisAlignment: MainAxisAlignment.center,
                        //     children: [
                        //       Icon(Icons.calendar_today),
                        //       SizedBox(height: 5),
                        //       Text(
                        //         DateFormat.yMd().format(selectedDate),
                        //         style: TextStyle(
                        //           fontWeight: FontWeight.bold,
                        //           fontSize: 16.0,
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        // InkWell(
                        //   onTap: () => _selectTime(context),
                        //   child: Column(
                        //     mainAxisAlignment: MainAxisAlignment.center,
                        //     children: [
                        //       Icon(Icons.access_time),
                        //       SizedBox(height: 5),
                        //       Text(
                        //         selectedTime.format(context),
                        //         style: TextStyle(
                        //           fontWeight: FontWeight.bold,
                        //           fontSize: 16.0,
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
              ]),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 3, 20, 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // SizedBox(height: 7.0),
                  Row(
                    children: [
                      Icon(Icons.home, color: Colors.black),
                      SizedBox(width: 12),
                      Text(
                        // gymData["name"] ?? "" as String,
                        widget.gymData.gymName,
                        style: TextStyle(fontSize: 20, color: Colors.grey[700]),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    children: [
                      Icon(Icons.place, color: Colors.black),
                      SizedBox(width: 12),
                      Text(
                        widget.gymData.location,
                        style: TextStyle(fontSize: 20, color: Colors.grey[700]),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    children: [
                      Icon(Icons.money, color: Colors.black),
                      SizedBox(width: 12),
                      Text(
                        "per day Expense: " + widget.gymData.perDayRate,
                        style: TextStyle(fontSize: 20, color: Colors.grey[700]),
                      ),
                    ],
                  ),

                  SizedBox(height: 8.0),
                  Row(
                    children: [
                      Icon(Icons.contacts, color: Colors.black),
                      SizedBox(width: 12),
                      Text(
                        "Contact: " + widget.gymData.contactDetails,
                        style: TextStyle(fontSize: 20, color: Colors.grey[700]),
                      ),
                    ],
                  ),
                  SizedBox(height: 21.0),
                  Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                        onPressed: () {
                          // TODO: Implement purchase subscription functionality

                          print(date);
                          print(widget.gymData.id);
                          print(widget.gymData.gymName);
                          print(widget.gymData.location);
                          print(widget.gymData.owneremail);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TodayVisit(
                                      date: date,
                                      gymName: widget.gymData.gymName,
                                      location: widget.gymData.location,
                                      ownerEmail: widget.gymData.owneremail)));
                          // getHistoryData();
                        },
                        child: Text('Today`s Visitors',
                            style:
                                TextStyle(fontSize: 18, color: Colors.white)),
                        // style: ElevatedButton.styleFrom(primary: Colors.black),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(21.0),
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 80.0, vertical: 12.0),
                          minimumSize: Size(120, 20),
                        )),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class VisitorData {
//   final String id;
//   final String picNo;
//   final String gymName;
//   final String location;
//   final String date;
//   final String time; // Add this line
//   final String ownerEmail;

//   VisitorData({
//     required this.id,
//     required this.gymName,
//     required this.location,
//     required this.date,
//     required this.time,
//     required this.picNo, // Add this line
//     required this.ownerEmail,
//   });

//   factory VisitorData.fromJson(Map<String, dynamic> json) {
//     return VisitorData(
//       // image: json[''],
//       id: json['_id'],
//       gymName: json['gymName'], // Change this line to match your response key
//       location: json['location'] ?? " ",
//       date: json['date'] ?? " ",
//       time: json['time'] ?? " ",
//       picNo: json['picNo'] ?? "0",
//       ownerEmail: json['ownerEmail'] ?? " ",
//       // Add this line and set default value to empty string if null
//     );
//   }
// }
