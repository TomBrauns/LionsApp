import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:lionsapp/Widgets/appbar.dart';
import 'package:lionsapp/Widgets/bottomNavigationView.dart';
import 'package:lionsapp/Widgets/burgermenu.dart';
import 'package:lionsapp/Widgets/privileges.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: "Startseite"),
      drawer: const BurgerMenu(),
      bottomNavigationBar: BottomNavigation(),
      body: const Center(
        child: Text("Ei Gude und herzlich willkumme beim Lions Club! Mir sinn e gude Haufe vun Leit, die sich für unseri Gemeinschaft engagiere und unsere Region unterstütze. Schau dich gerne emol uff unsere Seit um und lern uns besser kenne. Mer freue uns uff dich!\n\n Juten Tach und herzlich willkommen beim Lions Club! Mir san 'ne jute Truppe von Leuten, die sich für unsre Gemeinschaft engagieren und unsre Region unterstützen. Mach' dir keen Kopp und schau ruhig ma' uff unsre Seit'n, damit du uns besser kennenlernst. Wir freun' uns uff dich, allet jute!",
        style: TextStyle(
          fontSize: 24,
          color: Colors.blueGrey,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
