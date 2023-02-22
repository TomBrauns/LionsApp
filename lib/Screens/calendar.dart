import 'package:calendar_view/calendar_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lionsapp/Widgets/burgermenu.dart';
import 'package:lionsapp/Widgets/bottomNavigationView.dart';
import 'package:lionsapp/Screens/events/create_event.dart';

import '../Widgets/appbar.dart';
import 'events/event_details_page.dart';

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
  void initState() {
    super.initState();
    FirebaseFirestore.instance.collection('events').get().then((snapshot) => {
          _eventController.addAll(snapshot.docs
              .map((event) => CalendarEventData(
                  event: event.id,
                  title: event.get("eventName"),
                  description: event.get("eventInfo"),
                  startTime: (event.get("startDate") as Timestamp).toDate(),
                  endTime: (event.get("endDate") as Timestamp).toDate(),
                  date: (event.get("startDate") as Timestamp).toDate(),
                  endDate: (event.get("endDate") as Timestamp).toDate()))
              .toList())
        });
  }

  final List<String> views = ["Monat", "Woche", "Tag"];
  late String currentView = views[0];

  void _handleViewChange(String? view) {
    setState(() {
      currentView = view ?? currentView;
    });
  }

  void _handleEventClicked(CalendarEventData<Object?> event) {
    final String eventId = event.event as String;
    print(eventId);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EventDetailsPage(eventId: eventId),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const BurgerMenu(),
      appBar: const MyAppBar(title: "Kalender"),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const BottomNavigation(
        currentPage: "Calendar",
        privilege: "Admin",
      ),
      body: Column(children: [
        DropdownButtonFormField(
          value: currentView,
          items: views
              .map<DropdownMenuItem<String>>(
                  ((c) => DropdownMenuItem(value: c, child: Text(c))))
              .toList(),
          onChanged: _handleViewChange,
          decoration: const InputDecoration(border: OutlineInputBorder()),
        ),
        if (currentView == "Monat")
          Expanded(
              child: MonthView(
                  controller: _eventController,
                  onEventTap: (e, d) => _handleEventClicked(e))),
        if (currentView == "Woche")
          Expanded(
              child: WeekView(
                  controller: _eventController,
                  onEventTap: (e, d) => _handleEventClicked(e.first))),
        if (currentView == "Tag")
          Expanded(
              child: DayView(
                  controller: _eventController,
                  onEventTap: (e, d) => _handleEventClicked(e.first)))
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: _handleAddEvent,
        child: const Icon(Icons.add),
      ),
    );
  }
}
