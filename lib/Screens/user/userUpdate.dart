import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'model.dart';
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

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmpassController = TextEditingController();
  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController postalcodeController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  final TextEditingController streetnrController = TextEditingController();

  // For the Postal code keyboardType: TextInputType.number

  bool _isObscure = true;
  bool _isObscure2 = true;
  File? file;
  var rool = "friend";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const BurgerMenu(),
      appBar: AppBar(),
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
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: 'Vorname',
                                  enabled: true,
                                  contentPadding: const EdgeInsets.only(
                                      left: 14.0, bottom: 8.0, top: 8.0),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.white),
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
                                filled: true,
                                fillColor: Colors.white,
                                hintText: 'Nachname',
                                enabled: true,
                                contentPadding: const EdgeInsets.only(
                                    left: 14.0, bottom: 8.0, top: 8.0),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              onChanged: (value) {},
                              keyboardType: TextInputType.text,
                            )),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Email',
                            enabled: true,
                            contentPadding: const EdgeInsets.only(
                                left: 14.0, bottom: 8.0, top: 8.0),
                            focusedBorder: OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.white),
                              borderRadius: new BorderRadius.circular(20),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: new BorderSide(color: Colors.white),
                              borderRadius: new BorderRadius.circular(20),
                            ),
                          ),
                          onChanged: (value) {},
                          keyboardType: TextInputType.emailAddress,
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
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: 'Postleitszahl',
                                  enabled: true,
                                  contentPadding: const EdgeInsets.only(
                                      left: 14.0, bottom: 8.0, top: 8.0),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                onChanged: (value) {},
                                keyboardType: TextInputType.number,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                                child: TextFormField(
                              controller: cityController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                hintText: 'Stadtname',
                                enabled: true,
                                contentPadding: const EdgeInsets.only(
                                    left: 14.0, bottom: 8.0, top: 8.0),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              onChanged: (value) {},
                              keyboardType: TextInputType.text,
                            )),
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
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: 'Straßenname',
                                  enabled: true,
                                  contentPadding: const EdgeInsets.only(
                                      left: 14.0, bottom: 8.0, top: 8.0),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.white),
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
                                filled: true,
                                fillColor: Colors.white,
                                hintText: 'Hausnummer und Adresszusatz',
                                enabled: true,
                                contentPadding: const EdgeInsets.only(
                                    left: 14.0, bottom: 8.0, top: 8.0),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              onChanged: (value) {},
                              keyboardType: TextInputType.number,
                            )),
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
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0))),
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
                                  passwordController.text,
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
    String? newPassword,
    String? newPostalCode,
    String? newCity,
    String? newStreet,
    String? newStreetNr,
  ) async {
    final user = FirebaseAuth.instance.currentUser;

    final userId = user?.uid;

    final docRef = FirebaseFirestore.instance.collection('users').doc(userId);

    Map<String, dynamic> dataToUpdate = {};

    if (newFirstName != null && newFirstName.isNotEmpty) {
      dataToUpdate['firstname'] = newFirstName;
    }
    if (newLastName != null && newLastName.isNotEmpty) {
      dataToUpdate['lastname'] = newLastName;
    }
    if (newEmail != null && newEmail.isNotEmpty) {
      dataToUpdate['email'] = newEmail;
    }
    if (newPassword != null && newPassword.isNotEmpty) {
      dataToUpdate['password'] = newPassword;
    }
    if (newPostalCode != null && newPostalCode.isNotEmpty) {
      dataToUpdate['postalCode'] = newPostalCode;
    }
    if (newCity != null && newCity.isNotEmpty) {
      dataToUpdate['city'] = newCity;
    }
    if (newStreet != null && newStreet.isNotEmpty) {
      dataToUpdate['street'] = newStreet;
    }
    if (newStreetNr != null && newStreetNr.isNotEmpty) {
      dataToUpdate['streetNr'] = newStreetNr;
    }

    if (dataToUpdate.isNotEmpty) {
      await docRef.update(dataToUpdate);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          content: Text('Nutzerdaten erfolgreich aktualisiert!'),
        ),
      );
      print('success');
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
