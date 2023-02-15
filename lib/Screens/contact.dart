import 'package:flutter/material.dart';
import 'package:lionsapp/widgets/burgermenu.dart';
import 'package:mb_contact_form/mb_contact_form.dart';

class Contact extends StatefulWidget {
  const Contact({Key? key}) : super(key: key);

  @override
  State<Contact> createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const BurgerMenu(),
      appBar: AppBar(
        title: const Text("Kontakt"),
      ),
      body: const Column(
        children: [
        MBContactForm(
        hasHeading: true, withIcons: false, destinationEmail: "XXXXX@yahoo.com"),
        Text("Weitere Daten")

      ],)
    );
  }
}
