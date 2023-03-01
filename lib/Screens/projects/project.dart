import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lionsapp/Screens/projects/project_editor.dart';

import '../../Widgets/privileges.dart';
import '../../util/color.dart';
import '../donation.dart';

class Project extends StatefulWidget {
  final String? documentId;

  const Project({super.key, this.documentId});

  @override
  State<Project> createState() => _ProjectState();
}

class _ProjectState extends State<Project> {
  final TextStyle _headlineStyle = const TextStyle(fontWeight: FontWeight.bold, fontSize: 18);
  final TextStyle _textStyle = const TextStyle(fontSize: 16);

  void _handleEdit() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => ProjectEditor(documentId: widget.documentId)));
  }

  void _handleDelete() {
    final collection = FirebaseFirestore.instance.collection("projects");
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Projekt löschen'),
          content: const Text('Sind Sie sich sicher, dass Sie dieses Projekt löschen möchten?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Abbrechen'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
                child: const Text('Löschen'),
                onPressed: () {
                  collection.doc(widget.documentId).delete().then((_) {
                    Navigator.of(context).pop();
                    Navigator.pop(context);
                  });
                }),
          ],
        );
      },
    );
  }

  void _handleDonation() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Donations(projectId: widget.documentId)));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance.collection('projects').doc(widget.documentId).snapshots(),
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

        final String title = data['name'] ?? "";
        final String? imgUri = data['image_url'] ?? "";
        final String background = data['background'] ?? "";
        final String support = data['support'] ?? "";
        final bool showEditButton = Privileges.privilege == "Admin";

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
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              if (imgUri != null && imgUri.isNotEmpty)
                Image.network(imgUri, width: double.infinity, height: 250, fit: BoxFit.cover),
              Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Hintergrund", style: _headlineStyle),
                      const SizedBox(height: 4),
                      Text(background, style: _textStyle),
                      const SizedBox(height: 16),
                      Text("Unsere Unterstützung", style: _headlineStyle),
                      const SizedBox(height: 4),
                      Text(support, style: _textStyle),
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
      },
    );
  }
}
