//Licensed under the EUPL v.1.2 or later
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lionsapp/util/color.dart';
import '../../Widgets/privileges.dart';
import '../../Widgets/textSize.dart';
import 'meeting_editor.dart';
import 'package:url_launcher/url_launcher.dart';

class MeetingDetailsPage extends StatefulWidget {
  const MeetingDetailsPage({Key? key, required this.meetingId})
      : super(key: key);

  final String meetingId;

  @override
  State<MeetingDetailsPage> createState() => _MeetingDetailsPageState();
}

class _MeetingDetailsPageState extends State<MeetingDetailsPage> {
  final dateFormat = DateFormat("dd.MM.yyyy HH:mm");

  // Style
  final TextStyle _headlineStyle =
      const TextStyle(fontWeight: FontWeight.bold, fontSize: 18);
  final TextStyle _textStyle = CustomTextSize.small;

  void _handleEdit() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MeetingEditor(meetingId: widget.meetingId)));
  }

  void _handleDelete() {
    final collection = FirebaseFirestore.instance.collection("meetings");
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Meeting löschen', style: CustomTextSize.medium),
          content: Text(
              'Sind Sie sich sicher, dass Sie dieses Meeting löschen möchten?',
              style: CustomTextSize.small),
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
                  collection.doc(widget.meetingId).delete().then((_) {
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
            .collection('meetings')
            .doc(widget.meetingId)
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
          final String title = data['name'] ?? "";
          final String location = data['location'] ?? "";
          if (data["startDate"] != null) {
            date = dateFormat.format((data['startDate'] as Timestamp).toDate());
          } else {
            date = "";
          }
          final String url = data['url'] ?? "";
          final String description = data['description'] ?? "";
          final String creatorId = data['creator'] ?? "";

          // Condition for showing the edit button: user must be member + creator OR user must be admin
          final String? userId = FirebaseAuth.instance.currentUser?.uid;
          final bool showEditButton = userId != null &&
                  (Privileges.privilege == Privilege.member &&
                      creatorId == userId) ||
              Privileges.privilege == Privilege.admin;

          return Scaffold(
              appBar: AppBar(
                title: Text(title),
              ),
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
                        ])
                  : null,
              body: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                                  const Icon(
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
                            const SizedBox(height: 16),
                            Text("Was machen wir?", style: _headlineStyle),
                            const SizedBox(height: 4),
                            Text(description, style: _textStyle),
                            const SizedBox(height: 4),
                            if (url.isNotEmpty)
                              TextButton(
                                  onPressed: () async {
                                    if (await canLaunchUrl(Uri.parse(url))) {
                                      await launchUrl(Uri.parse(url));
                                    }
                                  },
                                  child: Text("Link zum Online-Meeting",
                                      style: _textStyle)),
                            const SizedBox(height: 32),
                          ],
                        ))
                  ])));
        });
  }
}
