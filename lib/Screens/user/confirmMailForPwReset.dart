import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lionsapp/Widgets/burgermenu.dart';

import 'package:lionsapp/Widgets/appbar.dart';

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
            Container(
              margin: const EdgeInsets.only(left: 80, right: 80),
              child: TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  icon: Icon(Icons.mail_outline),
                  hintText:
                      'An diese Adresse wird die Passwort zurücksetzen Mail geschickt',
                  labelText: 'Email Adresse *',
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            MaterialButton(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              elevation: 5.0,
              height: 40,
              onPressed: () {
                resetPassword(email: emailController.text);
                const CircularProgressIndicator();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ),
                );
              },
              color: Colors.white,
              child: const Text(
                "Bestätigen",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ],
        )));
  }
}

//TODO: Anpassen, dass man wenn man auf den Link klickt das PW wenigstens 2x eingeben muss und nicht nur 1x wie es gerade ist
Future<void> resetPassword({required String email}) async {
  await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
}
