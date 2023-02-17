import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:lionsapp/Widgets/burgermenu.dart';
import 'package:lionsapp/Widgets/bottomNavigationView.dart';

class Calendar extends StatefulWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  final EventController _eventController = EventController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const BurgerMenu(),
        appBar: AppBar(
          title: const Text("Kalender"),
        ),
        bottomNavigationBar: const BottomNavigation(currentPage: "Calendar"),
        body: MonthView(controller: _eventController));
  }
}
