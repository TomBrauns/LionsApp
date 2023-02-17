import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lionsapp/Widgets/appbar.dart';
import 'package:lionsapp/Widgets/bottomNavigationView.dart';
import 'package:lionsapp/Widgets/burgermenu.dart';
import 'package:lionsapp/login/login.dart';
import 'package:lionsapp/login/login.dart' as test;

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
        bottomNavigationBar: const BottomNavigation(
          currentPage: "User",
          privilege: "Admin",
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
          Container(
            margin: const EdgeInsets.all(25),
            child: ElevatedButton.icon(
              icon: const Icon(
                Icons.logout,
                size: 24.0,
              ),
              label: const Text('Ausloggen'),
              style: ElevatedButton.styleFrom(
                elevation: 0,
              ),
              onPressed: () {
                signOut();
                BurgerMenu.privilege = "Friend";
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LogOut()),
                );
              },
            ),
          ),
        ])));
  }
}

Future<void> signOut() async {
  await FirebaseAuth.instance.signOut();
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
          title: const Text("Nutzerdaten ändern"),
        ),
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
            child: Scrollbar(
                thickness: 5.0,
                thumbVisibility: false,
                radius: const Radius.circular(360),
                child: Center(
                  child: SizedBox(
                    width: 250,
                    height: 600,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          decoration: const InputDecoration(
                              labelText: 'Vorname',
                              hintText: 'Vorname eingeben',
                              icon: Icon(
                                Icons.person,
                                color: Colors.blue,
                                size: 25,
                              )),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Geben Sie Ihre Vorname ein';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                              labelText: 'Nachname',
                              hintText: 'Nachnamen eingeben',
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
                        Container(
                          margin: const EdgeInsets.all(15),
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
                              labelText: 'E-Mail bestätigen',
                              hintText: 'Email bestätigen',
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
                        Container(
                          margin: const EdgeInsets.all(15),
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
                        Container(
                          margin: const EdgeInsets.all(15),
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
                  ),
                ))));
  }
}

/* TEST */

/* TEST */

class Subs extends StatefulWidget {
  const Subs({super.key});

  @override
  State<Subs> createState() => _SubsState();
}

class _SubsState extends State<Subs> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MyAppBar(
        title: "Abo Verwaltung",
        privilege: "Friend",
      ),
    );
  }
}

const List<String> list = <String>[
  'keins',
  'Protanopie',
  'Deuteranopie',
  'Tritanopie',
  'Achromatopsie'
];

class Accessibility extends StatefulWidget {
  const Accessibility({super.key});

  @override
  State<Accessibility> createState() => _AccessibilityState();
}

class _AccessibilityState extends State<Accessibility> {
  String dropdownValue = list.first;
  double _currentSliderValue = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Bedienungshilfe"),
        ),
        body: Center(
            child: Column(children: <Widget>[
          Text("Fontgröße"),
          Slider(
              value: _currentSliderValue,
              max: 5,
              divisions: 5,
              label: _currentSliderValue.round().toString(),
              onChanged: (double value) {
                setState(() {
                  _currentSliderValue = value;
                });
              }),
          Text("Farbenblindheitsmodus"),
          DropdownButton<String>(
            value: dropdownValue,
            icon: const Icon(Icons.arrow_downward),
            elevation: 16,
            style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
            underline: Container(
              height: 2,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
            onChanged: (String? value) {
              // This is called when the user selects an item.
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
          ),
          Container(
            margin: EdgeInsets.all(25),
            child: ElevatedButton(
              child: Text("Bestätigen"),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                elevation: 0,
              ),
              onPressed: () {},
            ),
          ),
        ])));
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
    return Scaffold(
        appBar: AppBar(
          title: const Text("Profilbild ändern"),
        ),
        body: Center(
          child: Column(
            children: [Container(), Container(), Container()],
          ),
        ));
  }
}

class LogOut extends StatefulWidget {
  const LogOut({super.key});

  @override
  State<LogOut> createState() => _LogOutState();
}

class _LogOutState extends State<LogOut> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ausgeloggt"),
      ),
      body: Center(
          child: Column(children: [
        Container(
          margin: const EdgeInsets.all(40),
          padding: const EdgeInsets.all(40.0),
          decoration: BoxDecoration(
            color: Colors.amber,
            border: Border.all(color: Colors.amber),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Text("Schade dass du dich ausgeloggt hast."
              "Wir hoffen dich bald wieder, bei den Lions, begrüßen zu dürfen."),
        ),
        Container(
          margin: const EdgeInsets.all(25),
          child: ElevatedButton.icon(
            icon: const Icon(
              Icons.keyboard_return,
              size: 24.0,
            ),
            label: const Text('Zurück zum Start'),
            style: ElevatedButton.styleFrom(
              primary: Colors.blue,
              elevation: 0,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
          ),
        ),
      ])),
    );
  }
}
