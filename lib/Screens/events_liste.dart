import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lionsapp/Widgets/burgermenu.dart';
import 'package:lionsapp/Screens/event.dart';
import 'package:lionsapp/Screens/events/create_event.dart';

class Events extends StatefulWidget {
  const Events({super.key});

  @override
  State<Events> createState() => _EventsState();
}

class EventEntry {
  final String title, description, location;
  final DateTime date;

  EventEntry(this.title, this.description, this.location, this.date);
}

class _EventsState extends State<Events> {
  void _handleAddEvent() {
  Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => const CreateEvent()),
  );
  }
  static var events = [
    EventEntry(
        "Martini-Konzert",
        "Die Einnahmen vom Konzert werden an das Kinderhospiz in Worms gespendet. Es sollen ingesamt 10.000€ erzielt werden.",
        "Festplatz Worms",
        DateTime.now()),
    EventEntry(
        "Golf spielen",
        "Die Einnahmen werden an die Organisation XYZ gespendet. Hier folgt noch eine weitere Kurzbeschreibung.",
        "Golfplatz Kaiserslautern",
        DateTime.now()),
    EventEntry(
        "Konzert 2",
        "Die Einnahmen werden gespendet an das Deutsche Rote Kreuz. Hier folgt noch eine weitere Kurzbeschreibung.",
        "Oper Kaiserslautern",
        DateTime.now())
  ];

  void _handleEventClicked(EventEntry e) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Event()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Events"),
        ),
        drawer: const BurgerMenu(),
        body: ListView(
            children: events
                .map((e) => Card(
                    child: ListTile(
                        onTap: () => _handleEventClicked(e),
                        title: Text(e.title),
                        subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(e.description),
                              const SizedBox(height: 4),
                              Row(children: [
                                const Icon(Icons.location_on, size: 16),
                                Text(e.location),
                              ]),
                              const SizedBox(height: 4),
                              Row(children: [
                                const Icon(Icons.calendar_month, size: 16),
                                Text(DateFormat("d. MMM y").format(e.date))
                              ]),
                            ]))))
                .toList()),

      floatingActionButton: FloatingActionButton(
      onPressed: _handleAddEvent,
      child: const Icon(Icons.add),
    ),);
  }
}
