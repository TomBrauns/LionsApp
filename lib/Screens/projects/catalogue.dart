import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lionsapp/Screens/projects/project_editor.dart';
import 'package:lionsapp/Screens/projects/project.dart';
import 'package:lionsapp/Widgets/burgermenu.dart';
import 'package:lionsapp/Widgets/bottomNavigationView.dart';
import 'package:lionsapp/Widgets/privileges.dart';

import '../../Widgets/appbar.dart';
import '../../util/color.dart';

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

  // FAB with Priviledge
  //Copy that
  Widget? _getFAB() {
    if (Privileges.privilege == "Admin") {
      return FloatingActionButton(
        backgroundColor: ColorUtils.secondaryColor,
        onPressed: () => _handleAddProject(),
        child: const Icon(Icons.add),
      );
    } else {
      return null;
    }
  }
  // and use Function for Fab in Scaffold

  // BAB with Privilege
  //Copy that
  Widget? _getBAB() {
    if (Privileges.privilege == "Admin" ||
        Privileges.privilege == "Member" ||
        Privileges.privilege == "Friend") {
      return BottomNavigation();
    } else {
      return null;
    }
  }
  // and use Function for Fab in Scaffold

  /*void _handleProjectClicked() {


    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Project()),
    );
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const BurgerMenu(),
      appBar: MyAppBar(title: "Katalog"),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _getFAB(),
      bottomNavigationBar: _getBAB(),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('projects')
              .orderBy('category')
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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

            final List<Widget> categoryWidgets = groupedData.entries
                .map((MapEntry<String, List<DocumentSnapshot>> entry) {
              final String category = entry.key;
              final List<DocumentSnapshot> documents = entry.value;

              final List<Widget> documentWidgets =
                  documents.map((DocumentSnapshot document) {
                //print(document.id);
                return ListTile(
                    leading: const SizedBox(),
                    title: Text(document.get('name')),
                    subtitle: Text(document.get('support'), maxLines: 3, overflow: TextOverflow.ellipsis),
                    onTap: () {
                      String documentId = document.id;
                      print(documentId);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  Project(documentId: documentId)));

                      //_handleProjectClicked;
                    });
              }).toList();
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ListTile(
                    leading: Image.asset('assets/projects/$category.png',
                        width: 32, height: 32),
                    title: Text(category),
                  ),
                  ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: documentWidgets,
                  ),
                  const Divider(indent: 68),
                ],
              );
            }).toList();

            return ListView(
              children: categoryWidgets,
            );
          }),
    );
  }
}
