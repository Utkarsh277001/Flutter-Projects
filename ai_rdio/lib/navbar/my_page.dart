import 'package:ai_rdio/navbar/payscreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screen/RegLoginUi.dart';
import '../screen/user-choice.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Set to false if user doesn't have a subscription
  String isSubs = 'Yes';
  String name = '';
  String email = '';
  String pic = '';
  String buyDate = '';
  String endDate = '';
  var gender = '';
  String age = '0';

  @override
  void initState() {
    super.initState();
    _getUserData();
  }
  // void initState() {
  //   super.initState();
  //   setState(() {
  //     _getUserData();
  //   });
  // }

  Future<void> _getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      isSubs = prefs.getString('doesSubs') ?? 'No';
      name = prefs.getString('name') ?? '';
      gender = prefs.getString('gender') ?? '';
      age = prefs.getString('age') ?? '';
      email = prefs.getString('email') ?? '';
      buyDate = prefs.getString('sDate') ?? '';
      endDate = prefs.getString('eDate') ?? '';
      print(name);
      print(email);
      if (gender == 'male') {
        pic = 'male-dp.png';
      }
      if (gender == 'female') {
        pic = 'female-dp.png';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (gender == 'male') {
      pic = 'male-dp.png';
    }
    if (gender == 'female') {
      pic = 'female-dp.png';
    }
    print(name);
    print(age);
    print(gender);
    print(email);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'My Profile',
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
              SizedBox(height: 9),
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage('assets/images/$pic'),
                  ),
                ),
              ),
              SizedBox(height: 12),
              Center(
                child: Text(
                  '$name',
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              SizedBox(height: 5),
              Center(
                child: Text(
                  '$email',
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
              ),
              SizedBox(height: 21),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 11),
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
                child: Row(
                  children: [
                    Icon(Icons.person, color: Colors.black),
                    SizedBox(width: 21),
                    Text(
                      '$gender',
                      style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 21),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 11),
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
                child: Row(
                  children: [
                    Icon(Icons.cake, color: Colors.black),
                    SizedBox(width: 21),
                    Text(
                      '$age years old',
                      style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 32),
              isSubs == 'Yes'
                  ? SubscriptionDetails(sDate: buyDate, eDate: endDate)
                  : BuySubscription(),
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
                      print("logout");
                      // TODO: Implement logout functionality
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

class SubscriptionDetails extends StatefulWidget {
  const SubscriptionDetails({key, required this.sDate, required this.eDate});

  final String sDate;
  final String eDate;

  @override
  State<SubscriptionDetails> createState() => _SubscriptionDetailsState();
}

class _SubscriptionDetailsState extends State<SubscriptionDetails> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
                'Active subscription',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Icon(Icons.calendar_today, color: Colors.black),
              SizedBox(width: 12),
              Text(
                'Buy date:' + widget.sDate,
                style: TextStyle(fontSize: 14, color: Colors.grey[700]),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.calendar_today, color: Colors.black),
              SizedBox(width: 12),
              Text(
                'Expire date:' + widget.eDate,
                style: TextStyle(fontSize: 14, color: Colors.grey[700]),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BuySubscription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
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
              SizedBox(width: 12),
              Text(
                'No active subscription',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ],
          ),
          SizedBox(height: 16),
          Text(
            'To access premium features, please purchase a subscription.',
            style: TextStyle(fontSize: 14, color: Colors.grey[700]),
          ),
          SizedBox(height: 16),
          Align(
            alignment: Alignment.center,
            child: ElevatedButton(
                onPressed: () {
                  // TODO: Implement purchase subscription functionality

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BuyServicePlanPage()),
                  );
                },
                child: Text('Buy',
                    style: TextStyle(fontSize: 18, color: Colors.white)),
                // style: ElevatedButton.styleFrom(primary: Colors.black),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(21.0),
                  ),
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
                  minimumSize: Size(120, 20),
                )),
          ),
        ],
      ),
    );
  }
}
