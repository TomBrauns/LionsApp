import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lionsapp/Screens/generateQR/generateqr.dart';
import 'package:lionsapp/Widgets/burgermenu.dart';
import 'package:lionsapp/Screens/events/event_details_page.dart';
import 'package:lionsapp/Screens/events/event_editor.dart';
import 'package:lionsapp/Widgets/bottomNavigationView.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:lionsapp/Widgets/privileges.dart';

import 'package:lionsapp/Screens/generateQR/generateqreventlist.dart';
import '../../Widgets/appbar.dart';
import '../../util/color.dart';

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
      MaterialPageRoute(builder: (context) => const EventEditor()),
    );
  }

  // FAB with Priviledge
  //Copy that
  Widget? _getFAB() {
    if (Privileges.privilege == Privilege.admin ||
        Privileges.privilege == Privilege.member) {
      return FloatingActionButton(
        mini: true,
        onPressed: () => _handleAddEvent(),
        backgroundColor: ColorUtils.secondaryColor,
        child: const Icon(Icons.add),
      );
    } else {
      return null;
    }
  }

  // and use Function for Fab in Scaffold

  // BAB with Priviledge
  //Copy that
  Widget? _getBAB() {
    if (Privileges.privilege == Privilege.admin ||
        Privileges.privilege == Privilege.member ||
        Privileges.privilege == Privilege.friend) {
      return BottomNavigation();
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Aktivitäten"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.qr_code),
            onPressed: (){
              print("Link aufrufen");
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      QrCodeEventList(link: 'serviceclub-app.de/#/Events'),
                ),
              );
            },
          ),
          IconButton(
            padding: const EdgeInsets.only(right: 20),
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.pop(context);
              if (Privileges.privilege == Privilege.admin ||
                  Privileges.privilege == Privilege.member ||
                  Privileges.privilege == Privilege.friend) {
                Navigator.pushNamed(context, '/User');
              } else {
                Navigator.pushNamed(context, '/Login');
              }
            },
          ),
        ],
      ),
      //appBar: const MyAppBar(title: "Aktivitäten"),
      drawer: const BurgerMenu(),
      body: const EventList(),
      bottomNavigationBar: _getBAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _getFAB(),
    );
  }
}

class EventList extends StatefulWidget {
  const EventList({super.key});

  @override
  State<EventList> createState() => _EventListState();
}

class _EventListState extends State<EventList> {
  final dateFormat = DateFormat("dd. MMM yyyy");
  late Stream<QuerySnapshot> _eventsStream;
  late String _searchQuery;

  @override
  void initState() {
    super.initState();
    _searchQuery = '';
    _eventsStream = FirebaseFirestore.instance.collection('events').orderBy("startDate").snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            onChanged: (value) {
              setState(() {
                _searchQuery = value;
              });
            },
            decoration:
                const InputDecoration(hintText: 'Suchen', border: OutlineInputBorder(), prefixIcon: Icon(Icons.search)),
          ),
        ),
        Expanded(
            child: StreamBuilder<QuerySnapshot>(
                stream: _eventsStream,
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

                  final filteredEvents = snapshot.data!.docs.where((event) => event['eventName'].toLowerCase().contains(_searchQuery.toLowerCase()));

                  return ListView.builder(
                    itemCount: filteredEvents.length,
                    itemBuilder: (BuildContext context, int index) {
                      final event = filteredEvents.elementAt(index);
                      final String eventId = event.id;

                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EventDetailsPage(eventId: eventId),
                            ),
                          );
                        },
                        child: GestureDetector(
                          onLongPress: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    QrCodeWithImage(link: 'serviceclub-app.de/#/Donations', documentId: eventId),
                              ),
                            );
                          },
                          child: Container(
                            clipBehavior: Clip.hardEdge,
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: ColorUtils.secondaryColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: SizedBox(
                              height: 128,
                              width: double.infinity,
                              child: Row(
                                children: [
                                  if (event["image_url"] != null && (event["image_url"] as String).isNotEmpty)
                                    CircleAvatar(
                                      radius: 50,
                                      backgroundImage: NetworkImage(event["image_url"]),
                                    )
                                  else
                                    Container(width: 128, height: 128, color: Colors.grey),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Flexible(
                                          child: FittedBox(
                                            fit:BoxFit.fitWidth,
                                              child: Text(event['eventName'],
                                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 50, color: ColorUtils.primaryColor),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              )

                                          )

                                        ),

                                       // if (event["eventInfo"] != null)
                                       //   Text(event['eventInfo'], maxLines: 3, overflow: TextOverflow.ellipsis),
                                        Expanded(child: Container()),
                                        if (event["ort"] != null)
                                          Row(children: [
                                            const Icon(Icons.location_on, size: 30, color: ColorUtils.primaryColor,),
                                            const SizedBox(width: 6),
                                            Expanded(
                                              child: Text(
                                                event['ort'],
                                                style: const TextStyle(fontSize: 20, color: ColorUtils.primaryColor),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            )
                                          ]),
                                        if (event["startDate"] != null)
                                          Row(children: [
                                            const Icon(Icons.calendar_month, size: 30, color: ColorUtils.primaryColor),
                                            const SizedBox(width: 6),
                                            Expanded(
                                                child: Text(
                                                  dateFormat.format((event['startDate'] as Timestamp).toDate()),
                                                  style: const TextStyle(fontSize: 20, color: ColorUtils.primaryColor),
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                )
                                            ),
                                          ]),
                                        const SizedBox(height: 4),

                                      ],
                                    ),

                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                      );
                    },
                  );
                })),
      ],
    );
  }
}
