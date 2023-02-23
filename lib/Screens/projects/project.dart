import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lionsapp/Screens/projects/project_editor.dart';

import '../donation.dart';

class Project extends StatelessWidget {
  final String documentId;

  final TextStyle _headlineStyle =
      const TextStyle(fontWeight: FontWeight.bold, fontSize: 18);
  final TextStyle _textStyle = const TextStyle(fontSize: 16);

  const Project({super.key, required this.documentId});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('projects')
          .doc(documentId)
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
        Map<String, dynamic> data =
            snapshot.data!.data() as Map<String, dynamic>;

        final String title = data['name'];
        final String? imgUri = data['image_url'];
        final String background = data['background'];
        final String support = data['support'];

        return Scaffold(
            appBar: AppBar(
              title: Text(title),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ProjectEditor(documentId: documentId)));
              },
              child: const Icon(Icons.edit),
            ),
            body: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if(imgUri != null && imgUri.isNotEmpty)
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
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          Donations(interneId: documentId)));
                            },
                            child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 6.0, horizontal: 4.0),
                                child: Text("Spenden",
                                    style: TextStyle(fontSize: 22))),
                          )),
                          const SizedBox(height: 32),
                        ],
                      ))
                ])));
      },
    );
  }
}
