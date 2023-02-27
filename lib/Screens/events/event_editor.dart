import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../util/image_upload.dart';

String? _selectedProject;

class EventEditor extends StatefulWidget {
  final String? documentId;

  const EventEditor({super.key, this.documentId});

  @override
  State<EventEditor> createState() => _EventEditorState();
}

class _EventEditorState extends State<EventEditor> {
  final DateFormat dateFormat = DateFormat('dd.MM.yyy');
  final TextEditingController _eventNameController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _eventDescriptionController = TextEditingController();
  final TextEditingController _donationTargetController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _sponsorController = TextEditingController();

  String textValue = 'Privat';
  String eventImgUrl = "";
  String sponsorImgUrl = "";
  bool isSwitched = false;
  late bool _hasDonationTarget = true;
  late bool _hasProject = true;
  late bool _createChat = false;

  void toggleSwitch(bool value) {
    if (isSwitched == false) {
      setState(() {
        isSwitched = true;
        textValue = 'Öffentlich';
      });
    } else {
      setState(() {
        isSwitched = false;
        textValue = 'Privat';
      });
    }
  }

  void _handleSubmit() {
    if (_eventNameController.text.isEmpty) {
      print("EventName empty");
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      final DateTime? startDate, endDate;
      if (_startDateController.text.isNotEmpty) {
        startDate = dateFormat.parse(_startDateController.text);
      } else {
        startDate = null;
      }
      if (_endDateController.text.isNotEmpty) {
        endDate = dateFormat.parse(_endDateController.text);
      } else {
        endDate = null;
      }
      final collection = FirebaseFirestore.instance.collection('events');
      final String userId = FirebaseAuth.instance.currentUser!.uid;
      final event = {
        'startDate': startDate,
        'endDate': endDate,
        'eventInfo': _eventDescriptionController.text,
        'spendenZiel': _hasDonationTarget ? _donationTargetController.text : null,
        'ort': _locationController.text,
        'chat': _createChat,
        'projekt': _hasProject ? _selectedProject : null,
        'eventName': _eventNameController.text,
        'image_url': eventImgUrl,
        'sponsor': _sponsorController.text,
        'sponsor_img_url': sponsorImgUrl,
        'creator': userId
      };
      if (widget.documentId == null) {
        collection.add(event);
      } else {
        collection.doc(widget.documentId).set(event);
      }
      Navigator.pop(context);
    }
  }

  void _handleEventImageUpload() async {
    final XFile? file = await ImageUpload.selectImage();
    if (file != null) {
      final String uniqueFilename = DateTime.now().millisecondsSinceEpoch.toString();
      final String? imgUrl = await ImageUpload.uploadImage(file, "event_images", "", uniqueFilename);
      if (imgUrl != null) {
        setState(() {
          eventImgUrl = imgUrl;
        });
      }
    }
  }

