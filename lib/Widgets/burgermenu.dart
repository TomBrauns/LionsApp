import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lionsapp/login/agb.dart';
import 'package:lionsapp/Screens/donation_user_screen.dart';
import 'package:lionsapp/Screens/events/event_editor.dart';

import 'package:lionsapp/Screens/calendar.dart';
import 'package:lionsapp/Screens/generateQR/generateqr.dart';
import 'package:lionsapp/Screens/home.dart';
import 'package:lionsapp/Screens/payment/paymethode.dart';
import 'package:lionsapp/Screens/projects/catalogue.dart';
import 'package:lionsapp/Screens/chat.dart';
import 'package:lionsapp/Screens/contact.dart';
import 'package:lionsapp/Screens/donation.dart';
import 'package:lionsapp/Screens/imprint.dart';
import 'package:lionsapp/Screens/donation_received.dart';
import 'package:lionsapp/Screens/user/user_configs.dart';
import 'package:lionsapp/Screens/events/events_liste.dart';
import 'package:lionsapp/Screens/user_management.dart';
import 'package:lionsapp/login/login.dart';
import 'package:lionsapp/login/register.dart';
import 'package:lionsapp/Widgets/privileges.dart';
import 'package:lionsapp/routes.dart';
import 'package:lionsapp/Screens/user/userUpdate.dart';

class BurgerMenu extends StatefulWidget {
  const BurgerMenu({Key? key}) : super(key: key);

  @override
  State<BurgerMenu> createState() => _BurgerMenuState();
}

