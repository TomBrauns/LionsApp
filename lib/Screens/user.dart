import 'package:flutter/material.dart';
import 'package:lionsapp/Widgets/burgermenu.dart';

class User extends StatefulWidget {
  const User({super.key});

  @override
  State<User> createState() => _UserState();
}

class _UserState extends State<User> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Benutzer"),
        ),
        drawer: const BurgerMenu(),
        body: Center(
            child: Column(children: <Widget>[
          Container(
              child: Column(children: <Widget>[
            IconButton(
              icon: const Icon(Icons.account_circle),
              tooltip: 'Profilbild ändern',
              iconSize: 70,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ProfilePicture()),
                );
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 10),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ProfilePicture()),
                );
              },
              child: const Text('Profilbild ändern'),
            )
          ])),
          Container(
            margin: const EdgeInsets.all(25),
            child: ElevatedButton.icon(
              icon: const Icon(
                Icons.badge,
                size: 24.0,
              ),
              label: const Text('Nutzerdaten ändern'),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                elevation: 0,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const UserForm()),
                );
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.all(25),
            child: ElevatedButton.icon(
              icon: const Icon(
                Icons.card_membership,
                size: 24.0,
              ),
              label: const Text('Abos Verwalten'),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                elevation: 0,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Subs()),
                );
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.all(25),
            child: ElevatedButton.icon(
              icon: const Icon(
                Icons.accessibility_new,
                size: 24.0,
              ),
              label: const Text('Bedienungshilfe'),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                elevation: 0,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const Accessibility()),
                );
              },
            ),
          ),
        ])));
  }
}

class UserForm extends StatefulWidget {
  const UserForm({super.key});

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nutzerdaten"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(
                labelText: 'Namen',
                hintText: 'Vor und Nachnamen eingeben',
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
          TextFormField(
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
          TextFormField(
            decoration: const InputDecoration(
                labelText: 'Passwort',
                hintText: 'Passwort',
                icon: Icon(
                  Icons.email,
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
          TextFormField(
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
          TextFormField(
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
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                // Validate will return true if the form is valid, or false if
                // the form is invalid.
                //if (_formKey.currentState!.validate()) {
                // Process data.
                //}
              },
              child: const Text('Bestätigen'),
            ),
          ),
        ],
      ),
    );
  }
}

class Subs extends StatefulWidget {
  const Subs({super.key});

  @override
  State<Subs> createState() => _SubsState();
}

class _SubsState extends State<Subs> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class Accessibility extends StatefulWidget {
  const Accessibility({super.key});

  @override
  State<Accessibility> createState() => _AccessibilityState();
}

class _AccessibilityState extends State<Accessibility> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class ProfilePicture extends StatefulWidget {
  const ProfilePicture({super.key});

  @override
  State<ProfilePicture> createState() => _ProfilePictureState();
}

class _ProfilePictureState extends State<ProfilePicture> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
