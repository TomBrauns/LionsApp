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
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _eventInfoController = TextEditingController();
  final TextEditingController _spendenzielController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _eventNameController = TextEditingController();

  bool _createChat = false;

  bool _spendenZielErforderlich = false;

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
        body:
        Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: <Widget>[
                  const Text("Spendenziel im Event anzeigen: "),
                  Checkbox(
                    checkColor: Colors.white,
                    value: _spendenZielErforderlich,
                    onChanged: (bool? value){
                      setState(() {
                        _spendenZielErforderlich = value!;
                      });
                    },
                  )
                ],
              ),
              if(_spendenZielErforderlich)
                Row(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width / 2 - 40,
                      padding: const EdgeInsets.all(10),
                      child: const Text(
                          'Spendenziel festlegen: '
                      ),
                    ),
                    SizedBox(
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
                ),
              Row(
                children: <Widget>[
                  SizedBox(
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
                            //print(pickedDate);
                            String formattedStartDate =
                            DateFormat('dd.MM.yyyy').format(pickedDate);
                            //print(formattedStartDate);
                            setState(() {
                              _startDateController.text = formattedStartDate;
                            });
                          }
                        },
                      )),
                  SizedBox(
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
                        }
                      },
                    ),
                  ),
                ],

              ),
              Center(
                child: TextField(
                  controller: _eventNameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Eventname eingeben",
                  ),
                ),
              ),
              Center(
                  child: Container(
                    padding: const EdgeInsets.all(30.0),
                    child: const Text("Projekt, für welches Geld gesammelt wird:"),
                  )
              ),
              Container(
                padding: const EdgeInsets.all(10.0),
                child: const ProjectDropdown(),
              ),
              const Center(
                child: Text('Ort:'),

              ),
              Center(
                child: Container(
                  padding: const EdgeInsets.all(30),
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
                      const Text("Chat erstellen?"),
                      Checkbox(
                        checkColor: Colors.white,
                        value: _createChat,
                        onChanged: (bool? value){
                          setState(() {
                            _createChat = value!;
                          });
                        },
                      )
                    ]
                ),
              ),
              Center(
                  child: Container(
                      padding: const EdgeInsets.all(30.0),
                      child: const Text("Informationen zum Event:")
                  )
              ),
              Expanded(
                child:
                SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    reverse: true,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Information eintragen',
                      ),
                      validator: (value){
                        if(value == null ||value.isEmpty){
                          return 'Dieses Feld ist ein Pflichtfeld';
                        }
                      },
                      controller: _eventInfoController,
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                    )
                ),
              ),
              Center(
                child:
                ElevatedButton(
                  onPressed: () {

                    DateTime startDate = DateFormat('dd.MM.yyy').parse(_startDateController.text);
                    DateTime endDate = DateFormat('dd.MM.yyy').parse(_endDateController.text);

                    print(endDate);

                    FirebaseFirestore.instance.collection('events').add({
                      'startDate':startDate,
                      'endDate':endDate,
                      'eventInfo':_eventInfoController.text,
                      'spendenZiel':_spendenzielController.text,
                      'ort':_addressController.text,
                      'chat':_createChat,
                      'projekt': _selectedProject,
                      'eventName':_eventNameController.text,
                    });

                    Navigator.pop(
                        context
                    );
                  },
                  child:
                  const Text('Event anlegen'),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}

class ProjectDropdown extends StatefulWidget{
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