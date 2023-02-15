import 'package:flutter/material.dart';
import 'package:lionsapp/Widgets/burgermenu.dart';

class Imprint extends StatefulWidget {
  const Imprint({Key? key}) : super(key: key);

  @override
  State<Imprint> createState() => _ImprintState();
}

class _ImprintState extends State<Imprint> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const BurgerMenu(),
      appBar: AppBar(
        title: const Text("Impressum"),
      ),
      body: SingleChildScrollView(
          child: Column(children: <Widget>[
        Container(
          margin: const EdgeInsets.all(15),
        ),
        Container(
          child: Text("Herausgeber:"),
        ),
        Container(
          height: 50,
          width: 350,
          padding: const EdgeInsets.all(15.0),
          margin: const EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: Color.fromARGB(156, 141, 196, 241),
              border: Border.all(color: Colors.blueAccent)),
          child: Text("Herausgeber"),
        ),
        Container(
          margin: const EdgeInsets.all(15),
        ),
        Container(
          child: Text("Inhaltlich Verantwortllicher gemäß § 55 RStV:"),
        ),
        Container(
          height: 50,
          width: 350,
          padding: const EdgeInsets.all(15.0),
          margin: const EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: Color.fromARGB(156, 141, 196, 241),
              border: Border.all(color: Colors.blueAccent)),
          child: Text("Inhaltlich Verantwortllicher gemäß § 55 RStV"),
        ),
        Container(
          margin: const EdgeInsets.all(15),
        ),
        Container(
          child: Text("Datenschutz:"),
        ),
        Container(
          height: 50,
          width: 350,
          padding: const EdgeInsets.all(15.0),
          margin: const EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: Color.fromARGB(156, 141, 196, 241),
              border: Border.all(color: Colors.blueAccent)),
          child: Text("Datenschutz"),
        ),
        Container(
          margin: const EdgeInsets.all(15),
        ),
        Container(
          child: Text("Haftungshinweis:"),
        ),
        Container(
          height: 50,
          width: 350,
          padding: const EdgeInsets.all(15.0),
          margin: const EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: Color.fromARGB(156, 141, 196, 241),
              border: Border.all(color: Colors.blueAccent)),
          child: Text("Haftungshinweis"),
        ),
        Container(
          margin: const EdgeInsets.all(15),
        ),
        Container(
          child: Text("App Entwickler:"),
        ),
        Container(
          height: 50,
          width: 350,
          padding: const EdgeInsets.all(15.0),
          margin: const EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: Color.fromARGB(156, 141, 196, 241),
              border: Border.all(color: Colors.blueAccent)),
          child: Text("App Entwickler Adresse"),
        ),
      ])),
    );
  }
}
