import 'package:flutter/material.dart';
//import 'package:flutter/Widgets.dart';
import 'package:lionsapp/Widgets/dropdownEingeloggt.dart';
import 'package:lionsapp/Widgets/burgermenu.dart';

class Eingeloggt extends StatefulWidget {
  const Eingeloggt({Key? key}) : super(key: key);

  @override
  State<Eingeloggt> createState() => _EingeloggtState();
}

class _EingeloggtState extends State<Eingeloggt> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const BurgerMenu(),
        appBar: AppBar(
          title: const Text("Eingeloggt"),
        ),
        body: Center(
          child: Column(children: [
            Container(
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                        hintText: ("Betrag"), //hint text
                        hintStyle: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold), //hint text style
                        hintMaxLines: 2, //hint text maximum lines
                        hintTextDirection: TextDirection
                            .rtl //hint text direction, current is RTL
                        ),
                  ),
                  Row(
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: null,
                        child: const Text('5 Euro'),
                      ),
                      ElevatedButton(
                        onPressed: null,
                        child: const Text('10 Euro'),
                      ),
                      ElevatedButton(
                        onPressed: null,
                        child: const Text('100 Euro'),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              child: Column(
                children: <Widget>[
                  ElevatedButton(onPressed: null, child: const Text('Spenden')),
                  CheckboxListTile(
                    value: null,
                    title: Text("title text"),
                    onChanged: null,
                    controlAffinity: ListTileControlAffinity
                        .leading, //  <-- leading Checkbox
                  )
                ],
              ),
            ),
            Container(
                child: Column(
              children: <Widget>[DropdownButtonList()],
            ))
          ]),
        ));
  }
}
