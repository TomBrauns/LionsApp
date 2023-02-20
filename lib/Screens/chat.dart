import 'package:flutter/material.dart';
import 'package:lionsapp/Widgets/burgermenu.dart';
import 'package:lionsapp/Widgets/bottomNavigationView.dart';

import '../Widgets/appbar.dart';

class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  State<Chat> createState() => _CalendarState();
}

class _CalendarState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      drawer: BurgerMenu(),
      appBar: MyAppBar(title: "Chat"),
      bottomNavigationBar: BottomNavigation(
        currentPage: "Chat",
        privilege: "Admin",
      ),
    );
  }
}
