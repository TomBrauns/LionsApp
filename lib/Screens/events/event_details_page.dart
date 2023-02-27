import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lionsapp/Screens/donation.dart';
import '../../Widgets/privileges.dart';
import 'event_editor.dart';

class EventDetailsPage extends StatefulWidget {
  const EventDetailsPage({Key? key, required this.eventId}) : super(key: key);

  final String eventId;

  @override
  State<EventDetailsPage> createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends State<EventDetailsPage> {
  final dateFormat = DateFormat("dd.MM.yyyy HH:mm");

  // Style
  final TextStyle _headlineStyle = const TextStyle(fontWeight: FontWeight.bold, fontSize: 18);
  final TextStyle _textStyle = const TextStyle(fontSize: 16);

  void _handleDonation() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Donations(interneId: widget.eventId)));
  }

  void _handleEdit() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => EventEditor(documentId: widget.eventId)));
  }

  void _handleDelete() {
    FirebaseFirestore.instance.collection("events").doc(widget.eventId).delete().then((_) {
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection('events').doc(widget.eventId).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Fehler beim Lesen der Daten');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final Map<String, dynamic> data;
          if (snapshot.data != null && snapshot.data!.exists) {
            data = snapshot.data!.data() as Map<String, dynamic>;
          } else {
            data = {};
          }

          final String date;
          final String title = data['eventName'] ?? "";
          final String location = data['ort'] ?? "";
          if (data["startDate"] != null) {
            date = dateFormat.format((data['startDate'] as Timestamp).toDate());
          } else {
            date = "";
          }
          final String project = data['projekt'] ?? "";
          final String target = data['spendenZiel'] ?? "";
          final String imgUri = data['image_url'] ?? "";
          final String description = data['eventInfo'] ?? "";
          final String creatorId = data['creator'] ?? "";

          // Condition for showing the edit button: user must be member + creator OR user must be admin
          final String userId = FirebaseAuth.instance.currentUser!.uid;
          final bool showEditButton = (Privileges.privilege == "Member" && creatorId == userId) || Privileges.privilege == "Admin";

          return Scaffold(
              appBar: AppBar(
                title: Text(title),
              ),
              floatingActionButton: showEditButton
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                          FloatingActionButton(onPressed: _handleDelete, child: const Icon(Icons.delete)),
                          const SizedBox(height: 16),
                          FloatingActionButton(onPressed: _handleEdit, child: const Icon(Icons.edit)),
                        ])
                  : null,
              body: SingleChildScrollView(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                if (imgUri.isNotEmpty) Image.network(imgUri, width: double.infinity, height: 250, fit: BoxFit.cover),
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
                            subtitle: Text(date, maxLines: 1),
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
                            subtitle: Text(location, maxLines: 1),
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
                            subtitle: Text(project, maxLines: 1),
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
                            subtitle: Text(target, maxLines: 1),
                          ))),
                        ]),
                        const SizedBox(height: 16),
                        Text("Was machen wir?", style: _headlineStyle),
                        const SizedBox(height: 4),
                        Text(description, style: _textStyle),
                        const SizedBox(height: 32),
                        Center(
                            child: ElevatedButton(
                          onPressed: _handleDonation,
                          child: const Padding(
                              padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 4.0),
                              child: Text("Spenden", style: TextStyle(fontSize: 22))),
                        )),
                        const SizedBox(height: 32),
                      ],
                    ))
              ])));
        });
  }
}
