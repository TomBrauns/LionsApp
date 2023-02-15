import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lionsapp/Widgets/burgermenu.dart';
import 'package:intl/date_time_patterns.dart';

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
                    child: Text(
                      'Spendenziel festlegen: '
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 2 - 40,
                    child: TextField(
                      controller: _spendenzielController,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.euro),
                      ),
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
              child: DropdownButtonExample(),
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
                  // TODO Dem Button noch eine passende Funktionalität zuweisen
                  onPressed: () {  },
                  child:
                  Text('Event anlegen'),
                )

            )
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
