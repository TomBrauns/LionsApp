//Licensed under the EUPL v.1.2 or later
import 'package:flutter/material.dart';
import 'package:lionsapp/Widgets/privileges.dart';
import 'package:lionsapp/util/color.dart';
import 'package:lionsapp/Widgets/burgermenu.dart';

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
        notchMargin: 3,
        elevation: 0,
        height: 80,
        clipBehavior: Clip.none,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Tooltip(
                message: "User Verwaltung",
                decoration: const BoxDecoration(color: ColorUtils.primaryColor),
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
              if (Privileges.privilege == Privilege.admin ||
                  Privileges.privilege == Privilege.member)
                Tooltip(
                  message: "Chat",
                  decoration:
                      const BoxDecoration(color: ColorUtils.primaryColor),
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
              if (Privileges.privilege == Privilege.admin ||
                  Privileges.privilege == Privilege.member)
                Tooltip(
                  message: "Kalender",
                  decoration:
                      const BoxDecoration(color: ColorUtils.primaryColor),
                  child: IconButton(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    onPressed: () {
                      // Update State of App
                      Navigator.pop(context);
                      // Push to Screen
                      AppData.selected = 3;

                      Navigator.pushNamed(context, '/Calendar');
                    },
                    icon: const Icon(Icons.calendar_month_rounded,
                        color: Colors.white),
                  ),
                ),
              Tooltip(
                message: "Projekte",
                decoration: const BoxDecoration(color: ColorUtils.primaryColor),
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
                decoration: const BoxDecoration(color: ColorUtils.primaryColor),
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
          ),
        ));
  }
}
