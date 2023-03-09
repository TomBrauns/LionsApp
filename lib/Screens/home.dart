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
        child: Text("Servus beinand, mia g'frein uns narrisch, dass's auf unsara Homepage vom Lions Club vorbeischaugts. Da Lions Club is a Vereinigung vo engagierte Leit, de wo si für a guade Sacha einsetzen und ehrenamtlich was in ihrer Gemeinschaft bewegen woin. Mia ham a großes Herz für unsara bayerische Heimat und legn vui Wert auf Tradition und soziale Verantwortung. Unser Motto is 'we serve' und des is a Grundphilosophie, de wo uns imma antreibt. Mia woin die Wölt a bissl besser mochn, oans Projekt nochm andan. Wenn's an Liawand braucht oder wenn's selber wos Guads tun woin, dann is da Lions Club da richtige Ansprechpartner. Schauts eich gern um auf unserer Homepage und bei Fragen oder Anregungen san mia immer gern für eich do. Pfiat eich und bis bald beim Lions Club!"
            ,style: CustomTextSize.small
        )
        ),
      );

  }
}
