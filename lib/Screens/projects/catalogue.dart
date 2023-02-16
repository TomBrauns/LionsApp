import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lionsapp/Screens/projects/project_editor.dart';
import 'package:lionsapp/Screens/projects/project.dart';
import 'package:lionsapp/Widgets/burgermenu.dart';
import 'category.dart';
import 'package:lionsapp/Widgets/bottomNavigationView.dart';

class Catalogue extends StatefulWidget {
  const Catalogue({Key? key}) : super(key: key);

  @override
  State<Catalogue> createState() => _CatalogueState();
}

class _CatalogueState extends State<Catalogue> {
  void _handleAddProject() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ProjectEditor()),
    );
  }

  void _handleProjectClicked() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Project()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const BurgerMenu(),
      appBar: AppBar(
        title: const Text("Katalog"),
      ),
      bottomNavigationBar: const BottomNavigation(),
      body:
      StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('projects').orderBy('category').snapshots(),
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

          final Map<String, List<DocumentSnapshot>> groupedData = {};
          snapshot.data!.docs.forEach((DocumentSnapshot document) {
            final String category = document.get('category') ?? 'Other';
            if (groupedData.containsKey(category)) {
              groupedData[category]!.add(document);
            } else {
              groupedData[category] = [document];
            }
          });

          final List<Widget> categoryWidgets = groupedData.entries.map((MapEntry<String, List<DocumentSnapshot>> entry) {

            final String category = entry.key;
            final List<DocumentSnapshot> documents = entry.value;
            final List<Widget> documentWidgets = documents.map((DocumentSnapshot document) {
              return ListTile(
                leading: const SizedBox(),
                title: Text(document.get('name')),
                subtitle: Text(document.get('support')),
                onTap:
                  _handleProjectClicked,
              );
            }).toList();
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ListTile(
                  leading: Image.asset('assets/projects/$category.png', width: 32, height: 32),
                  title: Text(category),
                ),
                ListView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: documentWidgets,
                ),
                Divider(indent: 68),
              ],
            );
          }).toList();

          return ListView(
            children: categoryWidgets,
          );
        }
      ),

      /*ListView(
        children: Category.all
            .map((c) => Column(children: [
                  ListTile(
                      leading: Image.asset(c.path, width: 32, height: 32),
                      title: Text(c.name)),
                  ListTile(
                    onTap: _handleProjectClicked,
                    leading: const SizedBox(),
                    title: const Text("Beispielprojekt 1"),
                    subtitle: const Text(
                        "Das ist ein Projekt für das Spenden gesammelt werden können"),
                  ),
                  ListTile(
                    onTap: _handleProjectClicked,
                    leading: const SizedBox(),
                    title: const Text("Beispielprojekt 2"),
                    subtitle: const Text(
                        "Noch ein tolles Projekt mit einer etwas längeren Beschreibung, um das Layout für ein größeres Item in der Liste zu sehen. Diese Beschreibung ist schon sehr lange."),
                  ),
                  ListTile(
                    onTap: _handleProjectClicked,
                    leading: const SizedBox(),
                    title: const Text("Beispielprojekt 3"),
                    subtitle: const Text("Hier eine Beschreibung"),
                  ),
                  const Divider(indent: 68)
                ]))
            .toList(),*/
      floatingActionButton: FloatingActionButton(
        onPressed: _handleAddProject,
        child: const Icon(Icons.add),
      ),
    );
  }
}
