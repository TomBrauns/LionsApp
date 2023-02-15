import 'package:flutter/material.dart';
import 'package:lionsapp/Widgets/burgermenu.dart';

class User_management extends StatefulWidget {
  const User_management({Key? key}) : super(key: key);

  @override
  State<User_management> createState() => _User_managementState();
}

class _User_managementState extends State<User_management> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const BurgerMenu(),
      appBar: AppBar(
        title: const Text(
            "Nutzerverwaltung"),
      ),
    );
  }
}