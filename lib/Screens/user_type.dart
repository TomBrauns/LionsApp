import 'package:flutter/material.dart';

class UserType extends StatelessWidget {
  const UserType({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(children: [
        ElevatedButton(onPressed: null, child: Text("Gast")),
        ElevatedButton(onPressed: null, child: Text("Anmelden")),
        Text("Noch kein Konto?", textAlign: TextAlign.center),
        ElevatedButton(onPressed: null, child: Text("Hier registrieren"))
      ]),
    ));
  }
}