  void _handleSponsorImageUpload() async {
    final XFile? file = await ImageUpload.selectImage();
    if (file != null) {
      final String uniqueFilename = DateTime.now().millisecondsSinceEpoch.toString();
      final String? imgUrl = await ImageUpload.uploadImage(file, "sponsor_images", "", uniqueFilename);
      if (imgUrl != null) {
        setState(() {
          sponsorImgUrl = imgUrl;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.documentId == null) return;
    FirebaseFirestore.instance.collection("events").doc(widget.documentId).get().then((project) {
      _eventNameController.text = project.get("eventName");
      _eventDescriptionController.text = project.get("eventInfo") ?? "";
      _donationTargetController.text = project.get("spendenZiel") ?? "";
      _locationController.text = project.get("ort") ?? "";
      if (project.data()!.containsKey("sponsor")) {
        _sponsorController.text = project.get("sponsor") ?? "";
      }
      if (project.get("startDate") != null) {
        _startDateController.text = dateFormat.format((project.get("startDate") as Timestamp).toDate());
      }
      if (project.get("endDate") != null) {
        _endDateController.text = dateFormat.format((project.get("endDate") as Timestamp).toDate());
      }
      setState(() {
        if (project.data()!.containsKey("image_url")) {
          eventImgUrl = project.get("image_url");
        }
        if (project.data()!.containsKey("sponsor_img_url")) {
          sponsorImgUrl = project.get("sponsor_img_url");
        }
        _createChat = project.get("chat");
        _hasDonationTarget = project.get("spendenZiel").toString().isNotEmpty;
        _selectedProject = project.get("projekt");
        _hasProject = _selectedProject != null && _selectedProject!.isNotEmpty;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.documentId == null ? "Event anlegen" : "Event bearbeiten"),
        ),
        body: SingleChildScrollView(
          child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  SizedBox(
                      height: 200,
                      width: double.infinity,
                      child: GestureDetector(
                          onTap: _handleEventImageUpload,
                          child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                  width: 1,
                                  color: Colors.grey,
                                  style: BorderStyle.solid,
                                ),
                              ),
                              child: eventImgUrl.isNotEmpty
                                  ? Image.network(eventImgUrl)
                                  : Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: const [Icon(Icons.upload, size: 48), Text("Bild auswählen")])))),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _eventNameController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Name',
                        floatingLabelBehavior: FloatingLabelBehavior.always),
                  ),
                  const SizedBox(height: 16),

                  // TODO: actually do something with the Toggle state ^^
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        child: Switch(
                          value: isSwitched,
                          onChanged: toggleSwitch,
                          activeTrackColor: Colors.yellow,
                          activeColor: Colors.orangeAccent,
                        ),
                      ),
                      Text(
                        textValue,
                        style: const TextStyle(fontSize: 18),
                      )
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          controller: _startDateController,
                          decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.calendar_today),
                              labelText: "Start",
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              border: OutlineInputBorder()),
                          readOnly: false,
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2101));
                            if (pickedDate != null) {
                              //print(pickedDate);
                              String formattedStartDate = DateFormat('dd.MM.yyyy').format(pickedDate);
                              //print(formattedStartDate);
                              setState(() {
                                _startDateController.text = formattedStartDate;
                              });
                            }
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextField(
                          controller: _endDateController,
                          decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.calendar_today),
                              labelText: "Ende",
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              border: OutlineInputBorder()),
                          readOnly: false,
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2101));
                            if (pickedDate != null) {
                              //print(pickedDate);
                              String formattedStartDate = DateFormat('dd.MM.yyyy').format(pickedDate);
                              //print(formattedStartDate);
                              setState(() {
                                _endDateController.text = formattedStartDate;
                              });
                            }
                          },
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _locationController,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.location_on),
                        border: OutlineInputBorder(),
                        labelText: 'Ort',
                        floatingLabelBehavior: FloatingLabelBehavior.always),
                    autofocus: false,
                    maxLines: null,
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                      height: 150,
                      width: double.infinity,
                      child: TextField(
                        controller: _eventDescriptionController,
                        minLines: null,
                        maxLines: null,
                        expands: true,
                        textAlign: TextAlign.start,
                        textAlignVertical: TextAlignVertical.top,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Beschreibung',
                            floatingLabelBehavior: FloatingLabelBehavior.always),
                      )),
                  const SizedBox(height: 16),
                  Row(
                    children: <Widget>[
                      SizedBox(
                          width: 135,
                          child: CheckboxListTile(
                            title: const Text("Ziel"),
                            value: _hasDonationTarget,
                            onChanged: (bool? value) {
                              setState(() {
                                _hasDonationTarget = value!;
                              });
                            },
                          )),
                      const SizedBox(width: 16),
                      Expanded(
                          child: _hasDonationTarget
                              ? TextField(
                                  inputFormatters: [CurrencyTextInputFormatter(locale: 'eu', symbol: '€')],
                                  controller: _donationTargetController,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Ziel',
                                      floatingLabelBehavior: FloatingLabelBehavior.always),
                                )
                              : Container()),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: <Widget>[
                      SizedBox(
                          width: 135,
                          child: CheckboxListTile(
                            title: const Text("Zweck"),
                            value: _hasProject,
                            onChanged: (bool? value) {
                              setState(() {
                                _hasProject = value!;
                              });
                            },
                          )),
                      const SizedBox(width: 16),
                      Expanded(child: _hasProject ? const ProjectDropdown() : Container()),
                    ],
                  ),
                  CheckboxListTile(
                    title: Text("Chat erstellen:"),
                    value: _createChat,
                    onChanged: (bool? value) {
                      setState(() {
                        _createChat = value!;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _sponsorController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Sponsor',
                        floatingLabelBehavior: FloatingLabelBehavior.always),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                      height: 200,
                      width: double.infinity,
                      child: GestureDetector(
                          onTap: _handleSponsorImageUpload,
                          child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                  width: 1,
                                  color: Colors.grey,
                                  style: BorderStyle.solid,
                                ),
                              ),
                              child: sponsorImgUrl.isNotEmpty
                                  ? Image.network(sponsorImgUrl)
                                  : Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: const [Icon(Icons.upload, size: 48), Text("Bild auswählen")])))),
                  const SizedBox(height: 16),
                  SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: _handleSubmit,
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
                              Icon(Icons.save),
                              SizedBox(width: 4),
                              Text("Speichern", style: TextStyle(fontSize: 18))
                            ]),
                          ))),
                ],
              )),
        ));
  }
}

const snackBar = SnackBar(
  content: Text("Bitte einen Eventnamen eingeben"),
);

class ProjectDropdown extends StatefulWidget {
  const ProjectDropdown({super.key});

  @override
  _ProjectDropdownState createState() => _ProjectDropdownState();
}

class _ProjectDropdownState extends State<ProjectDropdown> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('projects').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Container(); // Rückgabe eines leeren Containers
        }
        List<DropdownMenuItem> projectItems = [];
        for (var doc in snapshot.data!.docs) {
          projectItems.add(DropdownMenuItem(
            value: doc['name'],
            child: Row(
              children: [
                const Icon(Icons.check_circle_outline),
                const SizedBox(width: 10.0),
                Text(doc['name']),
              ],
            ),
          ));
        }

        if (_selectedProject != null && !snapshot.data!.docs.map((doc) => doc["name"]).contains(_selectedProject)) {
          _selectedProject = null;
        }

        return DropdownButtonFormField(
          value: _selectedProject,
          decoration: const InputDecoration(
              labelText: "Zweck", floatingLabelBehavior: FloatingLabelBehavior.always, border: OutlineInputBorder()),
          onChanged: (value) {
            setState(() {
              _selectedProject = value;
            });
          },
          items: projectItems,
        );
      },
    );
  }
}
