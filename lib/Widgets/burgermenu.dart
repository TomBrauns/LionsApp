import 'package:flutter/material.dart';
import 'package:lionsapp/Screens/create_event.dart';
import 'package:lionsapp/Screens/receipt.dart';
import 'package:lionsapp/main.dart';

import '../Screens/calendar.dart';
import '../Screens/catalogue.dart';
import '../Screens/chat.dart';
import '../Screens/contact.dart';
import '../Screens/donation.dart';
import '../Screens/imprint.dart';
import '../Screens/user.dart';
import '../Screens/events.dart';

class BurgerMenu extends StatefulWidget {
  const BurgerMenu({Key? key}) : super(key: key);

  @override
  State<BurgerMenu> createState() => _BurgerMenuState();
}

class _BurgerMenuState extends State<BurgerMenu> {
  // Test Value
  String privilege = "Member";
  //
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 29, 89, 167),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: const [
                  Text(
                    "Lions App",
                    textScaleFactor: 1.3,
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            title: const Text('Spenden'),
            onTap: () {
              // Update State of App
              Navigator.pop(context);
              // Push to Screen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Donations()),
              );
            },
          ),
          privilege == "Member" || privilege == "Friend"
              ? ListTile(
                  title: const Text('Benutzer'),
                  onTap: () {
                    // Update State of App
                    Navigator.pop(context);
                    // Push to Screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => User()),
                    );
                  },
                )
              : Container(),
          privilege == "Member" || privilege == "Friend"
              ? ListTile(
                  title: const Text('Kalender'),
                  onTap: () {
                    // Update State of App
                    Navigator.pop(context);
                    // Push to Screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Calendar()),
                    );
                  },
                )
              : Container(),
          privilege == "Member" || privilege == "Friend"
              ? ListTile(
                  title: const Text('Events'),
                  onTap: () {
                    // Update State of App
                    Navigator.pop(context);
                    // Push to Screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Events()),
                    );
                  },
                )
              : Container(),
          privilege == "Member" || privilege == "Friend"
              ? ListTile(
                  title: const Text('Katalog'),
                  onTap: () {
                    // Update State of App
                    Navigator.pop(context);
                    // Push to Screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Catalogue()),
                    );
                  },
                )
              : Container(),
          privilege == "Member"
              ? ListTile(
                  title: const Text('Chat'),
                  onTap: () {
                    // Update State of App
                    Navigator.pop(context);
                    // Push to Screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Chat()),
                    );
                  },
                )
              : Container(),
          privilege == "Member"
              ? ListTile(
            title: const Text('Event erstellen'),
            onTap: () {
              // Update State of App
              Navigator.pop(context);
              // Push to Screen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CreateEvent()),
              );
            },
          )
              : Container(),
          ListTile(
            title: const Text('Kontakt'),
            onTap: () {
              // Update State of App
              Navigator.pop(context);
              // Push to Screen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Contact()),
              );
            },
          ),
          ListTile(
            title: const Text('Impressum'),
            onTap: () {
              // Update State of App
              Navigator.pop(context);
              // Push to Screen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Imprint()),
              );
            },
          ),
        ],
      ),
    );
  }
}
