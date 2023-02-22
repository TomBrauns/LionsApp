import 'package:flutter/material.dart';
import 'package:lionsapp/Screens/agb.dart';
import 'package:lionsapp/Screens/events/create_event.dart';

import 'package:lionsapp/Screens/calendar.dart';
import 'package:lionsapp/Screens/generateQR/generateqr.dart';
import 'package:lionsapp/Screens/home.dart';
import 'package:lionsapp/Screens/payment/paymethode.dart';
import 'package:lionsapp/Screens/projects/catalogue.dart';
import 'package:lionsapp/Screens/chat.dart';
import 'package:lionsapp/Screens/contact.dart';
import 'package:lionsapp/Screens/donation.dart';
import 'package:lionsapp/Screens/imprint.dart';
import 'package:lionsapp/Screens/receipt.dart';
import 'package:lionsapp/Screens/user/user_configs.dart';
import 'package:lionsapp/Screens/events/events_liste.dart';
import 'package:lionsapp/Screens/user_management.dart';
import 'package:lionsapp/Screens/contact_mailbox.dart';
import 'package:lionsapp/login/login.dart';
import 'package:lionsapp/login/register.dart';
import 'package:lionsapp/Widgets/privileges.dart';
import 'package:lionsapp/routes.dart';

class BurgerMenu extends StatefulWidget {
  const BurgerMenu({Key? key}) : super(key: key);

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
            title: const Text('Startseite'),
            onTap: () {
              // Update State of App
              Navigator.pop(context);
              // Push to Screen
              Navigator.pushNamed(context, '/');
            },
          ),
          ListTile(
            title: const Text('Spenden'),
            onTap: () {
              // Update State of App
              Navigator.pop(context);
              // Push to Screen
              Navigator.pushNamed(context, '/Donations');
            },
          ),
          Privileges.privilege == "Admin" ||
                  Privileges.privilege == "Member" ||
                  Privileges.privilege == "Friend"
              ? ListTile(
                  title: const Text('Benutzer'),
                  onTap: () {
                    // Update State of App
                    Navigator.pop(context);
                    // Push to Screen
                    Navigator.pushNamed(context, '/User');
                  },
                )
              : Container(),
          Privileges.privilege == "Admin" ||
                  Privileges.privilege == "Member" ||
                  Privileges.privilege == "Friend"
              ? ListTile(
                  title: const Text('Kalender'),
                  onTap: () {
                    // Update State of App
                    Navigator.pop(context);
                    // Push to Screen
                    Navigator.pushNamed(context, '/Calendar');
                  },
                )
              : Container(),
          Privileges.privilege == "Friend" ||
                  Privileges.privilege == "Member" ||
                  Privileges.privilege == "Admin"
              ? ListTile(
                  title: const Text('Events'),
                  onTap: () {
                    // Update State of App
                    Navigator.pop(context);
                    // Push to Screen
                    Navigator.pushNamed(context, '/Events');
                  },
                )
              : Container(),
          Privileges.privilege == "Admin" ||
                  Privileges.privilege == "Member" ||
                  Privileges.privilege == "Friend"
              ? ListTile(
                  title: const Text('Katalog'),
                  onTap: () {
                    // Update State of App
                    Navigator.pop(context);
                    // Push to Screen
                    Navigator.pushNamed(context, '/Catalogue');
                  },
                )
              : Container(),
          Privileges.privilege == "Admin" || Privileges.privilege == "Member"
              ? ListTile(
                  title: const Text('Chat'),
                  onTap: () {
                    // Update State of App
                    Navigator.pop(context);
                    // Push to Screen
                    Navigator.pushNamed(context, '/Chat');
                  },
                )
              : Container(),
          Privileges.privilege == "Admin" || Privileges.privilege == "Member"
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
              Navigator.pushNamed(context, '/Contact');
            },
          ),
          ListTile(
            title: const Text('Impressum'),
            onTap: () {
              // Update State of App
              Navigator.pop(context);
              // Push to Screen
              Navigator.pushNamed(context, '/Imprint');
            },
          ),
          ListTile(
            title: const Text('Registrierung'),
            onTap: () {
              // Update State of App
              Navigator.pop(context);
              // Push to Screen
              Navigator.pushNamed(context, '/Register');
            },
          ),
          ListTile(
            title: const Text('Login'),
            onTap: () {
              // Update State of App
              Navigator.pop(context);
              // Push to Screen
              Navigator.pushNamed(context, '/Login');
            },
          ),
          ListTile(
            title: const Text('QRCode-Test'),
            onTap: () {
              // Update State of App
              Navigator.pop(context);
              // Push to Screen
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => QrCodeWithImage(
                        link: 'www.google.de?param:',
                        documentId: '12jdksl2342')),
              );
            },
          ),

          /// Following functions are for Admins only
          Privileges.privilege == "Admin"
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
          Privileges.privilege == "Admin"
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
          Privileges.privilege == "Admin"
              ? ListTile(
                  title: const Text('paymethode'),
                  onTap: () {
                    // Update State of App
                    Navigator.pop(context);
                    // Push to Screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Paymethode()),
                    );
                  },
                )
              : Container(),
          ListTile(
            title: const Text("AGB's"),
            onTap: () {
              // Update State of App
              Navigator.pop(context);
              // Push to Screen
              Navigator.pushNamed(context, '/EULA');
            },
          ),
          ListTile(
            title: const Text('Quittung'),
            onTap: () {
              // Update State of App
              Navigator.pop(context);
              // Push to Screen
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const DonationReceived()),
              );
            },
          ),
        ],
      ),
    ));
  }
}
