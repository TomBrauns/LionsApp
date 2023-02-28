import 'package:flutter/material.dart';
import 'package:lionsapp/Widgets/privileges.dart';
import 'package:lionsapp/util/color.dart';

class BottomNavigation extends StatefulWidget {
  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
        color: ColorUtils.primaryColor,
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

                Navigator.pushNamed(context, '/User');
              },
              icon: const Icon(Icons.badge, color: Colors.white),
            ),
            IconButton(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              onPressed: () {
                // Update State of App
                Navigator.pop(context);
                // Push to Screen

                Navigator.pushNamed(context, '/Donations');
              },
              icon: const Icon(Icons.card_giftcard, color: Colors.white),
            ),
            if (Privileges.privilege == "Admin" ||
                Privileges.privilege == "Member")
              IconButton(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                onPressed: () {
                  // Update State of App
                  Navigator.pop(context);
                  // Push to Screen

                  Navigator.pushNamed(context, '/Chat');
                },
                icon: const Icon(Icons.chat, color: Colors.white),
              ),
            if (Privileges.privilege == "Admin" ||
                Privileges.privilege == "Member")
              IconButton(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                onPressed: () {
                  // Update State of App
                  Navigator.pop(context);
                  // Push to Screen

                  Navigator.pushNamed(context, '/Calendar');
                },
                icon: const Icon(Icons.calendar_month_rounded, color: Colors.white),
              ),
            IconButton(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              onPressed: () {
                // Update State of App
                Navigator.pop(context);
                // Push to Screen

                Navigator.pushNamed(context, '/Catalogue');
              },
              icon: const Icon(Icons.book, color: Colors.white),
            ),
            IconButton(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              onPressed: () {
                // Update State of App
                Navigator.pop(context);
                // Push to Screen

                Navigator.pushNamed(context, '/Events');
              },
              icon: const Icon(Icons.event, color: Colors.white),
            ),
          ],
        ));
  }
}
