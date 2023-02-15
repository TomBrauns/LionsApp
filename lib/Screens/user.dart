import 'package:flutter/material.dart';

class User extends StatelessWidget {
  const User({super.key});

  static const String _title = 'New User';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
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
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(
                labelText: 'Namen',
                hintText: 'Vor und Nachnamen eingeben',
                icon: Icon(
                  Icons.person, color: Colors.blue, size: 25,
                )
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Geben Sie Ihre Namen ein';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'E-Mail',
              hintText: 'Email eingeben',
              icon: Icon(
                Icons.email, color: Colors.blue, size: 25,
              )
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Geben Sie Ihre Email Adresse ein';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
                labelText: 'Passwort',
                hintText: 'Passwort',
                icon: Icon(
                  Icons.email, color: Colors.blue, size: 25,
                )
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Geben Sie ein Passwort';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
                labelText: 'Passwort',
                hintText: 'Passwort',
                icon: Icon(
                  Icons.lock, color: Colors.blue, size: 25,
                )
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Geben Sie ein Passwort';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
                labelText: 'Passwort Bestätigen',
                hintText: 'Passwort',
                icon: Icon(
                  Icons.lock, color: Colors.blue, size: 25,
                )
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Passwort bestätigen';
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                // Validate will return true if the form is valid, or false if
                // the form is invalid.
                if (_formKey.currentState!.validate()) {
                  // Process data.
                }
              },
              child: const Text('Senden'),
            ),
          ),
        ],
      ),
    );
  }
}
