import 'package:flutter/material.dart';
import 'package:lionsapp/Widgets/burgermenu.dart';

class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  State<Chat> createState() => _CalendarState();
}

class _CalendarState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const BurgerMenu(),
      appBar: AppBar(
        title: const Text("Chat"),
      ),
    );
  }
}