class _BurgerMenuState extends State<BurgerMenu> {
  var scrollcontroller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Drawer(

      child: ListView(
        scrollDirection: Axis.vertical,
        controller: scrollcontroller,
        padding: EdgeInsets.zero,
        //
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
          const ListTile(
            title: Text(
              'Hauptseiten',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            tileColor: Color.fromARGB(255, 211, 211, 211),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: const Text('Startseite'),
            onTap: () {
              // Update State of App
              Navigator.pop(context);
              // Push to Screen
              Navigator.pushNamed(context, '/');
            },
          ),
          ListTile(
            leading: Icon(Icons.card_giftcard),
            title: const Text('Spenden'),
            onTap: () {
              // Update State of App
              Navigator.pop(context);
              // Push to Screen
              Navigator.pushNamed(context, '/Donations');
            },
          ),
          Privileges.privilege == "Admin" || Privileges.privilege == "Member" || Privileges.privilege == "Friend"
              ? ListTile(
                  leading: Icon(Icons.badge),
                  title: const Text('Benutzer'),
                  onTap: () {
                    // Update State of App
                    Navigator.pop(context);
                    // Push to Screen
                    Navigator.pushNamed(context, '/User');

                  },
                )
              : Container(),
          Privileges.privilege == "Admin" || Privileges.privilege == "Member" || Privileges.privilege == "Friend"
              ? ListTile(
                  leading: Icon(Icons.calendar_month_rounded),
                  title: const Text('Kalender'),
                  onTap: () {
                    // Update State of App
                    Navigator.pop(context);
                    // Push to Screen
                    Navigator.pushNamed(context, '/Calendar');

                  },
                )
              : Container(),
          Privileges.privilege == "Friend" || Privileges.privilege == "Member" || Privileges.privilege == "Admin"
              ? ListTile(
                  leading: Icon(Icons.event),
                  title: const Text('Aktivitäten'),
                  onTap: () {
                    // Update State of App
                    Navigator.pop(context);
                    // Push to Screen
                    Navigator.pushNamed(context, '/Events');
                  },
                )
              : Container(),
          Privileges.privilege == "Admin" || Privileges.privilege == "Member" || Privileges.privilege == "Friend"
              ? ListTile(
                  leading: Icon(Icons.book),
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
                  leading: Icon(Icons.chat),
                  title: const Text('Chat'),
                  onTap: () {
                    // Update State of App
                    Navigator.pop(context);
                    // Push to Screen
                    Navigator.pushNamed(context, '/Chat');

                  },
                )
              : Container(),
          ListTile(
            title: const Text('Info Seiten', style: TextStyle(fontWeight: FontWeight.bold)),
            tileColor: Color.fromARGB(255, 211, 211, 211),
          ),
          ListTile(
            leading: Icon(Icons.contact_support),
            title: const Text('Kontakt'),
            onTap: () {
              // Update State of App
              Navigator.pop(context);
              // Push to Screen
              Navigator.pushNamed(context, '/Contact');

            },
          ),
          ListTile(
            leading: Icon(Icons.format_align_justify_outlined),
            title: const Text('Impressum'),
            onTap: () {
              // Update State of App
              Navigator.pop(context);
              // Push to Screen
              Navigator.pushNamed(context, '/Imprint');

            },
          ),
          ListTile(
            leading: Icon(Icons.check_box),
            title: const Text("AGB's"),
            onTap: () {
              // Update State of App
              Navigator.pop(context);
              // Push to Screen
              Navigator.pushNamed(context, '/EULA');

            },
          ),
          ListTile(
            title: const Text('Konto Seiten', style: TextStyle(fontWeight: FontWeight.bold)),
            tileColor: Color.fromARGB(255, 211, 211, 211),
          ),

          Privileges.privilege == "Guest"
              ? ListTile(
            leading: Icon(Icons.app_registration),
            title: const Text('Registrierung'),
            onTap: () {
              // Update State of App
              Navigator.pop(context);
              // Push to Screen
              Navigator.pushNamed(context, '/Register');

            },
          )
          : Container(),


          Privileges.privilege == "Guest"
          ? ListTile(
            leading: Icon(Icons.login),
            title: const Text('Login'),
            onTap: () {
              // Update State of App
              Navigator.pop(context);
              // Push to Screen
              Navigator.pushNamed(context, '/Login');

            },
          )
          : Container(),

          Privileges.privilege == "Admin" || Privileges.privilege == "Member" || Privileges.privilege == "Friend"
              ? ListTile(
                  leading: Icon(Icons.logout),
                  title: const Text('Log Out'),
                  onTap: () {
                    // Update State of App
                    Navigator.pop(context);
                    // Push to Screen

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LogOut()),
                    );
                    signOut();
                  },
                )
              : Container(),
          ListTile(
            title: const Text(
              'Member Seiten',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            tileColor: Color.fromARGB(255, 211, 211, 211),
          ),
          Privileges.privilege == "Admin" || Privileges.privilege == "Member"
              ? ListTile(
                  leading: Icon(Icons.add_circle),
                  title: const Text('Aktivität erstellen'),
                  onTap: () {
                    // Update State of App
                    Navigator.pop(context);
                    // Push to Screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const EventEditor()),
                    );
                  },
                )
              : Container(),

          /// Following functions are for Admins only
          Privileges.privilege == "Admin"
              ? ListTile(
                  title: const Text(
                    'Admin Seiten',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  tileColor: Color.fromARGB(255, 211, 211, 211),
                )
              : Container(),

          Privileges.privilege == "Admin"
              ? ListTile(
                  leading: Icon(Icons.qr_code),
                  title: const Text('QRCode-Test'),
                  onTap: () {
                    // Update State of App
                    Navigator.pop(context);
                    // Push to Screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => QrCodeWithImage(link: 'www.google.de?param:', documentId: '12jdksl2342')),
                    );
                  },
                )
              : Container(),

          Privileges.privilege == "Admin"
              ? ListTile(
                  leading: Icon(Icons.manage_accounts),
                  title: const Text('Nutzerverwaltung'),
                  onTap: () {
                    // Update State of App
                    Navigator.pop(context);
                    // Push to Screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const UserManagement()),
                    );
                  },
                )
              : Container(),
          Privileges.privilege == "Admin" || Privileges.privilege == "Member" || Privileges.privilege == "Friend"
              ? ListTile(
                  leading: Icon(Icons.logout),
                  title: const Text('New Donations'),
                  onTap: () {
                    // Update State of App
                    Navigator.pop(context);
                    // Push to Screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const DonationsUser()),
                    );
                  },
                )
              : Container(),
        ],
      ),
    );
  }
}
