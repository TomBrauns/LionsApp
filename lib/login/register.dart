import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:lionsapp/Screens/donation.dart';
import 'package:lionsapp/login/agb.dart';
import 'login.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lionsapp/Widgets/burgermenu.dart';
import 'package:platform/platform.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  _RegisterState();

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
  final TextEditingController mobile = TextEditingController();
  final TextEditingController postalcodeController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  final TextEditingController streetnrController = TextEditingController();

  // For the Postal code keyboardType: TextInputType.number

  bool _isObscure = true;
  bool _isObscure2 = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const BurgerMenu(),
      appBar: AppBar(),
      backgroundColor: Colors.blue,
      body: SingleChildScrollView(
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
                          "Registrierung",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 40,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
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
                                keyboardType: TextInputType.name,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Bitte geben Sie Ihren Vornamen ein.';
                                  }
                                  return null;
                                },
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
                                keyboardType: TextInputType.name,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Bitte geben Sie Ihren Nachnamen ein.';
                                  }
                                  return null;
                                },
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
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Email',
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
                          validator: (value) {
                            if (value!.length == 0) {
                              return "Email darf nicht leer sein";
                            }
                            if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
                              return ("Bitte gültige Email Adresse angeben");
                            } else {
                              return null;
                            }
                          },
                          onChanged: (value) {},
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          obscureText: _isObscure,
                          controller: passwordController,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: Icon(_isObscure ? Icons.visibility_off : Icons.visibility),
                              onPressed: () {
                                setState(() {
                                  _isObscure = !_isObscure;
                                });
                              },
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Passwort',
                            enabled: true,
                            contentPadding: const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 15.0),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          validator: (value) {
                            RegExp regex = RegExp(r'^.{6,}$');
                            if (value!.isEmpty) {
                              return "Passwort darf nicht leer sein";
                            }
                            if (!regex.hasMatch(value)) {
                              return ("Bitte gültiges Passwort mit mind. 6 Zeichen angeben");
                            } else {
                              return null;
                            }
                          },
                          onChanged: (value) {},
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          obscureText: _isObscure2,
                          controller: confirmpassController,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: Icon(_isObscure2 ? Icons.visibility_off : Icons.visibility),
                              onPressed: () {
                                setState(
                                  () {
                                    _isObscure2 = !_isObscure2;
                                  },
                                );
                              },
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Passwort bestätigen',
                            enabled: true,
                            contentPadding: const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 15.0),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          validator: (value) {
                            if (confirmpassController.text != passwordController.text) {
                              return "Passwörter stimmen nicht überein";
                            } else {
                              return null;
                            }
                          },
                          onChanged: (value) {},
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
                                  hintText: 'Postleizahl',
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
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Bitte geben Sie Ihre Postleizahl ein.';
                                  }
                                  return null;
                                },
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
                                keyboardType: TextInputType.name,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Bitte geben Sie Ihre Stadt ein.';
                                  }
                                  return null;
                                },
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
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: 'Straßenname',
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
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Bitte geben Sie Ihren Straßennamen ein.';
                                  }
                                  return null;
                                },
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
                                keyboardType: TextInputType.name,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Bitte geben Sie Ihre Hausnummer (und den Addresszusatz) ein.';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Checkbox(
                              value: isChecked,
                              onChanged: (checked) => setState(
                                () {
                                  isChecked = checked ?? false;
                                },
                              ),
                            ),
                            InkWell(
                                child: const Text(
                                  "* ABG's akzeptieren",
                                  style: TextStyle(
                                    color: Colors.white,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                                onTap: () {
                                  Navigator.pushNamed(context, '/AGB?onRegister=true');
                                }),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            MaterialButton(
                              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
                              elevation: 5.0,
                              height: 40,
                              onPressed: () {
                                const CircularProgressIndicator();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginPage(),
                                  ),
                                );
                              },
                              child: const Text(
                                "Zurück zu Login",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              color: Colors.white,
                            ),
                            MaterialButton(
                              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
                              elevation: 5.0,
                              height: 40,
                              onPressed: () async {
                                setState(
                                  () {
                                    showProgress = true;
                                  },
                                );

                                if (isChecked == false) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Sie müssen den AGBs zustimmen!',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                } else {
                                  if (_formkey.currentState!.validate()) {
                                    signUp(
                                      firstnameController.text,
                                      lastnameController.text,
                                      emailController.text,
                                      passwordController.text,
                                      postalcodeController.text,
                                      cityController.text,
                                      streetController.text,
                                      streetnrController.text,
                                    ).then(
                                      (success) {
                                        if (success) {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => LoginPage(prefilledEmail: emailController.text),
                                            ),
                                          );
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(
                                              content: Text('Registrierung erfolgreich. Bitte loggen Sie sich ein.'),
                                              backgroundColor: Colors.green,
                                              behavior: SnackBarBehavior.floating,
                                              margin: EdgeInsets.only(top: 64),
                                            ),
                                          );
                                        } else {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                'Es existiert bereits ein Account mit der Email!',
                                                style: TextStyle(color: Colors.white),
                                              ),
                                              backgroundColor: Colors.red,
                                            ),
                                          );
                                        }
                                      },
                                    );
                                  } else {
                                    // TODO: Show validation error message
                                  }
                                }
                              },
                              color: Colors.white,
                              child: const Text(
                                "Registrieren",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
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

  Future<bool> signUp(String firstname, String lastname, String email, String password, String? postalcode, String? cityname, String? streetname, String? streetnumber) async {
    return _auth.createUserWithEmailAndPassword(email: email, password: password).then(
      (result) async {
        await result.user!.sendEmailVerification();
        await postDetailsToFirestore(firstname, lastname, email, postalcode, cityname, streetname, streetnumber);
        return true;
      },
    ).catchError(
      (e) {
        // Handle error
        print(e);
        return false;
      },
    );
  }

  Future<void> postDetailsToFirestore(String firstname, String lastname, String email, String? postalcode, String? cityname, String? streetname, String? streetnumber) async {
    var user = _auth.currentUser;
    String? deviceToken;
    CollectionReference ref = FirebaseFirestore.instance.collection('users');

    if (!kIsWeb) {
      deviceToken = await FirebaseMessaging.instance.getToken();
    }

    return ref.doc(user!.uid).set(
      {
        'firstname': firstname,
        'lastname': lastname,
        'email': email,
        'postalcode': postalcode,
        'cityname': cityname,
        'streetname': streetname,
        'streetnumber': streetnumber,
        'rool': 'Friend',
        'device': deviceToken,
        'receiveNotification': true,
      },
    );
  }

  Future<void> uploadFileToFirebaseStorage(File file) async {
    try {
      // Create a unique filename for the file
      String filename = DateTime.now().millisecondsSinceEpoch.toString() + '.jpg';

      // Get a reference to the Firebase Storage location where we will upload the file
      final ref = FirebaseStorage.instance.ref().child(filename);

      // Upload the file to Firebase Storage
      await ref.putFile(file);

      print('File uploaded to Firebase Storage successfully');
    } catch (e) {
      print('Error uploading file to Firebase Storage: $e');
    }
  }
}
