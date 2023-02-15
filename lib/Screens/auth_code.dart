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
            labelText: 'AuthCode',
          ),
        ),
        ElevatedButton(onPressed: null, child: Text("Bestätigen")),
      ]),
    ));
  }
}
