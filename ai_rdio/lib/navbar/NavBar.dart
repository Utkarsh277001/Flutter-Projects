import 'package:ai_rdio/RootAdmin/orderView.dart';
import 'package:ai_rdio/fitsyncshop/screens/home/home_screen.dart';
import 'package:ai_rdio/fitsyncshop/screens/home/orderList.dart';
import 'package:ai_rdio/fitsyncshop/screens/home/orderScreen.dart';
import 'package:ai_rdio/navbar/chat_screen.dart';
import 'package:ai_rdio/navbar/gmap.dart';

import 'package:ai_rdio/navbar/payscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../RootAdmin/admin-home.dart';
import '../RootAdmin/admin-main.dart';
import '../screen/RegLoginUi.dart';
import '../screen/user-choice.dart';
import 'about.dart';
import 'chat_screen.dart';
import 'history.dart';
// import 'otp_verification.dart';

class NavBar extends StatefulWidget {
  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  String name = '';
  String email = '';
  String pic = '';
  String gender = '';
  var age = '0';

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  Future<void> _getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('name') ?? '';
      gender = prefs.getString('gender') ?? '';
      age = prefs.getString('age') ?? '';
      email = prefs.getString('email') ?? '';
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
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              '$name',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 21,
                  fontWeight: FontWeight.bold),
            ),
            accountEmail: Text(
              '$email',
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.asset(
                  'assets/images/$pic',
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 248, 237, 237),
              // color: Color.fromARGB(132, 160, 104, 239),
              // image: DecorationImage(
              //   image: AssetImage(
              //     'assets/images/cover.jpg',
              //   ),
              //   fit: BoxFit.cover,
              //   opacity: 0.95,
              // )
            ),
          ),
          // ListTile(
          //   leading: Icon(Icons.favorite),
          //   title: Text('Favorite'),
          //   onTap: () => print('Fav'),
          // ),
          ListTile(
            leading: Icon(Icons.history),
            title: Text('History'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HistoryPage()),
              );
              print("history");
            },
          ),
          // ListTile(
          //   leading: Icon(Icons.data_object_rounded),
          //   title: Text('GymDetails'),
          //   onTap: () {
          //     // Navigator.push(
          //     //   context,
          //     //   MaterialPageRoute(builder: (context) => GymRegistrationPage()),
          //     // );
          //     print("history");
          //   },
          // ),
          ListTile(
            leading: Icon(Icons.money),
            title: Text('Subscription'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BuyServicePlanPage()),
              );
              print("share");
            },
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('About us'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutPage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('slot counter'),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => OrderList())
                  // SlotCounter(totalSlots: 120, availableSlots: 70)),
                  );
            },
          ),

          ListTile(
            leading: Icon(Icons.info),
            title: Text('FitsyncShop'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => orderScreen()),
              );
            },
          ),
          // ListTile(
          //   leading: Icon(Icons.people),
          //   title: Text('Chatbot'),
          //   // onTap: () => ChatScreen()
          //   onTap: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(builder: (context) => ChatScreen()),
          //     );
          //   },
          // ),
          // ListTile(
          //   leading: Icon(Icons.payment),
          //   title: Text('otp'),
          //   onTap: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(builder: (context) => OtpVerificationPage()),
          //     );
          //     print("share");
          //   },
          // ),
          // ListTile(
          //   leading: Icon(Icons.admin_panel_settings_sharp),
          //   title: Text('admin panel'),
          //   onTap: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(builder: (context) => SuperAdminMainPage()),
          //     );
          //   },
          // ),
          // ListTile(
          //   leading: Icon(Icons.settings),
          //   title: Text('Settings'),
          //   onTap: () async {
          //     final prefs = await SharedPreferences.getInstance();
          //     print(prefs.getString('id'));
          //     print(prefs.getString('email'));
          //     print(prefs.getString('name'));
          //     print(prefs.getString('age'));
          //     print(prefs.getString('gender'));
          //   },
          // ),

          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () async {
              final prefs = await SharedPreferences.getInstance();
              EasyLoading.dismiss();
              prefs.remove('id');
              prefs.remove('name');
              prefs.remove('email');
              prefs.remove('age');
              prefs.remove('gender');
              prefs.remove('doesSubs');
              prefs.remove('sDate');
              prefs.remove('eDate');
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => Userchoice()));
            },
          ),
          // ListTile(
          //   leading: Icon(Icons.info),
          //   title: Text('location-1'),
          //   onTap: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(builder: (context) => MapPage()),
          //     );
          //   },
          // ),
        ],
      ),
    );
  }
}
