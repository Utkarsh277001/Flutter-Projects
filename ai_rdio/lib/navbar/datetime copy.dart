import 'package:ai_rdio/navbar/payscreen.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:ai_rdio/Services/dailyGym.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../Utils/Constant.dart';
import '../Utils/Dialog.dart';
import 'gym-seach.dart';
import 'home_page.dart';

class GymPageDate3 extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final gymData gymDetail;

  GymPageDate3({super.key, required this.gymDetail});

  @override
  _GymPageDateState createState() => _GymPageDateState();
}

class _GymPageDateState extends State<GymPageDate3> {
  var name = {
    'Gym-1.jpg': {'name': "Fitness Zone", 'address': 'Jalandhar , Punjab'},
    'Gym-2.jpg': {'name': "Muscle Mansion", 'address': 'Chandigarh'},
    'Gym-3.jpg': {
      'name': "Health Heaven",
      'address': 'Hamirpur, Himachal Pradesh'
    },
    'Gym-4.jpg': {'name': "Fit Elite Gym", 'address': 'Patna , Bihar'},
    'Gym-5.jpg': {'name': "Fitness Fusion", 'address': 'Dehradun , Uttrakhand'},
    'Gym-6.jpg': {'name': "Fitness Club", 'address': 'Kapurthala , Punjab'},
    'Gym-7.jpg': {'name': "Anytime Fitness", 'address': 'Vasai , Mumbai'},
  };
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

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

  @override
  Widget build(BuildContext context) {
    String date = DateFormat.yMd().format(selectedDate);
    String time = selectedTime.format(context);

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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Icon(Icons.location_on,
                              size: 20, color: Colors.white),
                          SizedBox(width: 5),
                          Text(
                            widget.gymDetail.location,
                            // widget.gymDetail.coordinates,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ],
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
                        InkWell(
                          onTap: () => _selectTime(context),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.access_time),
                              SizedBox(height: 5),
                              Text(
                                selectedTime.format(context),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                ),
                              ),
                            ],
                          ),
                        ),
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
                  padding: EdgeInsets.all(11.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Center(
                            child: Text(
                              "Easy, reliable way to take care of you health",
                              textAlign: TextAlign.center,
                              softWrap:
                                  true, //enable text to wrap to next line if it exceeds the container width
                              overflow: TextOverflow.visible,
                              style: TextStyle(
                                  fontSize: 21, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ]),
                ),
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Center(
              child: ElevatedButton(
                onPressed: () async {
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
                },
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
