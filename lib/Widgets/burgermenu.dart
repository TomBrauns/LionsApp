import 'package:flutter/material.dart';
import 'package:lionsapp/Screens/receipt.dart';
import 'package:lionsapp/main.dart';

import '../Screens/calendar.dart';
import '../Screens/catalogue.dart';
import '../Screens/chat.dart';
import '../Screens/contact.dart';
import '../Screens/donation.dart';
import '../Screens/imprint.dart';
import '../Screens/user.dart';

// Test Value
String privilege = "Member";
//

class BurgerMenu extends StatefulWidget {
  const BurgerMenu({Key? key}) : super(key: key);

  @override
  State<BurgerMenu> createState() => _BurgerMenuState();
}

class _BurgerMenuState extends State<BurgerMenu> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text("Drawer Header"),
          ),
          ListTile(
            title: const Text('Startseite'),
            onTap: () {
              // Update State of App
              Navigator.pop(context);
              // Push to Screen
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const MyHomePage(title: "My Home Page")),
              );
            },
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
                      MaterialPageRoute(builder: (context) => const User()),
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
          ListTile(
            title: const Text('>>Quittung<< Temporär'),
            onTap: () {
              // Update State of App
              Navigator.pop(context);
              // Push to Screen
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const DonationRecieved()),
              );
            },
          ),
        ],
      ),
    );
  }
}
