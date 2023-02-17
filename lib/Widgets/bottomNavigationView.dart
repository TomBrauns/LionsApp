import 'package:flutter/material.dart';
import 'package:lionsapp/Screens/calendar.dart';
import 'package:lionsapp/Screens/projects/catalogue.dart';
import 'package:lionsapp/Screens/chat.dart';
import 'package:lionsapp/Screens/donation.dart';
import 'package:lionsapp/Screens/user_configs.dart';

class BottomNavigation extends StatefulWidget {
  final String currentPage;

  const BottomNavigation({Key? key, required this.currentPage})
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
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            widget.currentPage == "Catalogue"
                ? const Padding(
                    padding: EdgeInsets.only(left: 90),
                  )
                : const SizedBox(),
            widget.currentPage == "User"
                ? const SizedBox.shrink()
                : IconButton(
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
            widget.currentPage == "Donations"
                ? const SizedBox.shrink()
                : IconButton(
                    onPressed: () {
                      // Update State of App
                      Navigator.pop(context);
                      // Push to Screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Donations()),
                      );
                    },
                    icon: const Icon(Icons.card_giftcard),
                  ),
            widget.currentPage == "Chat"
                ? const SizedBox.shrink()
                : IconButton(
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
            widget.currentPage == "Calendar"
                ? const SizedBox.shrink()
                : IconButton(
                    onPressed: () {
                      // Update State of App
                      Navigator.pop(context);
                      // Push to Screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Calendar()),
                      );
                    },
                    icon: const Icon(Icons.event),
                  ),
            widget.currentPage == "Catalogue"
                ? const SizedBox.shrink()
                : IconButton(
                    onPressed: () {
                      // Update State of App
                      Navigator.pop(context);
                      // Push to Screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Catalogue()),
                      );
                    },
                    icon: const Icon(Icons.book),
                  ),
          ],
        ));
  }
}
