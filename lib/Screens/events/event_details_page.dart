import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lionsapp/Screens/donation.dart';
import 'package:lionsapp/Screens/events/event_bearbeiten.dart';

class EventDetailsPage extends StatefulWidget {
  const EventDetailsPage({Key? key, required this.eventId}) : super(key: key);

  final String eventId;

  @override
  State<EventDetailsPage> createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends State<EventDetailsPage> {
  final dateFormat = DateFormat("dd.MM.yyyy HH:mm");

  late String _title = "";
  late String _location = "";
  late String _date = "";
  late String _project = "";
  late String _target = "";
  late String _description = "";
  final String _imgUri =
      "assets/events/martini-konzert.jpg"; // TODO Static, solange es noch keine richtige Image Lösung in Firebase integriert ist

  @override
  void initState() {
    _loadEventData();
    super.initState();
  }

  void _loadEventData() async {
    final docSnapshot = await FirebaseFirestore.instance
        .collection('events')
        .doc(widget.eventId)
        .get();

    if (docSnapshot.exists) {
      final data = docSnapshot.data()!;
      setState(() {
        _title = data['eventName'];
        _location = data['ort'];
        _date = dateFormat.format((data['startDate'] as Timestamp).toDate());
        _project = data['projekt'];
        _target = data['spendenZiel'];
        _description = data['eventInfo'];
      });
    }
  }

  // Style
  final TextStyle _headlineStyle =
      const TextStyle(fontWeight: FontWeight.bold, fontSize: 18);
  final TextStyle _textStyle = const TextStyle(fontSize: 16);

  void _handleDonation() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Donations()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_title),
          // TODO Hier müssen noch die Berechtigungen angepasst werden, damit der Edit Button nur von Membern gesehen werden kann
          actions: [
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                print("Icon Button gepressed");
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          EditDocumentPage(documentId: widget.eventId)),
                );
              },
            )
          ],
        ),
        body: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Image.asset(_imgUri,
              width: double.infinity, height: 250, fit: BoxFit.cover),
          Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    Expanded(
                        child: Card(
                            child: ListTile(
                      title: Row(children: const [
                        Icon(
                          Icons.calendar_month,
                          size: 16,
                          color: Colors.black,
                        ),
                        Text("Datum")
                      ]),
                      subtitle: Text(_date, maxLines: 1),
                    ))),
                    Expanded(
                        child: Card(
                            child: ListTile(
                      title: Row(children: const [
                        Icon(
                          Icons.location_on,
                          size: 16,
                          color: Colors.black,
                        ),
                        Text("Ort")
                      ]),
                      subtitle: Text(_location, maxLines: 1),
                    ))),
                  ]),
                  Row(children: [
                    Expanded(
                        child: Card(
                            child: ListTile(
                      title: Row(children: const [
                        Icon(
                          Icons.supervised_user_circle,
                          size: 16,
                          color: Colors.black,
                        ),
                        Text("Zweck")
                      ]),
                      subtitle: Text(_project, maxLines: 1),
                    ))),
                    Expanded(
                        child: Card(
                            child: ListTile(
                      title: Row(children: const [
                        Icon(
                          Icons.crisis_alert,
                          size: 16,
                          color: Colors.black,
                        ),
                        Text("Ziel")
                      ]),
                      subtitle: Text(_target, maxLines: 1),
                    ))),
                  ]),
                  const SizedBox(height: 16),
                  Text("Was machen wir?", style: _headlineStyle),
                  const SizedBox(height: 4),
                  Text(_description, style: _textStyle),
                  const SizedBox(height: 32),
                  Center(
                      child: ElevatedButton(
                    onPressed: _handleDonation,
                    child: const Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 6.0, horizontal: 4.0),
                        child: Text("Spenden", style: TextStyle(fontSize: 22))),
                  )),
                  const SizedBox(height: 32),
                ],
              ))
        ])));
  }
}
