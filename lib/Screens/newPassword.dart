import 'package:flutter/material.dart';

class AuthCode extends StatefulWidget {
  const AuthCode({Key? key}) : super(key: key);

  @override
  State<AuthCode> createState() => _AuthCodeState();
}

class _AuthCodeState extends State<AuthCode> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(children: [
        TextField(
          obscureText: true,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Neues Passwort',
          ),
        ),
        TextField(
          obscureText: true,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Passwort verändern',
          ),
        ),
        ElevatedButton(onPressed: null, child: Text("Bestätigen")),
      ]),
    ));
  }
}
