import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lionsapp/Widgets/burgermenu.dart';

import 'category.dart';

class ProjectEditor extends StatefulWidget {
  const ProjectEditor({Key? key}) : super(key: key);

  @override
  State<ProjectEditor> createState() => _ProjectEditorState();
}

class _ProjectEditorState extends State<ProjectEditor> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameInputController = TextEditingController();
  final TextEditingController _backgroundInputController =
      TextEditingController();
  final TextEditingController _supportInputController = TextEditingController();
  String selectedCategory = Category.all.map((c) => c.name).first;

  void _handleCategoryChange(String? category) {
    selectedCategory = category ?? selectedCategory;
  }

  void _handleSubmit() {
    final name = _nameInputController.value.text;
    final background = _backgroundInputController.value.text;
    final support = _supportInputController.value.text;
    print("category=$selectedCategory, name=$name, background=$background, support=$support");

    if(_nameInputController.text.isEmpty || _backgroundInputController.text.isEmpty || _supportInputController.text.isEmpty){
      return;
    }else{
      FirebaseFirestore db = FirebaseFirestore.instance;

      FirebaseFirestore.instance.collection('projects').add({
        'name': _nameInputController.text,
        'background': _backgroundInputController.text,
        'support': _supportInputController.text,
        'category':selectedCategory
      });

      Navigator.pop(context);
    }


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Projekt anlegen"),
        ),
        body: Container(
            padding: const EdgeInsets.all(16),
            child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DropdownButtonFormField(
                      value: selectedCategory,
                      items: Category.all
                          .map<DropdownMenuItem<String>>(((c) =>
                              DropdownMenuItem(
                                  value: c.name, child: Text(c.name))))
                          .toList(),
                      onChanged: _handleCategoryChange,
                      decoration:
                          const InputDecoration(border: OutlineInputBorder()),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                        controller: _nameInputController,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Bezeichnung")),
                    const SizedBox(height: 8),
                    TextFormField(
                        controller: _backgroundInputController,
                        maxLines: null,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Hintergrund")),
                    const SizedBox(height: 8),
                    TextFormField(
                        controller: _supportInputController,
                        maxLines: null,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Unsere Unterstützung")),
                    const SizedBox(height: 16),
                    SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: _handleSubmit,
                            child: Container(
                                padding: const EdgeInsets.all(8.0),
                                child: const Text("Erstellen",
                                    style: TextStyle(fontSize: 18))))),
                  ],
                ))));
  }
}
