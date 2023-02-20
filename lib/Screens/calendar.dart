import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:lionsapp/Widgets/burgermenu.dart';
import 'package:lionsapp/Widgets/bottomNavigationView.dart';
import 'package:lionsapp/Screens/events/create_event.dart';

import '../Widgets/appbar.dart';

class Calendar extends StatefulWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  void _handleAddEvent() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CreateEvent()),
    );
  }

  final EventController _eventController = EventController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const BurgerMenu(),
      appBar: MyAppBar(title: "Kalender"),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const BottomNavigation(
        currentPage: "Calendar",
        privilege: "Admin",
      ),
      body: MonthView(controller: _eventController),
      floatingActionButton: FloatingActionButton(
        onPressed: _handleAddEvent,
        child: const Icon(Icons.add),
      ),
    );
  }
}
