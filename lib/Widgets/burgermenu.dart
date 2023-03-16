//Licensed under the EUPL v.1.2 or later
import 'package:flutter/material.dart';
import 'package:lionsapp/Screens/events/event_editor.dart';
import 'package:lionsapp/Screens/generateQR/generateqr.dart';
import 'package:lionsapp/Screens/meetings/meeting_editor.dart';
import 'package:lionsapp/Screens/user/admin/changeRole.dart';
import 'package:lionsapp/Screens/user/user_configs.dart';
import 'package:lionsapp/Widgets/privileges.dart';
import 'package:lionsapp/util/textSize.dart';

import '../util/color.dart';

class AppData {
  static int selected = -1;
}

class BurgerMenu extends StatefulWidget {
  const BurgerMenu({Key? key}) : super(key: key);

  @override
  State<BurgerMenu> createState() => _BurgerMenuState();
}

class _BurgerMenuState extends State<BurgerMenu> {
  var scrollcontroller = ScrollController();

  Color selectedColor = ColorUtils.secondaryColor;

  bool isMenuSelected(int index) {
    return index == AppData.selected;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        scrollDirection: Axis.vertical,
        controller: scrollcontroller,
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: ColorUtils.primaryColor,
            ),
/*
            Silly attempt to make the logo yellow ( all the white pixels turned to our secondary colour:

            child: ColorFiltered(
              colorFilter: ColorFilter.mode(ColorUtils.secondaryColor, BlendMode.srcIn),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: Image.asset("assets/appicon/lions_white.png", fit: BoxFit.contain),
                ),
              ),
            ),
*/
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Image.asset("assets/appicon/lions_white.png",
                    fit: BoxFit.contain),
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
            title: Text('Startseite', style: CustomTextSize.small),
            selected: isMenuSelected(0),
            selectedTileColor: selectedColor,
            onTap: () {
              // Update State of App
              Navigator.pop(context);
              // Push to Screen
              Navigator.pushNamed(context, '/');
              setState(() {
                AppData.selected = 0;
              });
            },
          ),
          ListTile(
            leading: const Icon(Icons.card_giftcard),
            title: Text('Spenden', style: CustomTextSize.small),
            selected: isMenuSelected(1),
            selectedTileColor: selectedColor,
            onTap: () {
              setState(() {
                AppData.selected = 1;
              });
              // Update State of App
              Navigator.pop(context);
              // Push to Screen
              Navigator.pushNamed(context, '/Donations');
            },
          ),
          Privileges.privilege == Privilege.admin ||
                  Privileges.privilege == Privilege.member ||
                  Privileges.privilege == Privilege.friend
              ? ListTile(
                  leading: const Icon(Icons.badge),
                  title: Text('Benutzer', style: CustomTextSize.small),
                  selected: isMenuSelected(2),
                  selectedTileColor: selectedColor,
                  onTap: () {
                    setState(() {
                      AppData.selected = 2;
                    });
                    // Update State of App
                    Navigator.pop(context);
                    // Push to Screen
                    Navigator.pushNamed(context, '/User');
                  },
                )
              : Container(),
          Privileges.privilege == Privilege.admin ||
                  Privileges.privilege == Privilege.member ||
                  Privileges.privilege == Privilege.friend
              ? ListTile(
                  leading: const Icon(Icons.calendar_month_rounded),
                  title: Text('Kalender', style: CustomTextSize.small),
                  selected: isMenuSelected(3),
                  selectedTileColor: selectedColor,
                  onTap: () {
                    setState(() {
                      AppData.selected = 3;
                    });
                    // Update State of App
                    Navigator.pop(context);
                    // Push to Screen
                    Navigator.pushNamed(context, '/Calendar');
                  },
                )
              : Container(),
          ListTile(
            leading: const Icon(Icons.event),
            title: Text('Aktivitäten', style: CustomTextSize.small),
            selected: isMenuSelected(4),
            selectedTileColor: selectedColor,
            onTap: () {
              setState(() {
                AppData.selected = 4;
              });
              // Update State of App
              Navigator.pop(context);
              // Push to Screen
              Navigator.pushNamed(context, '/Events');
            },
          ),

          ListTile(
            leading: const Icon(Icons.book),
            title: Text('Projekte', style: CustomTextSize.small),
            selected: isMenuSelected(5),
            selectedTileColor: selectedColor,
            onTap: () {
              setState(() {
                AppData.selected = 5;
              });
              // Update State of App
              Navigator.pop(context);
              // Push to Screen
              Navigator.pushNamed(context, '/Catalogue');
            },
          ),

          Privileges.privilege == Privilege.admin ||
                  Privileges.privilege == Privilege.member
              ? ListTile(
                  leading: const Icon(Icons.chat),
                  title: Text('Chat', style: CustomTextSize.small),
                  selected: isMenuSelected(6),
                  selectedTileColor: selectedColor,
                  onTap: () {
                    setState(() {
                      AppData.selected = 6;
                    });
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
            title: Text('Kontakt', style: CustomTextSize.small),
            selected: isMenuSelected(7),
            selectedTileColor: selectedColor,
            onTap: () {
              setState(() {
                AppData.selected = 7;
              });
              // Update State of App
              Navigator.pop(context);
              // Push to Screen
              Navigator.pushNamed(context, '/Contact');
            },
          ),
          ListTile(
            leading: const Icon(Icons.format_align_justify_outlined),
            title: Text('Impressum', style: CustomTextSize.small),
            selected: isMenuSelected(8),
            selectedTileColor: selectedColor,
            onTap: () {
              setState(() {
                AppData.selected = 8;
              });
              // Update State of App
              Navigator.pop(context);
              // Push to Screen
              Navigator.pushNamed(context, '/Imprint');
            },
          ),
          ListTile(
            leading: const Icon(Icons.check_box),
            title: Text("AGB's", style: CustomTextSize.small),
            selected: isMenuSelected(9),
            selectedTileColor: selectedColor,
            onTap: () {
              setState(() {
                AppData.selected = 9;
              });
              // Update State of App
              Navigator.pop(context);
              // Push to Screen
              Navigator.pushNamed(context, '/AGB?onRegister=false');
            },
          ),

          Privileges.privilege == Privilege.admin ||
                  Privileges.privilege == Privilege.member
              ? const ListTile(
                  title: Text(
                    'Member Seiten',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  tileColor: Color.fromARGB(255, 211, 211, 211),
                )
              : Container(),

          Privileges.privilege == Privilege.admin ||
                  Privileges.privilege == Privilege.member
              ? ListTile(
                  leading: const Icon(Icons.add_circle),
                  title:
                      Text('Aktivität erstellen', style: CustomTextSize.small),
                  selected: isMenuSelected(10),
                  selectedTileColor: selectedColor,
                  onTap: () {
                    setState(() {
                      AppData.selected = 10;
                    });
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
          Privileges.privilege == Privilege.admin ||
                  Privileges.privilege == Privilege.member
              ? ListTile(
                  leading: const Icon(Icons.add_circle),
                  title: Text('Meeting erstellen', style: CustomTextSize.small),
                  selected: isMenuSelected(11),
                  selectedTileColor: selectedColor,
                  onTap: () {
                    setState(() {
                      AppData.selected = 11;
                    });
                    // Update State of App
                    Navigator.pop(context);
                    // Push to Screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MeetingEditor()),
                    );
                  },
                )
              : Container(),

          /// Following functions are for Admins only
          Privileges.privilege == Privilege.admin
              ? const ListTile(
                  title: Text(
                    'Admin Seiten',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  tileColor: Color.fromARGB(255, 211, 211, 211),
                )
              : Container(),
          Privileges.privilege == Privilege.admin
              ? ListTile(
                  leading: const Icon(Icons.manage_accounts),
                  title: Text('Admin History', style: CustomTextSize.small),
                  selected: isMenuSelected(12),
                  selectedTileColor: selectedColor,
                  onTap: () {
                    setState(() {
                      AppData.selected = 12;
                    });
                    // Update State of App
                    Navigator.pop(context);
                    // Push to Screen
                    Navigator.pushNamed(context, '/AdminHistory');
                  },
                )
              : Container(),
          Privileges.privilege == Privilege.admin
              ? ListTile(
                  leading: const Icon(Icons.manage_accounts),
                  title: Text('Rollen verwalten', style: CustomTextSize.small),
                  selected: isMenuSelected(13),
                  selectedTileColor: selectedColor,
                  onTap: () {
                    setState(() {
                      AppData.selected = 13;
                    });
                    // Update State of App
                    Navigator.pop(context);
                    // Push to Screen
                    Navigator.pushNamed(context, '/ChangeRole');
                  },
                )
              : Container(),
          Privileges.privilege == Privilege.admin
              ? ListTile(
                  leading: const Icon(Icons.manage_accounts),
                  title: Text('Nutzer löschen', style: CustomTextSize.small),
                  selected: isMenuSelected(14),
                  selectedTileColor: selectedColor,
                  onTap: () {
                    setState(() {
                      AppData.selected = 14;
                    });
                    // Update State of App
                    Navigator.pop(context);
                    // Push to Screen
                    Navigator.pushNamed(context, '/deleteUser');
                  },
                )
              : Container(),
          Privileges.privilege == Privilege.admin
              ? ListTile(
                  leading: const Icon(Icons.manage_accounts),
                  title: Text('Chats löschen', style: CustomTextSize.small),
                  selected: isMenuSelected(15),
                  selectedTileColor: selectedColor,
                  onTap: () {
                    setState(() {
                      AppData.selected = 15;
                    });
                    // Update State of App
                    Navigator.pop(context);
                    // Push to Screen
                    Navigator.pushNamed(context, '/deleteChat');
                  },
                )
              : Container(),
          const ListTile(
            title: Text('Konto Seiten',
                style: TextStyle(fontWeight: FontWeight.bold)),
            tileColor: Color.fromARGB(255, 211, 211, 211),
          ),

          Privileges.privilege == Privilege.guest
              ? ListTile(
                  leading: const Icon(Icons.app_registration),
                  title: Text('Registrierung', style: CustomTextSize.small),
                  selected: isMenuSelected(16),
                  selectedTileColor: selectedColor,
                  onTap: () {
                    setState(() {
                      AppData.selected = 16;
                    });
                    // Update State of App
                    Navigator.pop(context);
                    // Push to Screen
                    Navigator.pushNamed(context, '/Register');
                  },
                )
              : Container(),

          Privileges.privilege == Privilege.guest
              ? ListTile(
                  leading: const Icon(Icons.login),
                  title: Text('Login', style: CustomTextSize.small),
                  selected: isMenuSelected(17),
                  selectedTileColor: selectedColor,
                  onTap: () {
                    setState(() {
                      AppData.selected = 17;
                    });
                    // Update State of App
                    Navigator.pop(context);
                    // Push to Screen
                    Navigator.pushNamed(context, '/Login');
                  },
                )
              : Container(),

          Privileges.privilege == Privilege.admin ||
                  Privileges.privilege == Privilege.member ||
                  Privileges.privilege == Privilege.friend
              ? ListTile(
                  leading: const Icon(Icons.logout),
                  title: Text('Ausloggen', style: CustomTextSize.small),
                  selected: isMenuSelected(18),
                  selectedTileColor: selectedColor,
                  onTap: () {
                    setState(() {
                      AppData.selected = 18;
                    });
                    // Update State of App
                    Navigator.pop(context);
                    // Push to Screen

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Colors.green,
                        content: Text("Sie sind nun ausgeloggt"),
                        duration: Duration(seconds: 3),
                      ),
                    );
                    Navigator.pushNamed(context, '/');
                    signOut();
                  },
                )
              : Container(),
        ],
      ),
    );
  }
}
