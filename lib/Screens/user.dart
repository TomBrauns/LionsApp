import 'package:flutter/material.dart';

class User extends StatefulWidget {

  @override
  State<User> createState() => _UserState();
}

class _UserState extends State<User> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Text(
              'Willkommen bei Lion',
              style: TextStyle(
                fontSize: 32,
                color: Colors.blue,
              ),
              textAlign: TextAlign.center,
            ),
            TextField(
              decoration: InputDecoration(
                  labelText: "Namen",
                  hintText: "Name und Vorname eingeben",
                  icon: Icon(
                    Icons.person,
                    color: Colors.blue,
                    size: 25,
                  )),
              keyboardType: TextInputType.text,
            ),
            TextField(
              decoration: InputDecoration(
                  labelText: "E-Mail",
                  hintText: "E-Mail eingeben",
                  icon: Icon(
                    Icons.email,
                    color: Colors.blue,
                    size: 25,
                  )),
              keyboardType: TextInputType.text,
            ),
            TextField(
              decoration: InputDecoration(
                  labelText: "Passwort",
                  hintText: "Passwort",
                  icon: Icon(
                    Icons.lock,
                    color: Colors.blue,
                    size: 25,
                  )),
              keyboardType: TextInputType.text,
            ),
            TextField(
              decoration: InputDecoration(
                  labelText: "Passwort Bestättigen",
                  hintText: "Passwort bestättigen",
                  icon: Icon(
                    Icons.lock,
                    color: Colors.blue,
                    size: 25,
                  )),
              keyboardType: TextInputType.text,
            ),
          ],
        ),
      ),
    );
  }
}
