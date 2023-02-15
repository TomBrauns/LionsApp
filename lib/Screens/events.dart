import 'package:flutter/material.dart';
//import 'package:flutter/src/Widgets/placeholder.dart';
//import 'package:flutter/src/Widgets/framework.dart';
import 'package:lionsapp/Widgets/burgermenu.dart';

class Events extends StatefulWidget {
  const Events({super.key});

  @override
  State<Events> createState() => _EventsState();
}

class _EventsState extends State<Events> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Events"),
      ),
      drawer: const BurgerMenu(),
    );
  }
}
