import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lionsapp/Screens/calendar.dart';
import 'package:lionsapp/Screens/projects/catalogue.dart';
import 'package:lionsapp/Screens/chat.dart';
import 'package:lionsapp/Screens/donation.dart';
import 'package:lionsapp/Screens/user_configs.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  String ActionButton = "Catalogue";
  void bottomappbar_index(int _chosenindex) {
    switch (_chosenindex) {
      case 1:
        String ActionButton = "User";
        break;
      case 2:
        String ActionButton = "Donation";
        break;
      case 3:
        String ActionButton = "Chat";
        break;
      case 4:
        String ActionButton = "Calendar";
        break;
      case 5:
        String ActionButton = "Catalogue";
        break;
    }
  }

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
            IconButton(
              onPressed: () {
                bottomappbar_index(1);
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
                bottomappbar_index(2);
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
                bottomappbar_index(3);
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
                bottomappbar_index(4);
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
                bottomappbar_index(5);
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
