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

class EventList extends StatefulWidget{
  @override
  State<EventList> createState() => _EventListState();
}

class _EventListState extends State<EventList>{

  late Stream<QuerySnapshot> _eventsStream;
  late String _searchQuery;

  @override
  void initState() {
    super.initState();
    _searchQuery = '';
    _eventsStream = FirebaseFirestore.instance.collection('events').snapshots();
  }

  @override
  Widget build(BuildContext context){
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            onChanged: (value){
              setState(() {
                _searchQuery = value;
              });
            },
            decoration: const InputDecoration(
              hintText: 'Event suchen',
            ),
          ),
        ),
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: _eventsStream,
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
              if(snapshot.hasError){
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              }

              if(snapshot.connectionState == ConnectionState.waiting){
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              final filteredEvents = snapshot.data!.docs.where((event) => event['eventName'].toLowerCase().contains(_searchQuery.toLowerCase()));

              return ListView.builder(
                itemCount: filteredEvents.length,
                itemBuilder: (BuildContext context, int index){
                  final event = filteredEvents.elementAt(index);
                  final String eventId = event.id;

                  return GestureDetector(
                    onTap: (){
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
                      )
                    )
                  );
                },
              );
            }
          )
        )
      ],
    );
  }
}

