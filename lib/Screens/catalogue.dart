import 'package:flutter/material.dart';
import 'package:lionsapp/Screens/project.dart';
import 'package:lionsapp/Widgets/burgermenu.dart';

class Catalogue extends StatefulWidget {
  const Catalogue({Key? key}) : super(key: key);

  @override
  State<Catalogue> createState() => _CatalogueState();
}

class Category {
  final String name, path;

  const Category(this.name, this.path);
}

class _CatalogueState extends State<Catalogue> {
  // TODO fetch this
  static const categories = [
    Category("Sehkrafterhaltung", "projects/vision.png"),
    Category("Kinderkrebshilfe", "projects/childhoodcancer.png"),
    Category("Umweltschutz", "projects/environment.png"),
    Category("Humanitäre Hilfe", "projects/humanitarian.png"),
    Category("Hungerhilfe", "projects/hunger.png"),
    Category("Diabeteshilfe", "projects/diabetes.png"),
    Category("Katastrophenhilfe", "projects/disaster.png"),
    Category("Jugendförderung", "projects/youth.png")
  ];

  void _handleAddProject() {
    // TODO Add a new project as Admin
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
      body: ListView(
        children: categories
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
            .toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _handleAddProject,
        child: const Icon(Icons.add),
      ),
    );
  }
}
