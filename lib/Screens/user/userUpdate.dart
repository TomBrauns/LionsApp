import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lionsapp/Screens/user/user_configs.dart';
import 'package:lionsapp/Widgets/burgermenu.dart';

import '../../login/login.dart';

class Update extends StatefulWidget {
  @override
  UpdateState createState() => UpdateState();
}

class UpdateState extends State<Update> {
  UpdateState();

  bool showProgress = false;
  bool visible = false;
  bool isChecked = false;

  final _formkey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;

  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController postalcodeController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController streetnrController = TextEditingController();

  bool _isObscure = true;
  bool _isObscure2 = true;
  File? file;
  var rool = "Friend";
  String? _firstname;
  String? _lastname;
  String? _email;
  String? _postalcode;
  String? _cityname;
  String? _streetname;
  String? _streetnumber;
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final docSnapshot = await FirebaseFirestore.instance.collection('users').doc(userId).get();
    final userData = docSnapshot.data() as Map<String, dynamic>;
    setState(
      () {
        firstnameController.text = userData['firstname'] as String;
        lastnameController.text = userData['lastname'] as String;
        emailController.text = userData['email'] as String;
        postalcodeController.text = userData['postalcode'] as String;
        cityController.text = userData['cityname'] as String;
        streetController.text = userData['streetname'] as String;
        streetnrController.text = userData['streetnumber'] as String;
      },
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Benutzer"),
      ),
      backgroundColor: Colors.blue,
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: <Widget>[
            Container(
              color: const Color.fromARGB(255, 29, 89, 167),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.all(12),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Nutzerdaten ändern",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 40,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: firstnameController,
                                decoration: InputDecoration(
                                  hintText: "Vorname",
                                  filled: true,
                                  fillColor: Colors.white,
                                  enabled: true,
                                  contentPadding: const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                onChanged: (value) {},
                                keyboardType: TextInputType.text,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: TextFormField(
                                controller: lastnameController,
                                decoration: InputDecoration(
                                  hintText: "Nachname",
                                  filled: true,
                                  fillColor: Colors.white,
                                  enabled: true,
                                  contentPadding: const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                onChanged: (value) {},
                                keyboardType: TextInputType.text,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                            hintText: "Email Adresse",
                            filled: true,
                            fillColor: Colors.white,
                            enabled: true,
                            contentPadding: const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onChanged: (value) {},
                          keyboardType: TextInputType.text,
                        ),
                        const SizedBox(
                          height: 20,
                        ),

                        // Workspace for non required Data ( Postalcode, City, Street and Streetnr)
                        // TODO: Add attribute to make them optional
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: postalcodeController,
                                decoration: InputDecoration(
                                  hintText: "PLZ",
                                  filled: true,
                                  fillColor: Colors.white,
                                  enabled: true,
                                  contentPadding: const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                onChanged: (value) {},
                                keyboardType: TextInputType.text,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: TextFormField(
                                controller: cityController,
                                decoration: InputDecoration(
                                  hintText: "Stadt",
                                  filled: true,
                                  fillColor: Colors.white,
                                  enabled: true,
                                  contentPadding: const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                onChanged: (value) {},
                                keyboardType: TextInputType.text,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        // TODO: Add attribute to make them optional
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: streetController,
                                decoration: InputDecoration(
                                  hintText: "Straße",
                                  filled: true,
                                  fillColor: Colors.white,
                                  enabled: true,
                                  contentPadding: const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                onChanged: (value) {},
                                keyboardType: TextInputType.text,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: TextFormField(
                                controller: streetnrController,
                                decoration: InputDecoration(
                                  hintText: "Hausnummer",
                                  filled: true,
                                  fillColor: Colors.white,
                                  enabled: true,
                                  contentPadding: const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                onChanged: (value) {},
                                keyboardType: TextInputType.text,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            MaterialButton(
                              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
                              elevation: 5.0,
                              height: 40,
                              onPressed: () {
                                setState(() {
                                  showProgress = true;
                                });
                                updateUser(
                                  firstnameController.text,
                                  lastnameController.text,
                                  emailController.text,
                                  postalcodeController.text,
                                  cityController.text,
                                  streetController.text,
                                  streetnrController.text,
                                );
                              },
                              child: const Text(
                                "Bestätigen",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> updateUser(
    String? newFirstName,
    String? newLastName,
    String? newEmail,
    String? newPostalCode,
    String? newCity,
    String? newStreet,
    String? newStreetNr,
  ) async {
    final user = FirebaseAuth.instance.currentUser;

    final userId = user?.uid;

    final docRef = FirebaseFirestore.instance.collection('users').doc(userId);

    Map<String, dynamic> dataToUpdate = {};

    dataToUpdate['firstname'] = newFirstName;

    dataToUpdate['lastname'] = newLastName;

    dataToUpdate['email'] = newEmail;

    dataToUpdate['postalcode'] = newPostalCode;

    dataToUpdate['cityname'] = newCity;

    dataToUpdate['streetname'] = newStreet;

    dataToUpdate['streetnumber'] = newStreetNr;

    if (dataToUpdate.isNotEmpty) {
      await docRef.update(dataToUpdate);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          content: Text('Nutzerdaten erfolgreich aktualisiert!'),
        ),
      );
      Navigator.pushNamed(context, '/User');
    } else {
      print('No updates to perform');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text('Versuche es erneut'),
        ),
      );
    }
  }

/* Future<void> updateUser(
      String? newFirstName,
      String? newLastName,
      String? newEmail,
      String? newPassword,
      String? newPostalCode,
      String? newCity,
      String? newStreet,
      String? newStreetNr) async {
    final user = FirebaseAuth.instance.currentUser;
    final userId = user?.uid;

    final userDocs = await FirebaseFirestore.instance
        .collection('users')
        .where('userId', isEqualTo: userId)
        .get();

    final userRef = FirebaseFirestore.instance.collection('users').doc(userDocs.id);
    print("währendessen");
    Map<String, dynamic> updates = {};

    if (newFirstName != null && newFirstName.isNotEmpty) {
      updates['firstname'] = newFirstName;
    }

    if (newLastName != null && newLastName.isNotEmpty) {
      updates['lastname'] = newLastName;
    }

    if (newEmail != null && newEmail.isNotEmpty) {
      updates['email'] = newEmail;
    }

    if (newPassword != null && newPassword.isNotEmpty) {
      updates['password'] = newPassword;
    }

    if (newPassword != null && newPassword.isNotEmpty) {
      updates['password'] = newPassword;
    }

    if (newPostalCode != null && newPostalCode.isNotEmpty) {
      updates['postalcode'] = newPostalCode;
    }

    if (newCity != null && newCity.isNotEmpty) {
      updates['city'] = newCity;
    }

    if (newStreet != null && newStreet.isNotEmpty) {
      updates['streetname'] = newStreet;
    }

    if (newStreetNr != null && newStreetNr.isNotEmpty) {
      updates['streetnumber'] = newStreetNr;
    }

    await userRef.update(updates);
  } */

/* Future<void> updateUser(
    String? newFirstName,
    String? newLastName,
    String? newEmail,
    String? newPassword,
    String? newPostalCode,
    String? newCity,
    String? newStreet,
    String? newStreetNr,
  ) async {
    final user = FirebaseAuth.instance.currentUser;
    final userId = user?.uid;
    print(userId);
    final userDocs = await FirebaseFirestore.instance
        .collection('users')
        .where(user!.uid, isEqualTo: userId)
        .get();

    final userDoc = userDocs.docs.first;
    print(userDoc);
    if (userDoc.id == userId) {
      // Dokument-ID stimmt mit User-ID überein
      Map<String, dynamic> updates = {};

      if (newFirstName != null && newFirstName.isNotEmpty) {
        updates['firstname'] = newFirstName;
      }

      if (newLastName != null && newLastName.isNotEmpty) {
        updates['lastname'] = newLastName;
      }

      if (newEmail != null && newEmail.isNotEmpty) {
        updates['email'] = newEmail;
      }

      if (newPassword != null && newPassword.isNotEmpty) {
        updates['password'] = newPassword;
      }

      if (newPassword != null && newPassword.isNotEmpty) {
        updates['password'] = newPassword;
      }

      if (newPostalCode != null && newPostalCode.isNotEmpty) {
        updates['postalcode'] = newPostalCode;
      }

      if (newCity != null && newCity.isNotEmpty) {
        updates['city'] = newCity;
      }

      if (newStreet != null && newStreet.isNotEmpty) {
        updates['streetname'] = newStreet;
      }

      if (newStreetNr != null && newStreetNr.isNotEmpty) {
        updates['streetnumber'] = newStreetNr;
      }

      await userDoc.reference.update(updates);
    } else {
      // Dokument-ID stimmt nicht mit User-ID überein
      throw Exception('Dokument-ID stimmt nicht mit User-ID überein.');
    }
  } */
}
