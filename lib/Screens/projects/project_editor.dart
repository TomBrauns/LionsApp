//Licensed under the EUPL v.1.2 or later
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lionsapp/Screens/projects/project.dart';
import 'package:lionsapp/Widgets/textSize.dart';
import 'package:lionsapp/util/image_upload.dart';
import '../events/event_details_page.dart';
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
  String imgUrl = "";

  void _handleCategoryChange(String? category) {
    selectedCategory = category ?? selectedCategory;
  }

  void _handleUpload() async {
    final XFile? file = await ImageUpload.selectImage();
    if (file != null) {
      final String uniqueFilename =
          DateTime.now().millisecondsSinceEpoch.toString();
      final String? imgUrl = await ImageUpload.uploadImage(
          file, "project_images", "", uniqueFilename);
      if (imgUrl != null) {
        setState(() {
          this.imgUrl = imgUrl;
        });
      }
    }
  }

  void _handleSubmit() async {
    final name = _nameInputController.value.text;
    final background = _backgroundInputController.value.text;
    final support = _supportInputController.value.text;
    final String? projectId;
    if (name.isEmpty || background.isEmpty || support.isEmpty) {
      return;
    } else {
      final collection = FirebaseFirestore.instance.collection("projects");
      if (widget.documentId == null) {
        final createdEvent = await collection.add({
          'name': name,
          'background': background,
          'support': support,
          'category': selectedCategory,
          'image_url': imgUrl,
        });
        projectId = createdEvent.id;
      } else {
        collection.doc(widget.documentId).set({
          'name': name,
          'background': background,
          'support': support,
          'category': selectedCategory,
          'image_url': imgUrl,
        });
        projectId = widget.documentId;
      }
      SchedulerBinding.instance.addPostFrameCallback((_) {
        Navigator.pop(context);
        if (widget.documentId == null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Project(documentId: projectId!),
            ),
          );
        }
      });
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
                if (project.data()!.containsKey("image_url")) {
                  imgUrl = project.get("image_url");
                }
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
        body: SingleChildScrollView(
            child: Container(
                padding: const EdgeInsets.all(16),
                child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                            height: 200,
                            width: double.infinity,
                            child: GestureDetector(
                                onTap: _handleUpload,
                                child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(
                                        width: 1,
                                        color: Colors.grey,
                                        style: BorderStyle.solid,
                                      ),
                                    ),
                                    child: imgUrl.isNotEmpty
                                        ? Image.network(imgUrl)
                                        : Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                                Icon(Icons.upload, size: 48),
                                                Text("Bild auswählen",
                                                    style: CustomTextSize.small)
                                              ])))),
                        const SizedBox(height: 16),
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
                                          Text(c.name,
                                              style: CustomTextSize.small)
                                        ],
                                      ))))
                              .toList(),
                          onChanged: _handleCategoryChange,
                          decoration: const InputDecoration(
                              labelText: "Kategorie",
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              border: OutlineInputBorder()),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                            controller: _nameInputController,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Projektname",
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always)),
                        const SizedBox(height: 16),
                        SizedBox(
                            height: 150,
                            width: double.infinity,
                            child: TextFormField(
                                controller: _backgroundInputController,
                                minLines: null,
                                maxLines: null,
                                expands: true,
                                textAlign: TextAlign.start,
                                textAlignVertical: TextAlignVertical.top,
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: "Hintergrund",
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always))),
                        const SizedBox(height: 16),
                        SizedBox(
                            height: 150,
                            width: double.infinity,
                            child: TextFormField(
                                controller: _supportInputController,
                                minLines: null,
                                maxLines: null,
                                expands: true,
                                textAlign: TextAlign.start,
                                textAlignVertical: TextAlignVertical.top,
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: "Unsere Unterstützung",
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always))),
                        const SizedBox(height: 16),
                        SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                                onPressed: _handleSubmit,
                                child: Container(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.save),
                                        SizedBox(width: 4),
                                        Text("Speichern",
                                            style: CustomTextSize.medium)
                                      ]),
                                ))),
                      ],
                    )))));
  }
}
