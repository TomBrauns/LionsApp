//Licensed under the EUPL v.1.2 or later
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lionsapp/Screens/donation.dart';
import 'package:lionsapp/Screens/user/admin/changeRole.dart';
import 'package:lionsapp/Screens/user/changePassword.dart';
import 'package:lionsapp/Screens/user/userUpdate.dart';
import 'package:lionsapp/Widgets/appbar.dart';
import 'package:lionsapp/Widgets/bottomNavigationView.dart';
import 'package:lionsapp/Widgets/burgermenu.dart';
import 'package:lionsapp/Widgets/privileges.dart';
import 'package:lionsapp/Widgets/textSize.dart';
import 'package:lionsapp/util/color.dart';
import 'package:lionsapp/util/image_upload.dart';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:permission_handler/permission_handler.dart';

String Endpoint =
    "https://europe-west3-serviceclub-app.cloudfunctions.net/flask-backend";
//String Endpoint = "http://127.0.0.1:5000";

class User extends StatefulWidget {
  const User({super.key});

  @override
  State<User> createState() => _UserState();
}

class _UserState extends State<User> {
  bool _permissionGranted = false;
  bool receiveNotifications = true;
  Future<void> _checkPermission() async {
    final status = await Permission.photos.request();
    setState(
      () {
        _permissionGranted = status == PermissionStatus.granted;
      },
    );
  }

  @override
  void initState() {
    super.initState();
    getReceiveNotifications();
    _loadReceiveNotifications();
  }

  Future<void> _loadReceiveNotifications() async {
    bool value = await getReceiveNotifications();
    setState(
      () {
        receiveNotifications = value;
      },
    );
  }

  Future<bool> getReceiveNotifications() async {
    DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    bool receiveNotifications = await userSnapshot.get('receiveNotification');
    return receiveNotifications;
  }

