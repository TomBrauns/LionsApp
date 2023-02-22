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
      appBar: MyAppBar(title: "Startseite"),
      drawer: BurgerMenu(),
      bottomNavigationBar: BottomNavigation(
        currentPage: "HomePage",
        privilege: Privileges.privilege,
      ),
      body: Center(
        child: Text('Ich bin eine Homepage, füll mich!'),
      ),
    );
  }
}
