import 'package:flutter/material.dart';
import 'package:lionsapp/widgets/burgermenu.dart';

class Project extends StatefulWidget {
  const Project({Key? key}) : super(key: key);

  @override
  State<Project> createState() => _ProjectState();
}

class _ProjectState extends State<Project> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Projekt XYZ"),
      ),
      body: const Text("Hier folgt die Projektseite"),
    );
  }
}
