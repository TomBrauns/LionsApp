import 'dart:io';

import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:lionsapp/Widgets/burgermenu.dart';
import 'package:intl/date_time_patterns.dart';

//Firebase integration
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:lionsapp/main.dart';

import 'package:path/path.dart';


const List<String> list = <String>['Diese','Liste','wird','aus','der','Datenbank','gefüttert'];

String _dropdownValue = list.first;


class CreateEvent extends StatefulWidget {
  const CreateEvent({Key? key}) : super(key: key);

  @override
  State<CreateEvent> createState() => _CreateEvent();
}

class _CreateEvent extends State<CreateEvent> {
  TextEditingController _startDateController = TextEditingController();
  TextEditingController _endDateController = TextEditingController();

  TextEditingController _eventInfoController = TextEditingController();

  TextEditingController _spendenzielController = TextEditingController();

  TextEditingController _addressController = TextEditingController();

  bool _createChat = false;
  
  bool _spendenZielErforderlich = false;

  String? _selectedProject;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const BurgerMenu(),
      appBar: AppBar(
        title: const Text("Event erstellen"),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              Row(
                children: <Widget>[
                  Container(
                    child: Text("Spendenziel im Event anzeigen: "),
                  ),
                  Container(
                    child: Checkbox(
                      checkColor: Colors.white,
                      value: _spendenZielErforderlich,
                      onChanged: (bool? value){
                        setState(() {
                          _spendenZielErforderlich = value!;
                        });
                      },
                    ),
                  )
                  ],
              ),
            if(_spendenZielErforderlich)
              Container(
                child: Row(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width / 2 - 40,
                      padding: EdgeInsets.all(10),
                      child: const Text(
                        'Spendenziel festlegen: '
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 2 - 40,
                      child: TextField(
                        inputFormatters: [CurrencyTextInputFormatter(
                          locale: 'eu',
                          symbol: '€'
                        )],
                        keyboardType: TextInputType.number,
                        controller: _spendenzielController,
                      ),
                    ),
                  ],
                )
              ),
            Row(
              children: <Widget>[
                Container(
                    width: MediaQuery.of(context).size.width / 2 - 40,
                    child: TextField(
                      controller: _startDateController,
                      decoration: const InputDecoration(
                          icon: Icon(Icons.calendar_today),
                          labelText: "Startdatum"),
                      readOnly: false,
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101));
                        if (pickedDate != null) {
                          print(pickedDate);
                          String formattedStartDate =
                              DateFormat('dd.MM.yyyy').format(pickedDate);
                          print(formattedStartDate);
                          setState(() {
                            _startDateController.text = formattedStartDate;
                          });
                        } else {
                          print("Kein Datum ausgewählt");
                        }
                      },
                    )),
                Container(
                  width: MediaQuery.of(context).size.width / 2 - 40,
                  child: TextField(
                    controller: _endDateController,
                    decoration: const InputDecoration(
                        icon: Icon(Icons.calendar_today),
                        labelText: "Enddatum"),
                    readOnly: false,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101));
                      if (pickedDate != null) {
                        String formattedEndDate =
                            DateFormat('dd.MM.yyyy').format(pickedDate);

                        setState(() {
                          _endDateController.text = formattedEndDate;
                        });
                      } else {
                        print("Kein Datum ausgewählt");
                      }
                    },
                  ),
                ),
              ],

            ),
            Center(
              child: Container(
                padding: EdgeInsets.all(30.0),
                child: Text("Projekt, für welches Geld gesammelt wird:"),
              )
            ),
            Center(
              child: Text("Hier kommt das bessere Dropdown hin"),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              child: ProjectDropdown(),
            ),
            const Center(
              child: Text('Ort:'),

            ),
            Center(
              child: Container(
                padding: EdgeInsets.all(30),
                child: TextField(
                  controller: _addressController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Ort eingeben'
                  ),
                ),
              ),
            ),
            Center(
              child: Row(
                  children: <Widget>[
                    Container(
                        child: Text("Chat erstellen?")
                    ),
                    Container(
                        child: Checkbox(
                          checkColor: Colors.white,
                          value: _createChat,
                          onChanged: (bool? value){
                            setState(() {
                              _createChat = value!;
                            });
                          },
                        )
                    )
                  ]
              ),
            ),
            Center(
              child: Container(
                padding: EdgeInsets.all(30.0),
                  child: Text("Informationen zum Event:")
              )
            ),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              reverse: true,
              child: TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Information eintragen',
                ),
                controller: _eventInfoController,
                maxLines: null,
                keyboardType: TextInputType.multiline,
              )
            ),
            Center(
              child:
                ElevatedButton(
                  onPressed: () {

                    FirebaseFirestore db = FirebaseFirestore.instance;

                    FirebaseFirestore.instance.collection('events').add({
                      'startDate':_startDateController.text,
                      'endDate':_endDateController.text,
                      'eventInfo':_eventInfoController.text,
                      'spendenZiel':_spendenzielController.text,
                      'ort':_addressController.text,
                      'chat':_createChat,
                      'projekt':_dropdownValue
                    });
                   },
                  child:
                  Text('Event anlegen'),
                ),
            ),
          ],
        ),
      ),
    );
  }
}


class ProjectDropdown extends StatefulWidget{
  @override
  _ProjectDropdownState createState() => _ProjectDropdownState();

}

class _ProjectDropdownState extends State<ProjectDropdown> {
  String? _selectedProject;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('projects').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Container(); // Rückgabe eines leeren Containers
        }

        List<DropdownMenuItem> projectItems = [];
        snapshot.data!.docs.forEach((doc) {
          projectItems.add(DropdownMenuItem(
            value: doc['name'],
            child: Row(
              children: [
                Icon(Icons.check_circle_outline),
                SizedBox(width: 10.0),
                Text(doc['name']),
              ],
            ),
          ));
        });

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Select a project:'),
            DropdownButton(
              hint: Text('Select a project'),
              value: _selectedProject,
              onChanged: (value) {
                setState(() {
                  _selectedProject = value;
                });
              },
              items: projectItems,
            ),
          ],
        );
      },
    );
  }
}