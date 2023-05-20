import 'package:ai_rdio/navbar/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:ai_rdio/navbar/chat_screen.dart';
import 'package:ai_rdio/navbar/search_page.dart';
import 'package:velocity_x/velocity_x.dart';

import '../Exercise/started.dart';
import 'ownerhistory.dart';
import 'ownerhome.dart';
import 'ownerprofile.dart';
// import 'chat_screen.dart';

class OwnerMainPage extends StatefulWidget {
  const OwnerMainPage({super.key});

  @override
  State<OwnerMainPage> createState() => _OwnerMainPageState();
}

class _OwnerMainPageState extends State<OwnerMainPage> {
  List pages = [
    AdminHomePage(),
    OwnerHistoryPage(),
    // GetStarted(),
    OwnerProfilePage(),
  ];
  int currentIndex = 0;
  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          unselectedFontSize: 0,
          selectedFontSize: 0,
          type: BottomNavigationBarType.shifting,
          onTap: onTap,
          currentIndex: currentIndex,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey.withOpacity(0.5),
          showUnselectedLabels: false,
          showSelectedLabels: false,
          elevation: 0,
          items: [
            BottomNavigationBarItem(label: "Home", icon: Icon(Icons.home)),
            BottomNavigationBarItem(label: "Bar", icon: Icon(Icons.history)),
            // BottomNavigationBarItem(label: "Search", icon: Icon(Icons.explore)),
            BottomNavigationBarItem(label: "My", icon: Icon(Icons.person)),
          ]),
    );
  }
}
