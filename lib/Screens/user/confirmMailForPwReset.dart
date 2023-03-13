import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lionsapp/Widgets/burgermenu.dart';

import 'package:lionsapp/Widgets/appbar.dart';

import '../../Widgets/textSize.dart';
import '../../login/login.dart';

class PwReset extends StatefulWidget {
  const PwReset({Key? key}) : super(key: key);

  @override
  State<PwReset> createState() => _CalendarState();
}

class _CalendarState extends State<PwReset> {
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const BurgerMenu(),
      appBar: const MyAppBar(title: "Passwort zurücksetzen"),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: EdgeInsets.all(25.0),
              child: Text('Geben Sie Ihre Email Adresse ein, anschließend erhalten Sie einen Link von uns mit dem Sie Ihr Passwort zurücksetzen können!', style: CustomTextSize.medium),
            ),
            Container(
              margin: const EdgeInsets.only(left: 40, right: 40),
              child: TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  icon: Icon(Icons.mail_outline),
                  labelText: 'Email Adresse',
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            MaterialButton(
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
              elevation: 5.0,
              height: 40,
              onPressed: () {
                resetPassword(email: emailController.text);
              },
              color: Colors.white,
              child: const Text(
                "Passwort zurücksetzen",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> resetPassword({required String email}) async {
    final userExists = await doesUserExistWithEmail(email);
    if (userExists) {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Bitte prüfen Sie jetzt Ihr Email Postfach'), backgroundColor: Colors.green),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Die Email Adresse ist bei uns nicht registriert'), backgroundColor: Colors.redAccent),
      );
    }
  }
}

Future<bool> doesUserExistWithEmail(String email) async {
  final CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');
  final QuerySnapshot result = await usersCollection.where('email', isEqualTo: email).get();
  final List<DocumentSnapshot> documents = result.docs;
  return documents.isNotEmpty;
}
