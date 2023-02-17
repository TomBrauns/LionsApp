import 'package:flutter/material.dart';
import 'package:lionsapp/Screens/events/create_event.dart';

import 'package:lionsapp/Screens/calendar.dart';
import 'package:lionsapp/Screens/projects/catalogue.dart';
import 'package:lionsapp/Screens/chat.dart';
import 'package:lionsapp/Screens/contact.dart';
import 'package:lionsapp/Screens/donation.dart';
import 'package:lionsapp/Screens/imprint.dart';
import 'package:lionsapp/Screens/user/user_configs.dart';
import 'package:lionsapp/Screens/events/events_liste.dart';
import 'package:lionsapp/Screens/user_management.dart';
import 'package:lionsapp/Screens/contact_mailbox.dart';
import 'package:lionsapp/login/login.dart';
import 'package:lionsapp/login/register.dart';


class BurgerMenu extends StatefulWidget {
  const BurgerMenu({Key? key}) : super(key: key);
  static String privilege = "Friend";
  @override
  State<BurgerMenu> createState() => _BurgerMenuState();
}

class _BurgerMenuState extends State<BurgerMenu> {
  // Test Value
  //static const String privilege = "Friend";
  //
  @override
  Widget build(BuildContext context) {
    return Drawer(
        // Copy that Bar
        child: Scrollbar(
      thickness: 5.0,
      thumbVisibility: false,
      radius: const Radius.circular(360),
      child: ListView(
        //
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
                MaterialPageRoute(builder: (context) => Donations()),
              );
            },
          ),
          BurgerMenu.privilege == "Admin" ||
                  BurgerMenu.privilege == "Member" ||
                  BurgerMenu.privilege == "Friend"
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
          BurgerMenu.privilege == "Admin" ||
                  BurgerMenu.privilege == "Member" ||
                  BurgerMenu.privilege == "Friend"
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
          BurgerMenu.privilege == "Friend" ||
                  BurgerMenu.privilege == "Member" ||
                  BurgerMenu.privilege == "Admin"
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
          BurgerMenu.privilege == "Admin" ||
                  BurgerMenu.privilege == "Member" ||
                  BurgerMenu.privilege == "Friend"
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
          BurgerMenu.privilege == "Admin" || BurgerMenu.privilege == "Member"
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
          BurgerMenu.privilege == "Admin" || BurgerMenu.privilege == "Member"
              ? ListTile(
                  title: const Text('Event erstellen'),
                  onTap: () {
                    // Update State of App
                    Navigator.pop(context);
                    // Push to Screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CreateEvent()),
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
                
                //just rm const unten
                MaterialPageRoute(builder: (context) => Contact()),
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
            title: const Text('Registrierung'),
            onTap: () {
              // Update State of App
              Navigator.pop(context);
              // Push to Screen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Register()),
              );
            },
          ),
          ListTile(
            title: const Text('Login'),
            onTap: () {
              // Update State of App
              Navigator.pop(context);
              // Push to Screen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
          ),

          /// Following functions are for Admins only
          BurgerMenu.privilege == "Admin"
              ? ListTile(
                  title: const Text('Nutzerverwaltung'),
                  onTap: () {
                    // Update State of App
                    Navigator.pop(context);
                    // Push to Screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const UserManagement()),
                    );
                  },
                )
              : Container(),
          BurgerMenu.privilege == "Admin"
              ? ListTile(
                  title: const Text('Kontaktpostfach'),
                  onTap: () {
                    // Update State of App
                    Navigator.pop(context);
                    // Push to Screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ContactMailbox()),
                    );
                  },
                )
              : Container(),
        ],
      ),
    ));
  }
}