  bool test = true;

  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Benutzer"),
      ),
      bottomNavigationBar: BottomNavigation(),
      drawer: const BurgerMenu(),
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Scrollbar(
          thickness: 5.0,
          thumbVisibility: false,
          radius: const Radius.circular(360),
          child: ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    child: buildImageFromFirebase(),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      textStyle: TextStyle(fontSize: 10),
                    ),
                    onPressed: () async {
                      if (defaultTargetPlatform == TargetPlatform.iOS) {
                        await _checkPermission();
                      }

                      final user = FirebaseAuth.instance.currentUser;
                      if (user != null) {
                        final XFile? file = await ImageUpload.selectImage();
                        if (file != null) {
                          final String uniqueFilename =
                              DateTime.now().millisecondsSinceEpoch.toString();
                          final String? imageUrl =
                              await ImageUpload.uploadImage(file, "user_images",
                                  user.uid, uniqueFilename);
                          if (imageUrl != null) {
                            await FirebaseFirestore.instance
                                .collection('users')
                                .doc(user.uid)
                                .update({"image_url": imageUrl});
                            await FirebaseFirestore.instance
                                .collection('user_chat')
                                .doc(user.uid)
                                .update({"imageUrl": imageUrl});
                          }
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Sie müssen sich zuerst anmelden!',
                              style: TextStyle(color: Colors.white),
                            ),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                    child:
                        Text('Profilbild ändern', style: CustomTextSize.small),
                  ),
                  if (user != null)
                    UserDataWidget()
                  else
                    const Text(
                      'Sie müssen sich zuerst anmelden!',
                      style: TextStyle(color: Colors.red),
                    ),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Text('App Benachrichtigungen:',
                        style: CustomTextSize.small),
                    Switch.adaptive(
                      value: receiveNotifications,
                      onChanged: (newValue) {
                        setState(
                          () {
                            receiveNotifications = newValue;
                            final docRef = FirebaseFirestore.instance
                                .collection('users')
                                .doc(FirebaseAuth.instance.currentUser!.uid);
                            docRef.update(
                              {
                                'receiveNotification': newValue,
                              },
                            );
                          },
                        );
                      },
                      activeColor: ColorUtils.primaryColor,
                    ),
                  ]),
                ],
              ),
              Container(
                margin: const EdgeInsets.all(25),
                child: ElevatedButton.icon(
                  icon: const Icon(
                    Icons.history,
                    size: 24.0,
                  ),
                  label: Text('Verlauf anzeigen', style: CustomTextSize.medium),
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/History');
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.all(25),
                child: ElevatedButton.icon(
                  icon: const Icon(
                    Icons.badge,
                    size: 24.0,
                  ),
                  label:
                      Text('Nutzerdaten ändern', style: CustomTextSize.medium),
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                  ),
                  onPressed: () {
                    final user = FirebaseAuth.instance.currentUser;
                    if (user != null) {
                      Navigator.pushNamed(context, '/User/Data');
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Sie müssen sich zuerst anmelden!',
                            style: TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.all(25),
                child: ElevatedButton.icon(
                  icon: const Icon(
                    Icons.lock_open_rounded,
                    size: 24.0,
                  ),
                  label: Text('Passwort ändern', style: CustomTextSize.medium),
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                  ),
                  onPressed: () {
                    final user = FirebaseAuth.instance.currentUser;
                    if (user != null) {
                      Navigator.pushNamed(context, '/User/ChangePW');
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Sie müssen sich zuerst anmelden!',
                            style: TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
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
                  label: Text('Abos Verwalten', style: CustomTextSize.medium),
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/User/Subs');
                  },
                ),
              ),
              /*
             /// Commented out "Bedienungshilfe" as it is not doing what its supposed to for the time being...
             Container(
                margin: const EdgeInsets.all(25),
                child: ElevatedButton.icon(
                  icon: const Icon(
                    Icons.accessibility_new,
                    size: 24.0,
                  ),
                  label: Text('Bedienungshilfe', style: CustomTextSize.medium),
                  style: ElevatedButton.styleFrom(
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
              ),*/
              Container(
                margin: const EdgeInsets.all(25),
                child: ElevatedButton.icon(
                  icon: const Icon(
                    Icons.logout,
                    size: 24.0,
                  ),
                  label: Text('Ausloggen', style: CustomTextSize.medium),
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                  ),
                  onPressed: () {
                    signOut();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Colors.green,
                        content: Text("Sie sind nun ausgeloggt"),
                        duration: Duration(seconds: 3),
                      ),
                    );
                    Navigator.pushNamed(context, '/');
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.all(25),
                child: ElevatedButton.icon(
                  icon: const Icon(
                    Icons.delete,
                    size: 24.0,
                  ),
                  label: Text('Account löschen', style: CustomTextSize.medium),
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                  ),
                  onPressed: () {
                    if (FirebaseAuth.instance.currentUser!.uid == null) {
                      return;
                    } else {
                      showMyDialog();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Wollen Sie Ihren Account wirklich löschen?',
                    style: CustomTextSize.small),
                Text('Der Vorgang kann nicht rückgängig gemacht werden',
                    style: CustomTextSize.small),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Abbrechen', style: CustomTextSize.small),
              onPressed: () {
                Navigator.pushNamed(context, '/User');
              },
            ),
            TextButton(
              child: Text('Bestätigen', style: CustomTextSize.small),
              onPressed: () {
                deleteAcc();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Ihr Account wurde gelöscht',
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.green,
                  ),
                );
                Navigator.pushNamed(context, '/');
              },
            ),
          ],
        );
      },
    );
  }

  Widget? buildImageFromFirebase() {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            print('Error: ${snapshot.error}');
            return const Icon(Icons.person, size: 50);
          } else {
            final data = snapshot.data?.data() as Map<String, dynamic>?;
            if (data != null && data.containsKey('image_url')) {
              String? imageUrl = data['image_url'] as String?;
              if (imageUrl != null) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    width: 100,
                    height: 100,
                  ),
                );
              }
            }
            return const Icon(Icons.person, size: 50);
          }
        },
      );
    } catch (e) {
      print(e);
    }
  }
}

