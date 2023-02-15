import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lionsapp/Widgets/burgermenu.dart';
import 'package:intl/date_time_patterns.dart';

class CreateEvent extends StatefulWidget {
  const CreateEvent({Key? key}) : super(key: key);

  @override
  State<CreateEvent> createState() => _CreateEvent();
}

class _CreateEvent extends State<CreateEvent> {
  TextEditingController _startDateController = TextEditingController();
  TextEditingController _endDateController = TextEditingController();

  String dropDownValue = 'Item 1';

  //Werden aus der Datenbank gezogen
  static const items = [
    'Diese',
    'Items',
    'kommen',
    'bald',
    'aus',
    'der',
    'Datenbank'
  ];

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
            )
          ],
        ),
      ),
    );
  }
}
