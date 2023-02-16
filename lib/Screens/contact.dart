// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';
import 'package:lionsapp/Widgets/burgermenu.dart';
import 'package:mb_contact_form/mb_contact_form.dart';

class Contact extends StatefulWidget {
  const Contact({Key? key}) : super(key: key);

  @override
  State<Contact> createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  get child => null;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const BurgerMenu(),
      appBar: AppBar(
        title: const Text("Kontakt"),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsetsDirectional.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            MBContactForm(
                hasHeading: true,
                withIcons: false,
                destinationEmail: "XXXXX@yahoo.com"),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.blue)),
              onPressed: null,
              child: Text(
                "Weitere Datei zu hochladen hier reinziehen",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  color(Color white) {}
}
