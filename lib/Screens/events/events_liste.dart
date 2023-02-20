import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lionsapp/Widgets/burgermenu.dart';
import 'package:lionsapp/Screens/events/event_details_page.dart';
import 'package:lionsapp/Screens/events/create_event.dart';
import 'package:lionsapp/Widgets/bottomNavigationView.dart';

import '../../Widgets/appbar.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Events"),
      drawer: const BurgerMenu(),
      body: EventList(),

      //Alter ListView von Nico

      /*body: ListView(
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
              .toList()),*/
      bottomNavigationBar: const BottomNavigation(
        currentPage: "Events",
        privilege: "Admin",
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: _handleAddEvent,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class EventList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('events').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return ListView.builder(
          itemCount: snapshot.data!.size,
          itemBuilder: (BuildContext context, int index) {
            final event = snapshot.data!.docs[index];
            final String eventId = event.id;

            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EventDetailsPage(eventId: eventId),
                  ),
                );
              },
              child: Card(
                child: ListTile(
                  title: Text(event['eventName']),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(event['eventInfo']),
                      const SizedBox(height: 4),
                      Row(children: [
                        const Icon(Icons.location_on, size: 16),
                        Text(event['ort']),
                      ]),
                      const SizedBox(height: 4),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
