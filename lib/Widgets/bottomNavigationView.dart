import 'package:flutter/cupertino.dart';
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
        shape: CircularNotchedRectangle(), //shape of notch
        notchMargin: 5,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            widget.currentPage == "Catalogue"
                ? Padding(
                    padding: EdgeInsets.only(left: 90),
                  )
                : SizedBox(),
            IconButton(
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
            // ActionButton == "User"
            //     ? FloatingActionButton(
            //         onPressed: () {},
            //         backgroundColor: Colors.green,
            //         child: const Icon(Icons.navigation),
            //       )
            //     : Container(),
            // ActionButton == "Donations"
            //     ? FloatingActionButton(
            //         onPressed: () {},
            //         backgroundColor: Colors.green,
            //         child: const Icon(Icons.navigation),
            //       )
            //     : Container(),
            // ActionButton == "Chat"
            //     ? FloatingActionButton(
            //         onPressed: () {},
            //         backgroundColor: Colors.green,
            //         child: const Icon(Icons.navigation),
            //       )
            //     : Container(),
            // ActionButton == "Calendar"
            //     ? FloatingActionButton(
            //         onPressed: () {},
            //         backgroundColor: Colors.green,
            //         child: const Icon(Icons.navigation),
            //       )
            //     : Container(),
            // ActionButton == "Catalogue"
            //     ? FloatingActionButton(
            //         onPressed: () {},
            //         backgroundColor: Colors.green,
            //         child: const Icon(Icons.navigation),
            //       )
            //     : Container(),
          ],
        ));
  }
}
