import 'package:flutter/material.dart';
import 'package:lionsapp/Widgets/burgermenu.dart';

class Friend extends StatefulWidget {
  const Friend({Key? key}) : super(key: key);

  @override
  State<Friend> createState() => _ProjectState();
}

class _ProjectState extends State<Friend> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Friend"),
      ),
      body: const Text("Hier folgt die FreundeSeite"),
    );
  }
}