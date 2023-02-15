import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(children: [
        ElevatedButton(onPressed: null, child: Text("Name/Email")),
        ElevatedButton(onPressed: null, child: Text("Passwort")),
        ElevatedButton(onPressed: null, child: Text("Anmelden")),
        ElevatedButton(onPressed: null, child: Text("Passwort vergessen?")),
      ]),
    ));
  }
}
