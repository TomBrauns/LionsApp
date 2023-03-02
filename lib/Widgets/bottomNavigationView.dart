import 'package:flutter/material.dart';
import 'package:lionsapp/Widgets/privileges.dart';
import 'package:lionsapp/util/color.dart';
import 'package:lionsapp/Widgets/burgermenu.dart';

import 'burgermenu.dart';

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
            Tooltip(
              message: "User Verwaltung",
              decoration: const BoxDecoration(color: Colors.blue),
              child: IconButton(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                onPressed: () {
                  // Update State of App
                  Navigator.pop(context);
                  // Push to Screen
                  AppData.selected = 2;

                  Navigator.pushNamed(context, '/User');
                },
                icon: const Icon(Icons.badge, color: Colors.white),
              ),
            ),
            Tooltip(
              message: "Chat",
              decoration: const BoxDecoration(color: Colors.blue),
              child: IconButton(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                onPressed: () {
                  // Update State of App
                  Navigator.pop(context);
                  // Push to Screen
                  AppData.selected = 6;

                  Navigator.pushNamed(context, '/Chat');
                },
                icon: const Icon(Icons.chat, color: Colors.white),
              ),
            ),
            if (Privileges.privilege == "Admin" ||
                Privileges.privilege == "Member")
              Tooltip(
                message: "Kalender",
                decoration: const BoxDecoration(color: Colors.blue),
                child: IconButton(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  onPressed: () {
                    // Update State of App
                    Navigator.pop(context);
                    // Push to Screen

                    AppData.selected = 3;

                    Navigator.pushNamed(context, '/Calendar');
                  },
                  icon: const Icon(Icons.calendar_month_rounded, color: Colors.white),
                ),
              ),
            Tooltip(
              message: "Katalog",
              decoration: const BoxDecoration(color: Colors.blue),
              child: IconButton(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                onPressed: () {
                  // Update State of App
                  Navigator.pop(context);
                  // Push to Screen

                  AppData.selected = 5;

                  Navigator.pushNamed(context, '/Catalogue');
                },
                icon: const Icon(Icons.book, color: Colors.white),
              ),
            ),
            Tooltip(
              message: "Aktivitäten",
              decoration: const BoxDecoration(color: Colors.blue),
              child: IconButton(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                onPressed: () {
                  // Update State of App
                  Navigator.pop(context);
                  // Push to Screen

                  AppData.selected = 4;

                  Navigator.pushNamed(context, '/Events');
                },
                icon: const Icon(Icons.event, color: Colors.white),
              ),
            ),

          ],
        ));
  }
}

//Rejecta macht gute Musik,
//Und der D-Sturb auch
//Jetzt nur noch ein bisschen Refactoring und dann steht dat Ding
