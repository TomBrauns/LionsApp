import 'package:flutter/material.dart';

class UseForm extends StatefulWidget {
  const UseForm({super.key});

  @override
  State<UseForm> createState() => _UseFormState();
}

class _UseFormState extends State<UseForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    const appTitle = 'User login';

    return Form(
      key: _formKey,
      child: Column(children: <Widget>[
        TextFormField(
          
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Eingabe fehlt';
            }
            return null;
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: ElevatedButton(onPressed: () {
            if (_formKey.currentState!.validate()) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Processing Data')),
              );
            }
          },
          child: const Text('Submit'),
          ),
        ),
      ]),
    );
  }
}

/*class User extends StatefulWidget {
  const User({super.key});
  @override
  State<User> createState() => _UserState();
}

class _UserState extends State<User> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Text(
              'Willkommen bei Lion',
              style: TextStyle(
                fontSize: 32,
                color: Colors.blue,
              ),
              textAlign: TextAlign.center,
            ),
            TextField(
              decoration: InputDecoration(
                  labelText: "Namen",
                  hintText: "Name und Vorname eingeben",
                  icon: Icon(
                    Icons.person,
                    color: Colors.blue,
                    size: 25,
                  )),
              keyboardType: TextInputType.text,
            ),
            TextField(
              decoration: InputDecoration(
                  labelText: "E-Mail",
                  hintText: "E-Mail eingeben",
                  icon: Icon(
                    Icons.email,
                    color: Colors.blue,
                    size: 25,
                  )),
              keyboardType: TextInputType.text,
            ),
            TextField(
              decoration: InputDecoration(
                  labelText: "Passwort",
                  hintText: "Passwort",
                  icon: Icon(
                    Icons.lock,
                    color: Colors.blue,
                    size: 25,
                  )),
              keyboardType: TextInputType.text,
            ),
            TextField(
              decoration: InputDecoration(
                  labelText: "Passwort Bestättigen",
                  hintText: "Passwort bestättigen",
                  icon: Icon(
                    Icons.lock,
                    color: Colors.blue,
                    size: 25,
                  )),
              keyboardType: TextInputType.text,
            ),
          ],
        ),
      ),
    );
  }
}*/
