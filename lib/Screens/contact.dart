import 'package:flutter/material.dart';
import 'package:lionsapp/Widgets/appbar.dart';
import 'package:lionsapp/main.dart';
import 'package:lionsapp/Widgets/burgermenu.dart';

class Contact extends StatefulWidget {
  const Contact({Key? key}) : super(key: key);

  @override
  State<Contact> createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Contact"),
      drawer: BurgerMenu(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText:
                          'Bitte tragen sie hier ihren Namen ein, damit wir besser bezug zu ihrer Nachricht nehmen können.',
                      hintText: 'Vor und Nachnamen eingeben',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vor und Nachnamen eingeben';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText:
                          'Bitte Email eingeben, über die wir Sie erreichen können.',
                      hintText: 'E-Mail eingeben',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email eingeben ';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _subjectController,
                    decoration: InputDecoration(
                      labelText: 'Betreff',
                      hintText: 'Betreff eingeben',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Betreff eingeben';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _messageController,
                    maxLines: 6,
                    decoration: InputDecoration(
                      labelText:
                          'Hier bitte die Nachricht eintragen, die sie uns mitgeben möchten.',
                      hintText: 'Nachricht tippen',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Text tippen';
                      }
                      return null;
                    },
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 40),
                    child: Text("Weitere Daten"),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("Datei zum Hochladen hier reinziehen"),
                        Icon(Icons.upload)
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey
                    ),
                  ),
                  SizedBox(height: 16),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          //sendEmail();
                        }
                      },
                      child: Text('Senden'),
                    ),
                  ),
                  Center(
                    child: Divider(),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
