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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const BurgerMenu(),
      appBar: AppBar(
        title: const Text("Kontakt"),
      ),
      body: const MBContactForm(
          hasHeading: true,
          withIcons: false,
<<<<<<< HEAD
          destinationEmail: "omersucces@yahoo.com"),
=======
          destinationEmail: "XXXXX@yahoo.com"),
>>>>>>> 48ce195fa88f4584b16c4bbc9354a889683ed62d
    );
  }
}
