import 'package:flutter/material.dart';
import 'package:lionsapp/Widgets/burgermenu.dart';

class ContactMailbox extends StatefulWidget {
  const ContactMailbox({Key? key}) : super(key: key);

  @override
  State<ContactMailbox> createState() => _ContactMailboxState();
}

class _ContactMailboxState extends State<ContactMailbox> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const BurgerMenu(),
      appBar: AppBar(
        title: const Text("Kontakt-Postfach"),
      ),
    );
  }
}
