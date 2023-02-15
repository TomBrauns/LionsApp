import 'package:flutter/material.dart';

class PasswordForgotten extends StatefulWidget {
  const PasswordForgotten({Key? key}) : super(key: key);

  @override
  State<PasswordForgotten> createState() => _PasswordForgottenState();
}

class _PasswordForgottenState extends State<PasswordForgotten> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(children: [
        TextField(
          obscureText: true,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Email',
          ),
        ),
        ElevatedButton(onPressed: null, child: Text("Bestätigen")),
      ]),
    ));
  }
}
