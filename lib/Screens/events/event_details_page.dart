//Licensed under the EUPL v.1.2 or later
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lionsapp/Screens/donation.dart';
import 'package:lionsapp/util/textSize.dart';
import 'package:lionsapp/util/color.dart';
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
  final TextStyle _headlineStyle =
      const TextStyle(fontWeight: FontWeight.bold, fontSize: 18);
  final TextStyle _textStyle = CustomTextSize.small;

  void _handleDonation() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Donations(eventId: widget.eventId)));
  }

  void _handleEdit() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EventEditor(documentId: widget.eventId)));
  }

  void _handleDelete() {
    final collection = FirebaseFirestore.instance.collection("events");
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Aktivität löschen', style: CustomTextSize.medium),
          content: Text(
              'Sind Sie sich sicher, dass Sie diese Aktivität löschen möchten?',
              style: CustomTextSize.medium),
          actions: <Widget>[
            TextButton(
              child: Text('Abbrechen', style: CustomTextSize.small),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
                child: Text('Löschen', style: CustomTextSize.small),
                onPressed: () {
                  collection.doc(widget.eventId).delete().then((_) {
                    Navigator.of(context).pop();
                    Navigator.pop(context);
                  });
                }),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('events')
            .doc(widget.eventId)
            .snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
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
          final String? userId = FirebaseAuth.instance.currentUser?.uid;
          final bool showEditButton = userId != null &&
                  (Privileges.privilege == Privilege.member &&
                      creatorId == userId) ||
              Privileges.privilege == Privilege.admin;

          return Scaffold(
              appBar: AppBar(
                title: Text(title, style: CustomTextSize.medium),
              ),
              //actionbutton position for non super users
              floatingActionButtonLocation:
                  Privileges.privilege == Privilege.admin ||
                          Privileges.privilege == Privilege.member
                      ? FloatingActionButtonLocation.endFloat
                      : FloatingActionButtonLocation.centerDocked,
              floatingActionButton: showEditButton
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                          FloatingActionButton(
                            onPressed: _handleDelete,
                            backgroundColor: ColorUtils.secondaryColor,
                            child: const Icon(Icons.delete),
                          ),
                          const SizedBox(height: 16),
                          FloatingActionButton(
                            onPressed: _handleEdit,
                            backgroundColor: ColorUtils.secondaryColor,
                            child: const Icon(Icons.edit),
                          ),
                          const SizedBox(height: 16),
                          FloatingActionButton.extended(
                            onPressed: _handleDonation,
                            backgroundColor: ColorUtils.secondaryColor,
                            label: Text("Spenden", style: CustomTextSize.small),
                          )
                        ])
                  //actionbutton position for normal users
                  : FloatingActionButton.extended(
                      onPressed: _handleDonation,
                      backgroundColor: ColorUtils.secondaryColor,
                      label: Text("Spenden", style: CustomTextSize.small),
                    ),
              body: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    if (imgUri.isNotEmpty)
                      Image.network(imgUri,
                          width: double.infinity,
                          height: 250,
                          fit: BoxFit.cover),
                    Container(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(children: [
                              Expanded(
                                  child: Card(
                                      child: ListTile(
                                title: Row(children: [
                                  Icon(
                                    Icons.calendar_month,
                                    size: 16,
                                    color: Colors.black,
                                  ),
                                  Text("Datum", style: CustomTextSize.medium)
                                ]),
                                subtitle: Text(date,
                                    maxLines: 1, style: CustomTextSize.medium),
                              ))),
                              Expanded(
                                  child: Card(
                                      child: ListTile(
                                title: Row(children: [
                                  Icon(
                                    Icons.location_on,
                                    size: 16,
                                    color: Colors.black,
                                  ),
                                  Text("Ort", style: CustomTextSize.medium)
                                ]),
                                subtitle: Text(location,
                                    maxLines: 1, style: CustomTextSize.medium),
                              ))),
                            ]),
                            Row(children: [
                              Expanded(
                                  child: Card(
                                      child: ListTile(
                                title: Row(children: [
                                  Icon(
                                    Icons.supervised_user_circle,
                                    size: 16,
                                    color: Colors.black,
                                  ),
                                  Text("Projekt", style: CustomTextSize.medium)
                                ]),
                                subtitle: Text(project,
                                    maxLines: 1, style: CustomTextSize.medium),
                              ))),
                              Expanded(
                                  child: Card(
                                      child: ListTile(
                                title: Row(children: [
                                  Icon(
                                    Icons.crisis_alert,
                                    size: 16,
                                    color: Colors.black,
                                  ),
                                  Text("Ziel", style: CustomTextSize.medium)
                                ]),
                                subtitle: Text(target,
                                    maxLines: 1, style: CustomTextSize.medium),
                              ))),
                            ]),
                            const SizedBox(height: 16),
                            Text("Was machen wir?", style: _headlineStyle),
                            const SizedBox(height: 4),
                            Text(description, style: _textStyle),
                            const SizedBox(height: 32),
                          ],
                        ))
                  ])));
        });
  }
}
