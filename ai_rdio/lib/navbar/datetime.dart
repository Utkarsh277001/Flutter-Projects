import 'dart:convert';

import 'package:ai_rdio/navbar/gmap.dart';
import 'package:ai_rdio/navbar/payscreen.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:ai_rdio/Services/dailyGym.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Utils/Constant.dart';
import '../Utils/Dialog.dart';
import 'home_page.dart';

class SlotData extends ChangeNotifier {
  int totalSlots;
  int availableSlots;

  SlotData({required this.totalSlots, required this.availableSlots});

  void updateData({required int totalSlots, required int availableSlots}) {
    this.totalSlots = totalSlots;
    this.availableSlots = availableSlots;
    notifyListeners(); // Notify listeners when the data changes
  }
}

class GymPageDate extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final gymDetails gymDetail;

  GymPageDate({super.key, required this.gymDetail});

  @override
  _GymPageDateState createState() => _GymPageDateState();
}

class _GymPageDateState extends State<GymPageDate> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  int gymslot = 0;
  int total = 0;
  String selectedHour =
      '10:00 AM - 11:00 AM'; // Initialize with a default value

  List<String> hourOptions = [
    // '10', '20', '30'
    '10:00 AM - 11:00 AM',
    '11:00 AM - 12:00 PM', '12:00 PM - 1:00 PM',
    '1:00 PM - 2:00 PM', '2:00 PM - 3:00 PM', '3:00 PM - 4:00 PM',
    '4:00 PM - 5:00 PM', '5:00 PM - 6:00 PM',
    '6:00 PM - 7:00 PM', '7:00 PM - 9:00 PM' // Add more options as needed
  ];

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

  void slotpop() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text(
          "Sorry for inconvenience cause to you !!                  Current slots are full .please select other slots"),
      backgroundColor: Colors.red, // Set a custom background color for error
    ));
  }

  void ontap() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BuyServicePlanPage(),
        ));
  }

  Future<void> submitGymData(String gymName, String location, String date,
      String time, String userId) async {
    print(userId);
    // http.Response response = await http.post(
    //   Uri.parse('${Constant.url}/addDailyGym'),
    //   body: jsonEncode({
    //     'userId': '643fdb3dfc3bbedc148838ce',
    //     'gymName': gymName,
    //     'location': location,
    //     'date': date,
    //     'time': time,
    //   }),
    //   headers: <String, String>{
    //     'Content-Type': 'application/json',
    //   },
    // );
    try {
      final response = await http
          .post(Uri.parse('${Constant.url}/schedule/addDailyGym'), body: {
        'userId': userId,
        'gymName': gymName,
        'location': location,
        'date': date,
        'time': time,
      });

      if (response.statusCode == 200) {
        print('Data saved successfully');
      } else {
        print(
            'An error occurred while saving the data (${response.statusCode})');
      }
    } catch (error) {
      print('An error occurred while sending the data: $error');
    }
  }

  Future<void> slotcheck(String date, String time, String gymname) async {
    EasyLoading.show(status: 'Checking Slots...');
    try {
      http.Response res = await http.post(
        Uri.parse('${Constant.url}/schedule/slotdata'),
        body: jsonEncode({
          'date': date,
          'time': time,
          'gymName': gymname,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      );
      if (res.statusCode == 200) {
        EasyLoading.showSuccess('slot fetched');
        EasyLoading.dismiss();
        final data = jsonDecode(res.body);
        print("Api called");
        setState(() {
          gymslot = data['slotBooked'];
          int available = total - gymslot;
        });
      } else {
        EasyLoading.dismiss();
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    final SlotData slotData = SlotData(totalSlots: 100, availableSlots: 50);
    String date = DateFormat.yMd().format(selectedDate);
    String time = selectedHour;
    total = int.parse(widget.gymDetail.capacity);
    int available = total - gymslot;

    double latitude = widget.gymDetail.latitude;
    double longitude = widget.gymDetail.longitude;

    print(latitude);
    print(longitude);

    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(
        children: [
          Container(
            height: 600,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(widget.gymDetail.image),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  bottom: 93,
                  left: 30,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            widget.gymDetail.gymName,
                            style: TextStyle(
                              fontSize: 39,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.start,
                      //   children: <Widget>[
                      //     Icon(Icons.location_on,
                      //         size: 20, color: Colors.white),
                      //     SizedBox(width: 5),
                      //     Text(
                      //       widget.gymDetail.location,
                      //       style: TextStyle(
                      //         fontSize: 20,
                      //         color: Colors.white,
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      GestureDetector(
                        onTap: () {
                          // Navigate to the next page
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MapPage(
                                latitude: widget.gymDetail.latitude,
                                longitude: widget.gymDetail.longitude,
                              ),
                            ),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Icon(Icons.location_on,
                                size: 20, color: Colors.white),
                            SizedBox(width: 5),
                            Text(
                              widget.gymDetail.location,
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
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
                        InkWell(
                          onTap: () => _selectDate(context),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.calendar_today),
                              SizedBox(height: 5),
                              Text(
                                DateFormat.yMd().format(selectedDate),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Column(
                            children: [
                              DropdownButton<String>(
                                value: selectedHour,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedHour = newValue!;
                                    slotcheck(date, selectedHour,
                                        widget.gymDetail.gymName);
                                  });
                                },
                                items: hourOptions
                                    .map<DropdownMenuItem<String>>(
                                        (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                              Text(
                                'Select slots',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                ),
                              ),
                            ],
                          ),
                        ),
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
              ],
            ),
          ),
          // Spacer(),
          SizedBox(height: 11),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Container(
                width: 360,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(21),
                      topRight: Radius.circular(21),
                      bottomLeft: Radius.circular(21),
                      bottomRight: Radius.circular(21)),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Expanded(
                      //   child: Center(
                      //     child: Text(
                      //       "Easy, reliable way to take care of your health",
                      //       textAlign: TextAlign.center,
                      //       softWrap:
                      //           true, // enable text to wrap to the next line if it exceeds the container width
                      //       overflow: TextOverflow.visible,
                      //       style: TextStyle(
                      //           fontSize: 21, fontWeight: FontWeight.bold),
                      //     ),
                      //   ),
                      // ),
                      // Add SlotCounter to display the available slots
                      AnimatedBuilder(
                          animation: slotData,
                          builder: (context, child) {
                            return Center(
                              child: DefaultTextStyle(
                                style: TextStyle(
                                  fontSize: 36,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      'Available Slots',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          '${available}',
                                          style: TextStyle(
                                            fontSize: 36,
                                            color: available == 0
                                                ? Colors.red
                                                : Color.fromARGB(
                                                    244, 57, 255, 7),
                                          ),
                                        ),
                                        Text(
                                          ' / ${total}',
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          })
                    ],
                  ),
                ),
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Center(
              child: ElevatedButton(
                onPressed: available > 0
                    ? () async {
                        final prefs = await SharedPreferences.getInstance();
                        String userEmail = prefs.getString('email')!;
                        String check = prefs.getString('doesSubs')!;

                        // print(userId);
                        // print(gymName);
                        // print(location);
                        // print(date);
                        // print(time);
                        DailyGym dailyGym = DailyGym();
                        if (check == "Yes") {
                          dailyGym.Dailygym(
                              context: context,
                              ownerEmail: widget.gymDetail.ownerEmail,
                              userEmail: userEmail,
                              image: widget.gymDetail.image,
                              gymName: widget.gymDetail.gymName,
                              location: widget.gymDetail.location,
                              date: date,
                              time: time);
                        } else {
                          msgPop(
                              context,
                              'No Subscription',
                              "Plese avail our subscription for services",
                              DialogType.error,
                              ontap,
                              "Buy Here");
                        }
                      }
                    : () {
                        slotpop();
                      } // New password is empty or less than 8 characters
                ,
                child: Text(
                  'Submit',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(21.0),
                  ),
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                  minimumSize: Size(390, 50),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
