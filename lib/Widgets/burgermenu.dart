import 'package:flutter/material.dart';
import 'package:lionsapp/Screens/donation_user_screen.dart';
import 'package:lionsapp/Screens/events/event_editor.dart';
import 'package:lionsapp/Screens/generateQR/generateqr.dart';
import 'package:lionsapp/Screens/user/user_configs.dart';
import 'package:lionsapp/Screens/user_management.dart';
import 'package:lionsapp/Widgets/privileges.dart';

import '../util/color.dart';

class AppData{
  static int selected = -1;
}

class BurgerMenu extends StatefulWidget {
  const BurgerMenu({Key? key}) : super(key: key);

  @override
  State<BurgerMenu> createState() => _BurgerMenuState();
}

class _BurgerMenuState extends State<BurgerMenu> {
  var scrollcontroller = ScrollController();
  int _selectedMenuIndex = AppData.selected;

  @override
  void initState() {
    super.initState();
    AppData.selected = 10;
    print(AppData.selected);
  }


  bool isMenuSelected(int index){
    return index == _selectedMenuIndex;
  }

  @override
  Widget build(BuildContext context) {
    print("Hier kommt die AppDat ${AppData.selected}");
    return Drawer(
      child: ListView(
        scrollDirection: Axis.vertical,
        controller: scrollcontroller,
        padding: EdgeInsets.zero,
        //
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: ColorUtils.primaryColor,
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Image.asset("assets/appicon/lions_white.png", fit: BoxFit.contain),
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
            leading: const Icon(Icons.home),
            title: const Text('Startseite'),
            selected: isMenuSelected(0),
            selectedTileColor: Colors.green,
            onTap: () {
              // Update State of App
              Navigator.pop(context);
              // Push to Screen
              Navigator.pushNamed(context, '/');
              setState(() {
                _selectedMenuIndex = 0;
              });
            },
          ),
          ListTile(
            leading: const Icon(Icons.card_giftcard),
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
                  leading: const Icon(Icons.badge),
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
                  leading: const Icon(Icons.calendar_month_rounded),
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
                  leading: const Icon(Icons.event),
                  title: const Text('Aktivitäten'),
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
                  leading: const Icon(Icons.book),
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
                  leading: const Icon(Icons.chat),
                  title: const Text('Chat'),
                  onTap: () {
                    // Update State of App
                    Navigator.pop(context);
                    // Push to Screen
                    Navigator.pushNamed(context, '/Chat');
                  },
                )
              : Container(),
          const ListTile(
            title: Text('Info Seiten',
                style: TextStyle(fontWeight: FontWeight.bold)),
            tileColor: Color.fromARGB(255, 211, 211, 211),
          ),
          ListTile(
            leading: const Icon(Icons.contact_support),
            title: const Text('Kontakt'),
            onTap: () {
              // Update State of App
              Navigator.pop(context);
              // Push to Screen
              Navigator.pushNamed(context, '/Contact');
            },
          ),
          ListTile(
            leading: const Icon(Icons.format_align_justify_outlined),
            title: const Text('Impressum'),
            onTap: () {
              // Update State of App
              Navigator.pop(context);
              // Push to Screen
              Navigator.pushNamed(context, '/Imprint');
            },
          ),
          ListTile(
            leading: const Icon(Icons.check_box),
            title: const Text("AGB's"),
            onTap: () {
              // Update State of App
              Navigator.pop(context);
              // Push to Screen
              Navigator.pushNamed(context, '/EULA');
            },
          ),
          const ListTile(
            title: Text('Konto Seiten',
                style: TextStyle(fontWeight: FontWeight.bold)),
            tileColor: Color.fromARGB(255, 211, 211, 211),
          ),

          Privileges.privilege == "Guest"
              ? ListTile(
                  leading: const Icon(Icons.app_registration),
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
                  leading: const Icon(Icons.login),
                  title: const Text('Login'),
                  onTap: () {
                    // Update State of App
                    Navigator.pop(context);
                    // Push to Screen
                    Navigator.pushNamed(context, '/Login');
                  },
                )
              : Container(),

          Privileges.privilege == "Admin" ||
                  Privileges.privilege == "Member" ||
                  Privileges.privilege == "Friend"
              ? ListTile(
                  leading: const Icon(Icons.logout),
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

          Privileges.privilege == "Admin" ||
                  Privileges.privilege == "Member" ||
                  Privileges.privilege == "Friend"
              ? const ListTile(
                  title: Text(
                    'Member Seiten',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  tileColor: Color.fromARGB(255, 211, 211, 211),
                )
              : Container(),

          Privileges.privilege == "Admin" || Privileges.privilege == "Member"
              ? ListTile(
                  leading: const Icon(Icons.add_circle),
                  title: const Text('Aktivität erstellen'),
                  onTap: () {
                    // Update State of App
                    Navigator.pop(context);
                    // Push to Screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const EventEditor()),
                    );
                  },
                )
              : Container(),

          /// Following functions are for Admins only
          Privileges.privilege == "Admin"
              ? const ListTile(
                  title: Text(
                    'Admin Seiten',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  tileColor: Color.fromARGB(255, 211, 211, 211),
                )
              : Container(),

          Privileges.privilege == "Admin"
              ? ListTile(
                  leading: const Icon(Icons.qr_code),
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
                )
              : Container(),

          Privileges.privilege == "Admin"
              ? ListTile(
                  leading: const Icon(Icons.manage_accounts),
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
          Privileges.privilege == "Admin" ||
                  Privileges.privilege == "Member" ||
                  Privileges.privilege == "Friend"
              ? ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text('New Donations'),
                  onTap: () {
                    // Update State of App
                    Navigator.pop(context);
                    // Push to Screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DonationsUser()),
                    );
                  },
                )
              : Container(),
        ],
      ),
    );
  }
}
