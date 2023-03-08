import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lionsapp/Screens/events/event_details_page.dart';
import 'package:lionsapp/Widgets/textSize.dart';
import 'package:lionsapp/util/color.dart';
import 'package:cloud_functions/cloud_functions.dart' as functions;

import '../../util/image_upload.dart';

String _selectedProject = "";

class EventEditor extends StatefulWidget {
  final String? documentId;

  const EventEditor({super.key, this.documentId});

  @override
  State<EventEditor> createState() => _EventEditorState();
}

class _EventEditorState extends State<EventEditor> {
  final DateFormat dateFormat = DateFormat('dd.MM.yyyy HH:mm');
  final TextEditingController _eventNameController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _eventDescriptionController = TextEditingController();
  final TextEditingController _donationTargetController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _sponsorController = TextEditingController();

  String eventImgUrl = "";
  String sponsorImgUrl = "";
  String? chatRoomId;
  late bool _createChat = false;

  void _handleSubmit() async {
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
      final String? roomId;
      if (widget.documentId == null) {
        if (_createChat) {
          final Room room = await FirebaseChatCore.instance.createGroupRoom(
            imageUrl: eventImgUrl,
            name: _eventNameController.text,
            users: [],
            metadata: {"Beschreibung": "Chatraum für ${_eventNameController.text}"},
          );
          roomId = room.id;
        } else {
          roomId = null;
        }
      } else {
        roomId = chatRoomId;
      }
      final collection = FirebaseFirestore.instance.collection('events');
      final String userId = FirebaseAuth.instance.currentUser!.uid;
      final String? eventId;
      final event = {
        'startDate': startDate,
        'endDate': endDate,
        'eventInfo': _eventDescriptionController.text,
        'spendenZiel': _donationTargetController.text,
        'ort': _locationController.text,
        'chat_room': roomId,
        'projekt': _selectedProject,
        'eventName': _eventNameController.text,
        'image_url': eventImgUrl,
        'sponsor': _sponsorController.text,
        'sponsor_img_url': sponsorImgUrl,
        'creator': userId,
        'currentDonationValue': 0,
      };
      if (widget.documentId == null) {
        final createdEvent = await collection.add(event);
        eventId = createdEvent.id;
      } else {
        await collection.doc(widget.documentId).set(event);
        eventId = widget.documentId;
      }
      SchedulerBinding.instance.addPostFrameCallback((_) {
        Navigator.pop(context);
        if (widget.documentId == null) {
          final functions.HttpsCallable sendNotification =
              functions.FirebaseFunctions.instance.httpsCallable('sendNotification');
          try {
            sendNotification({
              'title': _eventNameController.text,
              'body': _eventDescriptionController.text,
            });
          } catch (e) {
            print('Error sending notification: $e');
          }
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EventDetailsPage(eventId: eventId!),
            ),
          );
        }
      });
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

  void _handleStartTimeTap() {
    final DateTime? currentDateTime;
    final TimeOfDay? currentTime;
    if (_startDateController.text.isNotEmpty) {
      currentDateTime = dateFormat.parse(_startDateController.text);
      currentTime = TimeOfDay.fromDateTime(currentDateTime);
    } else {
      currentDateTime = null;
      currentTime = null;
    }
    showDatePicker(
            context: context,
            initialDate: currentDateTime ?? DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime(2100))
        .then((pickedDate) => {
              showTimePicker(context: context, initialTime: currentTime ?? const TimeOfDay(hour: 15, minute: 0))
                  .then((pickedTime) {
                if (pickedDate != null && pickedTime != null) {
                  final Duration duration = Duration(hours: pickedTime.hour, minutes: pickedTime.minute);
                  final DateTime completeDate = pickedDate.add(duration);
                  _startDateController.text = dateFormat.format(completeDate);
                }
              })
            });
  }

  void _handleEndTimeTap() {
    final DateTime? currentDateTime, currentStartDate;
    final TimeOfDay? currentTime;
    if (_endDateController.text.isNotEmpty) {
      currentDateTime = dateFormat.parse(_endDateController.text);
      currentTime = TimeOfDay.fromDateTime(currentDateTime);
    } else {
      currentDateTime = null;
      currentTime = null;
    }
    if (_startDateController.text.isNotEmpty) {
      currentStartDate = dateFormat.parse(_startDateController.text);
    } else {
      currentStartDate = null;
    }
    showDatePicker(
            context: context,
            initialDate: currentDateTime ?? currentStartDate ?? DateTime.now(),
            firstDate: currentStartDate ?? DateTime(2020),
            lastDate: DateTime(2100))
        .then((pickedDate) => {
              showTimePicker(context: context, initialTime: currentTime ?? const TimeOfDay(hour: 18, minute: 0))
                  .then((pickedTime) {
                if (pickedDate != null && pickedTime != null) {
                  final Duration duration = Duration(hours: pickedTime.hour, minutes: pickedTime.minute);
                  final DateTime completeDate = pickedDate.add(duration);
                  _endDateController.text = dateFormat.format(completeDate);
                }
              })
            });
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
        if (project.data()!.containsKey("chat_room")) {
          chatRoomId = project.get("chat_room");
        }
        _selectedProject = project.get("projekt") ?? "";
      });
    });
  }

  void showSuccessSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Chat erfolgreich erstellt'),
        backgroundColor: ColorUtils.primaryColor,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(top: 64),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.documentId == null ? "Aktivität erstellen" : "Aktivität bearbeiten"),
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
                                      children: [
                                          Icon(Icons.upload, size: 48),
                                          Text("Bild auswählen", style: CustomTextSize.small),
                                        ])))),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _eventNameController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Name',
                        floatingLabelBehavior: FloatingLabelBehavior.always),
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
                          onTap: _handleStartTimeTap,
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
                        onTap: _handleEndTimeTap,
                      ))
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
                  TextField(
                    inputFormatters: [CurrencyTextInputFormatter(locale: 'eu', symbol: '€')],
                    controller: _donationTargetController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Ziel',
                        floatingLabelBehavior: FloatingLabelBehavior.always),
                  ),
                  const SizedBox(height: 16),
                  const ProjectDropdown(),
                  if (widget.documentId == null)
                    CheckboxListTile(
                      title: Text("Chat erstellen:", style: CustomTextSize.small),
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
                                      children: [
                                          const Icon(Icons.upload, size: 48),
                                          Text("Bild auswählen", style: CustomTextSize.small)
                                        ])))),
                  const SizedBox(height: 16),
                  SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {
                            _handleSubmit();
                            if (_createChat == true) {
                              print("worked");
                              showSuccessSnackbar(context);
                              // call the function
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                              const Icon(Icons.save),
                              const SizedBox(width: 4),
                              Text("Speichern", style: CustomTextSize.small)
                            ]),
                          ))),
                ],
              )),
        ));
  }
}

final snackBar = SnackBar(
  content: Text("Bitte einen Eventnamen eingeben", style: CustomTextSize.small),
  backgroundColor: Colors.red,
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
          return Container(); // If the snap doesnt have any Data, an empty container is returned.
        }
        List<DropdownMenuItem> projectItems = [
          DropdownMenuItem(
              value: "",
              child: Row(
                children: const [Text("Kein Projekt ausgewählt")],
              ))
        ];
        for (var doc in snapshot.data!.docs) {
          projectItems.add(DropdownMenuItem(
            value: doc['name'],
            child: Row(
              children: [
                Image.asset("assets/projects/${doc["category"]}.png", width: 24, height: 24),
                const SizedBox(width: 10.0),
                Text(doc['name']),
              ],
            ),
          ));
        }

        if (!snapshot.data!.docs.map((doc) => doc["name"]).contains(_selectedProject)) {
          _selectedProject = "";
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
