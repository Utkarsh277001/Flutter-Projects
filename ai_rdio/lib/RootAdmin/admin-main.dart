import 'package:ai_rdio/RootAdmin/admin-profile.dart';
import 'package:ai_rdio/navbar/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:ai_rdio/navbar/chat_screen.dart';
import 'package:ai_rdio/navbar/search_page.dart';
import 'package:velocity_x/velocity_x.dart';

import '../Exercise/started.dart';

// import 'chat_screen.dart';
import 'admin-home.dart';

class SuperAdminMainPage extends StatefulWidget {
  const SuperAdminMainPage({super.key});

  @override
  State<SuperAdminMainPage> createState() => _SuperAdminMainPageState();
}

class _SuperAdminMainPageState extends State<SuperAdminMainPage> {
  List pages = [
    SuperAdminHomePage(),
    AdminProfilePage()
    // AdminHomePage(),
    // OwnerHistoryPage(),
    // GetStarted(),
    // OwnerProfilePage(),
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
            BottomNavigationBarItem(label: "Bar", icon: Icon(Icons.person)),
            // BottomNavigationBarItem(label: "Search", icon: Icon(Icons.explore)),
            // BottomNavigationBarItem(label: "My", icon: Icon(Icons.person)),
          ]),
    );
  }
}
