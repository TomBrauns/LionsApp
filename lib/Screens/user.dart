import 'package:flutter/material.dart';
import '../Widgets/burgermenu.dart';

class User extends StatelessWidget {
  const User({super.key});

  static const String _title = 'Kontakt';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        drawer: const BurgerMenu(),
        appBar: AppBar(title: const Text(_title)),
        body: const UserForm(),
      ),
    );
  }
}

class UserForm extends StatefulWidget {
  const UserForm({super.key});

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      margin: const EdgeInsets.all(67),
      child: SingleChildScrollView(
          child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 16.0, horizontal: 20),
                    child: Text('',
                        style: TextStyle(
                          fontSize: 32,
                          color: Colors.blue,
                        ),
                        textAlign: TextAlign.center),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 20),
                    child: TextFormField(
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Namen',
                          hintText: 'Vor und Nachname eingeben',
                          icon: Icon(
                            Icons.person,
                            color: Colors.blue,
                            size: 25,
                          )),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Geben Sie Ihre Namen ein';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 20),
                    child: TextFormField(
                      decoration: const InputDecoration(
                          labelText: 'E-Mail',
                          hintText: 'Email eingeben',
                          icon: Icon(
                            Icons.email,
                            color: Colors.blue,
                            size: 25,
                          )),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Geben Sie Ihre Email Adresse ein';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 20),
                    child: TextFormField(
                      decoration: const InputDecoration(
                          labelText: 'Passwort',
                          hintText: 'Passwort',
                          icon: Icon(
                            Icons.lock,
                            color: Colors.blue,
                            size: 25,
                          )),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Geben Sie ein Passwort';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 20),
                    child: TextFormField(
                      decoration: const InputDecoration(
                          labelText: 'Passwort Bestätigen',
                          hintText: 'Passwort',
                          icon: Icon(
                            Icons.lock,
                            color: Colors.blue,
                            size: 25,
                          )),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Passwort bestätigen';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 50),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {}
                      },
                      child: const Text('Senden'),
                    ),
                  ),
                ],
              ))),
    ));
  }
}
