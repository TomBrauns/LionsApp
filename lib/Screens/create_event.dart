import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lionsapp/Widgets/burgermenu.dart';
import 'package:intl/date_time_patterns.dart';

//Firebase integration
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

const List<String> list = <String>['Diese','Liste','wird','aus','der','Datenbank','gefüttert'];


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
            Container(
              padding: const EdgeInsets.symmetric(vertical: 32),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("Spendenziel"),
                    LinearProgressIndicator(value: 0.77, minHeight: 24.0),
                  ]),
            ),
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
            const Center(


            ),
            const Center(
              child: DropdownButtonExample(),
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
                FloatingActionButton(
                  backgroundColor: Colors.green,
                  onPressed: () {

                    FirebaseFirestore db = FirebaseFirestore.instance;

                    FirebaseFirestore.instance.collection('events').add({
                      'startDate':_startDateController.text,
                      'endDate':_endDateController.text,
                      'eventInfo':_eventInfoController.text,
                      'spendenZiel':_spendenzielController.text,
                      'ort':_addressController.text
                    });

                    final cities = db.collection("cities");

                    final data1 = <String, dynamic>{
                      "name": "San Francisco",
                      "state": "CA",
                      "country": "USA",
                      "capital": false,
                      "population": 860000,
                      "regions": ["west_coast", "norcal"]
                    };
                    cities.doc("SF").set(data1);

                    final data2 = <String, dynamic>{
                      "name": "Los Angeles",
                      "state": "CA",
                      "country": "USA",
                      "capital": false,
                      "population": 3900000,
                      "regions": ["west_coast", "socal"],
                    };
                    cities.doc("LA").set(data2);

                    final data3 = <String, dynamic>{
                      "name": "Washington D.C.",
                      "state": null,
                      "country": "USA",
                      "capital": true,
                      "population": 680000,
                      "regions": ["east_coast"]
                    };
                    cities.doc("DC").set(data3);

                    final data4 = <String, dynamic>{
                      "name": "Tokyo",
                      "state": null,
                      "country": "Japan",
                      "capital": true,
                      "population": 9000000,
                      "regions": ["kanto", "honshu"]
                    };
                    cities.doc("TOK").set(data4);

                    final data5 = <String, dynamic>{
                      "name": "Beijing",
                      "state": null,
                      "country": "China",
                      "capital": true,
                      "population": 21500000,
                      "regions": ["jingjinji", "hebei"],
                    };
                    cities.doc("BJ").set(data5);

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

class DropdownButtonExample extends StatefulWidget {
  const DropdownButtonExample({super.key});

  @override
  State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
}


class _DropdownButtonExampleState extends State<DropdownButtonExample>{

  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context){
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? value){
        setState(() {
          dropdownValue = value!;
        });
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}