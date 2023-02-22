import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'category.dart';

class ProjectEditor extends StatefulWidget {
  final String? documentId;

  const ProjectEditor({super.key, this.documentId});

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
    if (name.isEmpty || background.isEmpty || support.isEmpty) {
      return;
    } else {
      final collection = FirebaseFirestore.instance.collection("projects");
      if (widget.documentId == null) {
        collection.add({
          'name': name,
          'background': background,
          'support': support,
          'category': selectedCategory
        });
      } else {
        collection.doc(widget.documentId).set({
          'name': name,
          'background': background,
          'support': support,
          'category': selectedCategory
        });
      }
      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.documentId == null) return;
    FirebaseFirestore.instance
        .collection("projects")
        .doc(widget.documentId)
        .get()
        .then((project) => {
              _nameInputController.text = project.get("name"),
              _supportInputController.text = project.get("support"),
              _backgroundInputController.text = project.get("background"),
              setState(() {
                selectedCategory = project.get("category");
              })
            });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.documentId == null
              ? "Projekt anlegen"
              : "Projekt bearbeiten"),
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
                          .map<DropdownMenuItem<String>>(
                              ((c) => DropdownMenuItem(
                                  value: c.name,
                                  child: Row(
                                    children: [
                                      Image.asset(c.path,
                                          width: 24, height: 24),
                                      const SizedBox(width: 8),
                                      Text(c.name)
                                    ],
                                  ))))
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
                    Expanded(
                        child: TextFormField(
                            controller: _backgroundInputController,
                            minLines: null,
                            maxLines: null,
                            expands: true,
                            textAlign: TextAlign.start,
                            textAlignVertical: TextAlignVertical.top,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "Hintergrund"))),
                    const SizedBox(height: 8),
                    Expanded(
                        child: TextFormField(
                            controller: _supportInputController,
                            minLines: null,
                            maxLines: null,
                            expands: true,
                            textAlign: TextAlign.start,
                            textAlignVertical: TextAlignVertical.top,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "Unsere Unterstützung"))),
                    const SizedBox(height: 16),
                    SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: _handleSubmit,
                            child: Container(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(Icons.save),
                                    SizedBox(width: 4),
                                    Text("Speichern",
                                        style: TextStyle(fontSize: 18))
                                  ]),
                            ))),
                  ],
                ))));
  }
}
