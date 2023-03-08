import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:lionsapp/Widgets/appbar.dart';
import 'package:lionsapp/Widgets/bottomNavigationView.dart';
import 'package:lionsapp/Widgets/burgermenu.dart';
import 'package:lionsapp/Widgets/privileges.dart';
import 'package:lionsapp/Widgets/textSize.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // BAB with Priviledge
  //Copy that
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
        child: Text("Servus beinand, mir frein uns narrisch, dass's auf unserer Homepage vom Lions Club vorbeischaut. Der Lions Club is a Vereinigung vo engagierte Leid, de wo se für a guade Sacha einsetzen und ehrenamtlich was in ihrer Gemeinschaft bewegen woin. Mir hamma a groaßes Herz für unsara bayrische Heimat und legn vui Werta auf Tradition und soziale Verantwortung. Unser Motto is 'we serve' und des is a Grundphilosophie, de wo uns imma antreibt. Mir woin de Wält a bissal besser mocha, oans Projekt nachm andern. Wenn's an Liawand braucht oder wenn's selba wos Gutes tun woin, dann is da Lions Club da richtige Ansprechpartner. Schaut's eich gern um auf unserer Homepage und bei Fragen oder Anregungen san mir immer gern für eich do. Pfiad eich und bis bald beim Lions Club!",style: CustomTextSize.small
        )
        ),
      );

  }
}
