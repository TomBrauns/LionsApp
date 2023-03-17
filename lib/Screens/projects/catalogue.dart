//Licensed under the EUPL v.1.2 or later
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
  late Stream<QuerySnapshot> _projectsStream;
  late String _searchQuery;

  @override
  void initState() {
    super.initState();
    _searchQuery = '';
    _projectsStream =
        FirebaseFirestore.instance.collection('projects').snapshots();
  }

  void _handleAddProject() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ProjectEditor()),
    );
  }

  // FAB with Priviledge
  //Copy that
  Widget? _getFAB() {
    if (Privileges.privilege == Privilege.admin) {
      return FloatingActionButton(
        mini: true,
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
    if (Privileges.privilege == Privilege.admin ||
        Privileges.privilege == Privilege.member ||
        Privileges.privilege == Privilege.friend) {
      return BottomNavigation();
    } else {
      return null;
    }
  }

  void _handleProjectClicked(String projectId) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Project(documentId: projectId)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const BurgerMenu(),
        appBar: const MyAppBar(title: "Projekte"),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: _getFAB(),
        bottomNavigationBar: _getBAB(),
        body: Column(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: const InputDecoration(
                  hintText: 'Suchen',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.search)),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
                stream: _projectsStream,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
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
                  for (final document in snapshot.data!.docs) {
                    if (document
                        .get("name")
                        .toString()
                        .toLowerCase()
                        .contains(_searchQuery.toLowerCase())) {
                      final String category =
                          document.get('category') ?? 'Other';
                      if (groupedData.containsKey(category)) {
                        groupedData[category]!.add(document);
                      } else {
                        groupedData[category] = [document];
                      }
                    }
                  }

                  final List<Widget> categoryWidgets = groupedData.entries
                      .map((MapEntry<String, List<DocumentSnapshot>> entry) {
                    final String category = entry.key;
                    final List<DocumentSnapshot> documents = entry.value;

                    final List<Widget> documentWidgets = documents.map((DocumentSnapshot document) {
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0), // Add some padding
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[200], // Set the background color
                                borderRadius: BorderRadius.circular(10.0), // Add rounded corners
                              ),
                              child: ListTile(
                                leading: const SizedBox(),
                                title: Text(document.get('name')),
                                subtitle: Text(document.get('support'), maxLines: 3, overflow: TextOverflow.ellipsis),
                                onTap: () => _handleProjectClicked(document.id),
                                trailing: const Icon(Icons.arrow_forward_ios),
                              ),
                            ),
                          ),
                          const Divider(height: 2.0), // Add a Divider between each ListTile
                        ],
                      );
                    }).toList();
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                          child: Container(
                            // Add some padding
                            decoration: BoxDecoration(
                              color: ColorUtils.secondaryColor, // Set the background color
                              borderRadius: BorderRadius.circular(10.0), // Add rounded corners
                            ),
                            child: ListTile(
                              leading: Image.asset('assets/projects/$category.png', width: 32, height: 32),
                              title: Text(
                                category,
                                style: const TextStyle(
                                  color: Colors.white, // Set the text color
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8.0), // Add some spacing
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
          )
        ]));
  }
}
