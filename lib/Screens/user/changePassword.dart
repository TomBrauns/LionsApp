import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lionsapp/Widgets/burgermenu.dart';

import '../../Widgets/textSize.dart';
import '../../login/login.dart';

class changePw extends StatefulWidget {
  @override
  changePwState createState() => changePwState();
}

class changePwState extends State<changePw> {
  changePwState();

  final _formkey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;

  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmationController = TextEditingController();

  bool _isObscure = true;
  bool _isObscure2 = true;

  @override
  void initState() {
    super.initState();
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
                          "Passwort ändern",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 40,
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
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
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: TextFormField(
                                obscureText: _isObscure,
                                controller: passwordConfirmationController,
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    icon: Icon(_isObscure ? Icons.visibility_off : Icons.visibility),
                                    onPressed: () {
                                      setState(
                                        () {
                                          _isObscure = !_isObscure;
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
                                onChanged: (value) {},
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
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
                                setState(
                                  () {
                                    if (passwordController.text == passwordConfirmationController.text) {
                                      changePW(passwordController.text);
                                    }
                                  },
                                );
                              },
                              child: Text("Bestätigen", style: CustomTextSize.medium),
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

  void changePW(String newPw) async {
    final User user = FirebaseAuth.instance.currentUser!;

    try {
      await user.updatePassword(newPw);
      // Handle password update success
    } catch (e) {
      // Handle password update failure
    }
  }
}
