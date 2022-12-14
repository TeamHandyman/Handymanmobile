import 'package:flutter/material.dart';
import 'package:handyman/CustomerScreens/homenew.dart';
import 'package:handyman/Onboarding/login.dart';
import 'package:handyman/CustomerScreens/PostJob.dart';
import 'package:handyman/CustomerScreens/notifications.dart';
import 'package:handyman/CustomerScreens/home.dart';
import 'package:handyman/CustomerScreens/joblist.dart';
import 'package:handyman/CustomerScreens/profile.dart';

class Navigationscreen extends StatefulWidget {
  static const routeName = '/navigationscreen';

  @override
  State<Navigationscreen> createState() => _NavigationscreenState();
}

class _NavigationscreenState extends State<Navigationscreen> {
  List<Widget> _pages = [
    Homescreen(),
    JoblistScreen(),
    PostjobScreen(),
    NotificationScreen(),
    ProfileScreen(),
    ProfileScreen(),
  ];
  int _selectedPageIndex = 0;
  final controller = PageController(initialPage: 0);
  int currentPage = 0;

  static String name;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: _pages[_selectedPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: _selectPage,
        backgroundColor: Colors.black87,
        unselectedItemColor: Colors.white,
        currentIndex: _selectedPageIndex,
        items: [
          BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: Icon(
                Icons.home,
                // color: Colors.white,
                size: 22,
              ),
              label: 'Home',
              activeIcon: Icon(
                Icons.home,
                size: 22,
                color: Theme.of(context).buttonColor,
              )),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(
              Icons.schedule,
              color: Colors.white,
              size: 25,
            ),
            label: 'Home',
            activeIcon: Icon(
              Icons.schedule,
              color: Theme.of(context).buttonColor,
              size: 25,
            ),
          ),
          BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: Icon(
                Icons.add_box_rounded,
                color: Colors.white,
                size: 22,
              ),
              label: 'Home',
              activeIcon: Icon(
                Icons.add_box_rounded,
                color: Theme.of(context).buttonColor,
                size: 22,
              )),
          BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: Icon(
                Icons.notifications,
                color: Colors.white,
                size: 22,
              ),
              label: 'Home',
              activeIcon: Icon(
                Icons.notifications,
                color: Theme.of(context).buttonColor,
                size: 22,
              )),
          BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: Icon(
                Icons.person,
                color: Colors.white,
                size: 22,
              ),
              label: 'Home',
              activeIcon: Icon(
                Icons.person,
                color: Theme.of(context).buttonColor,
                size: 22,
              )),
        ],
      ),
    );
  }
}
