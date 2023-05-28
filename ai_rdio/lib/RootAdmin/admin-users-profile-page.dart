// import 'package:flutter/material.dart';

// import 'admin-userlist.dart';

// class UserDetailsPage extends StatelessWidget {
//   final User user;

//   const UserDetailsPage({required this.user});

//   @override
//   Widget build(BuildContext context) {
//     // return Scaffold(
//     //   appBar: AppBar(
//     //     title: Text(user.name),
//     //   ),
//     //   body: Center(
//     //     child: Column(
//     //       mainAxisAlignment: MainAxisAlignment.center,
//     //       children: [
//     //         CircleAvatar(
//     //           backgroundImage: _getProfileImageByGender(user.gender),
//     //           radius: 50,
//     //         ),
//     //         SizedBox(height: 20),
//     //         Text('Name: ${user.name}'),
//     //         SizedBox(height: 10),
//     //         Text('Email: ${user.email}'),
//     //         SizedBox(height: 10),
//     //         Text('Age: ${user.age} years'),
//     //       ],
//     //     ),
//     //   ),
//     // );
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: Text(
//           'My Profile',
//         ),
//         backgroundColor: Colors.white,
//         elevation: 0,
//         iconTheme: IconThemeData(color: Colors.black),
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
//           child: Column(
//             children: [
//               SizedBox(height: 11),
//               Center(
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: Colors.grey[200],
//                     borderRadius: BorderRadius.circular(100),
//                   ),
//                   child: CircleAvatar(
//                     radius: 60,
//                     backgroundImage: _getProfileImageByGender(user.gender),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 18),
//               Center(
//                 child: Text(
//                   '${user.name}',
//                   style: TextStyle(
//                       fontSize: 28,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black),
//                 ),
//               ),
//               SizedBox(height: 7),
//               Center(
//                 child: Text(
//                   '${user.email}',
//                   style: TextStyle(fontSize: 16, color: Colors.grey[600]),
//                 ),
//               ),
//               SizedBox(height: 30),
//               Container(
//                 padding: EdgeInsets.symmetric(horizontal: 16, vertical: 11),
//                 decoration: BoxDecoration(
//                   color: Color.fromARGB(255, 247, 246, 246),
//                   borderRadius: BorderRadius.circular(21),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.5),
//                       spreadRadius: 1,
//                       blurRadius: 7,
//                       offset: Offset(0, 3), // changes position of shadow
//                     ),
//                   ],
//                 ),
//                 child: Row(
//                   children: [
//                     Icon(Icons.person, color: Colors.black),
//                     SizedBox(width: 21),
//                     Text(
//                       '${user.gender}',
//                       style: TextStyle(fontSize: 18, color: Colors.grey[700]),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 21),
//               Container(
//                 padding: EdgeInsets.symmetric(horizontal: 16, vertical: 11),
//                 decoration: BoxDecoration(
//                   color: Color.fromARGB(255, 247, 246, 246),
//                   borderRadius: BorderRadius.circular(21),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.5),
//                       spreadRadius: 1,
//                       blurRadius: 7,
//                       offset: Offset(0, 3), // changes position of shadow
//                     ),
//                   ],
//                 ),
//                 child: Row(
//                   children: [
//                     Icon(Icons.cake, color: Colors.black),
//                     SizedBox(width: 21),
//                     Text(
//                       '${user.age} years old',
//                       style: TextStyle(fontSize: 18, color: Colors.grey[700]),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 32),
//               // isSubs == 'Yes'
//               //     ? SubscriptionDetails(sDate: buyDate, eDate: endDate)
//               //     : BuySubscription(),
//               // SizedBox(height: 32),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   AssetImage _getProfileImageByGender(String gender) {
//     return gender == 'male'
//         ? AssetImage('assets/images/male-dp.png')
//         : AssetImage('assets/images/female-dp.png');
//   }
// }

import 'package:flutter/material.dart';
import '../navbar/payscreen.dart';
import 'admin-userlist.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class UserDetailsPage extends StatefulWidget {
  final User user;

  const UserDetailsPage({Key? key, required this.user}) : super(key: key);

  @override
  _UserDetailsPageState createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  bool isSubs = false;
  String buyDate = '';
  String endDate = '';

  @override
  void initState() {
    super.initState();
    // Call API to get subscription data
    _fetchSubscriptionData();
  }

  void _fetchSubscriptionData() async {
    // Make HTTP request to backend server
    var response = await http.get(Uri.parse(
        'https://your-backend-server.com/subscription/${widget.user.id}'));
    // Check if request was successful
    if (response.statusCode == 200) {
      // Parse response data
      var subscriptionData = json.decode(response.body);
      // Check if subscription data is available
      if (subscriptionData['hasSubscription']) {
        setState(() {
          isSubs = true;
          buyDate = subscriptionData['startDate'];
          endDate = subscriptionData['endDate'];
        });
      }
    } else {
      print('Failed to fetch subscription data');
    }
  }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text(user.name),
    //   ),
    //   body: Center(
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: [
    //         CircleAvatar(
    //           backgroundImage: _getProfileImageByGender(user.gender),
    //           radius: 50,
    //         ),
    //         SizedBox(height: 20),
    //         Text('Name: ${user.name}'),
    //         SizedBox(height: 10),
    //         Text('Email: ${user.email}'),
    //         SizedBox(height: 10),
    //         Text('Age: ${user.age} years'),
    //       ],
    //     ),
    //   ),
    // );
    // var user;
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
              SizedBox(height: 11),
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage:
                        _getProfileImageByGender(widget.user.gender),
                  ),
                ),
              ),
              SizedBox(height: 18),
              Center(
                child: Text(
                  '${widget.user.name}',
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              SizedBox(height: 7),
              Center(
                child: Text(
                  '${widget.user.email}',
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
              ),
              SizedBox(height: 30),
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
                      '${widget.user.gender}',
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
                      '${widget.user.age} years old',
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
            ],
          ),
        ),
      ),
    );
  }

  AssetImage _getProfileImageByGender(String gender) {
    return gender == 'male'
        ? AssetImage('assets/images/male-dp.png')
        : AssetImage('assets/images/female-dp.png');
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
