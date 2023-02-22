import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//Firebase integration
import 'package:cloud_firestore/cloud_firestore.dart';

String? _selectedProject;

class CreateEvent extends StatefulWidget {
  const CreateEvent({Key? key}) : super(key: key);

  @override
  State<CreateEvent> createState() => _CreateEvent();
}

class _CreateEvent extends State<CreateEvent> {
  final TextEditingController _eventName = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _eventDescription = TextEditingController();
  final TextEditingController _spendenzielController = TextEditingController();
  final TextEditingController _location = TextEditingController();

  var textValue = 'Privat';
  bool isSwitched = false;
  late bool _spendenzielAnzeigen = true;
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: Scaffold(
            appBar: AppBar(
              title: const Text("Event erstellen"),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                      padding: const EdgeInsets.all(8),
                      child: TextField(
                        controller: _eventName,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Eventname eingeben'),
                      )),
                  const SizedBox(height: 10),

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
                      Container(
                          child: Text(
                        '$textValue',
                        style: TextStyle(fontSize: 18),
                      ))
                    ],
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Expanded(
                          child: Container(
                              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
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
                                    //print(pickedDate);
                                    String formattedStartDate =
                                        DateFormat('dd.MM.yyyy')
                                            .format(pickedDate);
                                    //print(formattedStartDate);
                                    setState(() {
                                      _startDateController.text =
                                          formattedStartDate;
                                    });
                                  }
                                },
                              )),
                        ),
                        Expanded(
                          child: Container(
                              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                              child: TextField(
                                controller: _endDateController,
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
                                    //print(pickedDate);
                                    String formattedStartDate =
                                        DateFormat('dd.MM.yyyy')
                                            .format(pickedDate);
                                    //print(formattedStartDate);
                                    setState(() {
                                      _startDateController.text =
                                          formattedStartDate;
                                    });
                                  }
                                },
                              )),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: TextField(
                      controller: _eventDescription,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Eventbeschreibung eingeben'),
                      autofocus: false,
                      maxLines: null,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ProjectDropdown(),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Expanded(
                            child: Container(
                                child: CheckboxListTile(
                          title: Text("Spendenziel anzeigen:"),
                          value: _spendenzielAnzeigen,
                          onChanged: (bool? value) {
                            setState(() {
                              _spendenzielAnzeigen = value!;
                            });
                          },
                        ))),
                        if (_spendenzielAnzeigen)
                          Expanded(
                              child: Container(
                            padding: const EdgeInsets.all(8),
                            child: TextField(
                              inputFormatters: [
                                CurrencyTextInputFormatter(
                                    locale: 'eu', symbol: '€')
                              ],
                              controller: _spendenzielController,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Spendenziel'),
                            ),
                          )),
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: TextField(
                      controller: _location,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Ort eingeben'),
                      autofocus: false,
                      maxLines: null,
                    ),
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
                  ElevatedButton(
                    child: Text("Event erstellen"),
                    onPressed: () {
                      if (_eventName.text.isEmpty) {
                        print("EventName empty");
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else {
                        DateTime startDate = DateFormat('dd.MM.yyy')
                            .parse(_startDateController.text);
                        DateTime endDate = DateFormat('dd.MM.yyy')
                            .parse(_endDateController.text);

                        FirebaseFirestore.instance.collection('events').add({
                          'startDate': startDate,
                          'endDate': endDate,
                          'eventInfo': _eventDescription.text,
                          'spendenZiel': _spendenzielController.text,
                          'ort': _location.text,
                          'chat': _createChat,
                          'projekt': _selectedProject,
                          'eventName': _eventName.text,
                        });

                        Navigator.pop(context);
                      }
                    },
                  )
                ],
              ),
            )));
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

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButton(
              hint: const Text('Projekt auswählen'),
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