Future<void> deleteAcc() async {
  Privileges.privilege = Privilege.guest;
  final user = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid);
  final String stripeCustomerId = (await user.get())["stripeCustomerId"];
  deleteCustomer(Endpoint, stripeCustomerId);
  user.delete();
  await FirebaseAuth.instance.currentUser!.delete();
}

Future<String> deleteCustomer(Endpoint, customerId) async {
  final body = {
    "customerId": customerId,
  };

  // Make post request to Stripe

  final response = await http.post(
    Uri.parse('$Endpoint/StripeDeleteCustomer'),
    headers: {'Content-Type': 'application/x-www-form-urlencoded'},
    body: body,
  );

  var jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;
  //print(response.statusCode);
  //print(response.body);
  String Id = jsonResponse['id'];

  return Id;
}

Future<void> signOut() async {
  Privileges.privilege = Privilege.guest;
  await FirebaseAuth.instance.signOut();
}

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
  double _currentSliderValue = 20;
  double _textSize = 20.0; // store the current text size here

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bedienungshilfe"),
      ),
      body: Builder(
        builder: (context) => DefaultTextStyle(
          style: TextStyle(fontSize: _textSize),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Fontgröße: ${_currentSliderValue.round()}"),
                Slider(
                  value: _currentSliderValue,
                  min: 14,
                  max: 30,
                  divisions: 16,
                  label: _currentSliderValue.round().toString(),
                  onChanged: (double value) {
                    setState(
                      () {
                        _currentSliderValue = value;
                      },
                    );
                  },
                ),
                Text("Farbenblindheitsmodus"),
                DropdownButton<String>(
                  value: dropdownValue,
                  icon: const Icon(Icons.arrow_downward),
                  elevation: 16,
                  style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                  underline: Container(
                    height: 2,
                    color: const Color.fromARGB(255, 0, 0, 0),
                  ),
                  onChanged: (String? value) {
                    // This is called when the user selects an item.
                    setState(
                      () {
                        dropdownValue = value!;
                      },
                    );
                  },
                  items: list.map<DropdownMenuItem<String>>(
                    (String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    },
                  ).toList(),
                ),
                Container(
                  margin: const EdgeInsets.all(25),
                  child: ElevatedButton(
                    child: Text("Bestätigen"),
                    style: ElevatedButton.styleFrom(
                      primary: ColorUtils.primaryColor,
                      elevation: 0,
                    ),
                    onPressed: () {
                      // update the text size when the button is pressed
                      setState(
                        () {
                          _textSize = _currentSliderValue;
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class UserDataWidget extends StatelessWidget {
  final String userId = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    if (userId == null || userId.isEmpty) {
      return const Text('gerade niemand eingeloggt');
    } else {
      return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future:
            FirebaseFirestore.instance.collection('users').doc(userId).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            final userData = snapshot.data!.data()!;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (userData['firstname'] != null &&
                    userData['lastname'] != null)
                  Text('Name: ${userData['firstname']} ${userData['lastname']}',
                      style: CustomTextSize.small),
                if (userData['email'] != null)
                  Text('Email: ${userData['email']}',
                      style: CustomTextSize.small),
                if (userData['streetname'] != null &&
                    userData['streetnumber'] != null &&
                    userData['postalcode'] != null &&
                    userData['cityname'] != null)
                  Text(
                      'Addresse: ${userData['streetname']} ${userData['streetnumber']} ${userData['postalcode']} ${userData['cityname']}',
                      style: CustomTextSize.small)
                else
                  (Text('')),
              ],
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return const CircularProgressIndicator();
          }
        },
      );
    }
  }
}
