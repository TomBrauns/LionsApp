import 'package:flutter/material.dart';
import 'package:lionsapp/widgets/burgermenu.dart';

class User extends StatefulWidget {
  const User({Key? key}) : super(key: key);

  @override
  State<User> createState() => _UserState();
}

class _UserState extends State<User> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const BurgerMenu(),
      appBar: AppBar(
        title: const Text("Benutzer"),
      ),
      body: Scrollable(
      child: SingleChildScrollView(
        child:
        )

      )


    );
  }
}

