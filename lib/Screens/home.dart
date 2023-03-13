import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:lionsapp/Widgets/appbar.dart';
import 'package:lionsapp/Widgets/bottomNavigationView.dart';
import 'package:lionsapp/Widgets/burgermenu.dart';
import 'package:lionsapp/Widgets/privileges.dart';
import 'package:lionsapp/Widgets/textSize.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key});

// BAB with Privilege
  Widget? _getBAB() {
    if (Privileges.privilege == Privilege.admin ||
        Privileges.privilege == Privilege.member ||
        Privileges.privilege == Privilege.friend) {
      return BottomNavigation();
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: "Startseite"),
      drawer: const BurgerMenu(),
      bottomNavigationBar: _getBAB(),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  "Moin Moin un Herzlich Willkamen op de Homepage vun de Lions Club Luthras in Kaiserslautern! Wi sünd en Gemeinschaft vun Lüüd, de sik för de Gemeenschap un de Minschen in unsere Regioun insetten. Wi freut uns, dat du uns hier besöökst un wünscht di veel Spaß un Informatiounen op disse Siet. Meld di gern, wenn du Frogen hest oder uns gern ünnerstütten wüllt. Wi wünscht di en goden Dag!",
                  style: CustomTextSize.small,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () =>
                      launchUrl(Uri.parse('https://www.lions.de/')),
                  child: Text(
                    "Weitere Informationen zum Verein hier",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
