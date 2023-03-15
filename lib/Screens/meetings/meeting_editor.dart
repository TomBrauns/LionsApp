//Licensed under the EUPL v.1.2 or later
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lionsapp/Screens/meetings/meeting.dart';

import '../../Widgets/textSize.dart';
import '../../util/image_upload.dart';

class MeetingEditor extends StatefulWidget {
  final String? meetingId;

  const MeetingEditor({super.key, this.meetingId});

  @override
  State<MeetingEditor> createState() => _MeetingEditorState();
}

class _MeetingEditorState extends State<MeetingEditor> {
  final DateFormat dateFormat = DateFormat('dd.MM.yyyy HH:mm');
  final TextEditingController _meetingNameController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _meetingDescriptionController =
      TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _urlController = TextEditingController();

  void _handleSubmit() async {
    if (_meetingNameController.text.isEmpty) {
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
      final collection = FirebaseFirestore.instance.collection('meetings');
      final String userId = FirebaseAuth.instance.currentUser!.uid;
      final String? meetingId;
      final meeting = {
        'startDate': startDate,
        'endDate': endDate,
        'description': _meetingDescriptionController.text,
        'location': _locationController.text,
        'name': _meetingNameController.text,
        'url': _urlController.text,
        'creator': userId,
      };
      if (widget.meetingId == null) {
        final createdMeeting = await collection.add(meeting);
        meetingId = createdMeeting.id;
      } else {
        await collection.doc(widget.meetingId).set(meeting);
        meetingId = widget.meetingId;
      }
      SchedulerBinding.instance.addPostFrameCallback((_) {
        Navigator.pop(context);
        if (widget.meetingId == null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MeetingDetailsPage(meetingId: meetingId!),
            ),
          );
        }
      });
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
              showTimePicker(
                      context: context,
                      initialTime:
                          currentTime ?? const TimeOfDay(hour: 15, minute: 0))
                  .then((pickedTime) {
                if (pickedDate != null && pickedTime != null) {
                  final Duration duration = Duration(
                      hours: pickedTime.hour, minutes: pickedTime.minute);
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
              showTimePicker(
                      context: context,
                      initialTime:
                          currentTime ?? const TimeOfDay(hour: 18, minute: 0))
                  .then((pickedTime) {
                if (pickedDate != null && pickedTime != null) {
                  final Duration duration = Duration(
                      hours: pickedTime.hour, minutes: pickedTime.minute);
                  final DateTime completeDate = pickedDate.add(duration);
                  _endDateController.text = dateFormat.format(completeDate);
                }
              })
            });
  }

  @override
  void initState() {
    super.initState();
    if (widget.meetingId == null) return;
    FirebaseFirestore.instance
        .collection("meetings")
        .doc(widget.meetingId)
        .get()
        .then((project) {
      _meetingNameController.text = project.get("name");
      _meetingDescriptionController.text = project.get("description") ?? "";
      _urlController.text = project.get("url") ?? "";
      _locationController.text = project.get("location") ?? "";
      if (project.get("startDate") != null) {
        _startDateController.text =
            dateFormat.format((project.get("startDate") as Timestamp).toDate());
      }
      if (project.get("endDate") != null) {
        _endDateController.text =
            dateFormat.format((project.get("endDate") as Timestamp).toDate());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.meetingId == null
              ? "Meeting erstellen"
              : "Meeting bearbeiten"),
        ),
        body: SingleChildScrollView(
          child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  TextField(
                    controller: _meetingNameController,
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
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
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
                        controller: _meetingDescriptionController,
                        minLines: null,
                        maxLines: null,
                        expands: true,
                        textAlign: TextAlign.start,
                        textAlignVertical: TextAlignVertical.top,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Beschreibung',
                            floatingLabelBehavior:
                                FloatingLabelBehavior.always),
                      )),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _urlController,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.group),
                        border: OutlineInputBorder(),
                        labelText: 'Link',
                        floatingLabelBehavior: FloatingLabelBehavior.always),
                    autofocus: false,
                    maxLines: null,
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: _handleSubmit,
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.save),
                                  SizedBox(width: 4),
                                  Text("Speichern",
                                      style: CustomTextSize.medium)
                                ]),
                          ))),
                ],
              )),
        ));
  }
}

final snackBar = SnackBar(
  content: Text("Bitte einen Name eingeben.", style: CustomTextSize.small),
);
