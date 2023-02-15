import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lionsapp/Screens/calendar.dart';
import 'package:lionsapp/Screens/catalogue.dart';
import 'package:lionsapp/Screens/chat.dart';
import 'package:lionsapp/Screens/donation.dart';
import 'package:lionsapp/Screens/user_configs.dart';

// Overview for Members

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {

  int _currentIndex = 0;
  List _screens = [User(), Donations(), Chat(), Calendar(), Catalogue()];

  void _updateIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text("Bottom Navigation Bar"),
    ),
    body: _screens[_currentIndex],
    bottomNavigationBar: BottomNavigationBar(
    type: BottomNavigationBarType.fixed,
    currentIndex: _currentIndex,
    onTap: _updateIndex,
    backgroundColor: Colors.yellow,
    items: const <BottomNavigationBarItem>[
    BottomNavigationBarItem(
    icon: Icon(Icons.person, color: CupertinoColors.systemBlue),
    label: 'Benutzer',
    ),
    BottomNavigationBarItem(
    icon: Icon(Icons.card_giftcard,
    color: CupertinoColors.systemBlue),
    label: 'Spenden',
    ),
    BottomNavigationBarItem(
    icon: Icon(Icons.chat,
    color: CupertinoColors.systemBlue),
    label: 'Chats',
    ),
    BottomNavigationBarItem(
    icon: Icon(Icons.calendar_month,
    color: CupertinoColors.systemBlue),
    label: 'Kalender',
    ),
    BottomNavigationBarItem(
    icon: Icon(Icons.book_outlined,
    color: CupertinoColors.systemBlue),
    label: 'Katalog',
    ),
    ],
    ),
    );
  }
}