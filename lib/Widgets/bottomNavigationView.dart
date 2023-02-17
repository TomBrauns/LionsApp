import 'package:flutter/material.dart';
import 'package:lionsapp/Screens/calendar.dart';
import 'package:lionsapp/Screens/projects/catalogue.dart';
import 'package:lionsapp/Screens/chat.dart';
import 'package:lionsapp/Screens/donation.dart';
import 'package:lionsapp/Screens/user_configs.dart';

class BottomNavigation extends StatefulWidget {
  final String currentPage;
  final String privilege;

  const BottomNavigation(
      {Key? key, required this.currentPage, required this.privilege})
      : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
        color: Colors.blueAccent,
        shape: const CircularNotchedRectangle(), //shape of notch
        notchMargin: 5,
        elevation: 0,
        height: 80,
        clipBehavior: Clip.none,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              onPressed: () {
                // Update State of App
                Navigator.pop(context);
                // Push to Screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const User()),
                );
              },
              icon: const Icon(Icons.badge),
            ),
            IconButton(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              onPressed: () {
                // Update State of App
                Navigator.pop(context);
                // Push to Screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Donations()),
                );
              },
              icon: const Icon(Icons.card_giftcard),
            ),
            IconButton(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              onPressed: () {
                // Update State of App
                Navigator.pop(context);
                // Push to Screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Chat()),
                );
              },
              icon: const Icon(Icons.chat),
            ),
            IconButton(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              onPressed: () {
                // Update State of App
                Navigator.pop(context);
                // Push to Screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Calendar()),
                );
              },
              icon: const Icon(Icons.event),
            ),
            IconButton(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              onPressed: () {
                // Update State of App
                Navigator.pop(context);
                // Push to Screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Catalogue()),
                );
              },
              icon: const Icon(Icons.book),
            ),
          ],
        ));
  }
}
