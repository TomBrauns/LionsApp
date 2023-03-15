//Licensed under the EUPL v.1.2 or later
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lionsapp/Widgets/appbar.dart';
import 'package:lionsapp/Widgets/burgermenu.dart';
import 'package:lionsapp/Widgets/textSize.dart';

import '../util/color.dart';

class Contact extends StatefulWidget {
  const Contact({Key? key}) : super(key: key);

  @override
  State<Contact> createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: "Kontakt"),
      drawer: BurgerMenu(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    helperText:
                        'Mit diesem Namen werden wir Sie zukünftig ansprechen.',
                    labelText: 'Vor- und Nachname',
                    helperMaxLines: 10,
                    errorMaxLines: 10,
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    helperText:
                        'Wir werden unsere Antwort auf Ihre Anfrage an diese E-Mail-Adresse senden.',
                    helperMaxLines: 10,
                    errorMaxLines: 10,
                    labelText: 'E-Mail-Adresse',
                    border: OutlineInputBorder(),
                  ),
                  /*  validator: (value) {
                    if (value!.length == 0) {
                      return "Email darf nicht leer sein";
                    }
                    if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
                      return ("Bitte gültige Email Adresse angeben");
                    } else {
                      return null;
                    }
                  },*/
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _subjectController,
                  decoration: const InputDecoration(
                    labelText: '* Betreff',
                    helperText:
                        'Pflichtfeld: Bitte fassen Sie Ihr Anliegen in wenigen Worten zusammen.',
                    helperMaxLines: 10,
                    errorMaxLines: 10,
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Bitte fassen Sie Ihr Anliegen in wenigen Worten zusammen.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _messageController,
                  maxLines: 6,
                  textAlign: TextAlign.start,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: const InputDecoration(
                    labelText: '* Ihre Nachricht',
                    helperText:
                        'Pflichtfeld: Bitte schreiben Sie uns hier, worum es geht.',
                    border: OutlineInputBorder(),
                    helperMaxLines: 10,
                    errorMaxLines: 10,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Bitte geben Sie Ihre Nachricht ein.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 32),
                Center(
                  child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          sendMail(_nameController.text, _emailController.text,
                              _subjectController.text, _messageController.text);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                                  Text('Bitte überprüfen Sie ihre Eingaben!'),
                              backgroundColor: Colors.red,
                              behavior: SnackBarBehavior.floating,
                              margin: EdgeInsets.only(top: 64),
                            ),
                          );
                        }
                      },
                      child: Text("Senden", style: CustomTextSize.large)),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> sendMail(
      String? name, String? eMail, String subject, String msg) async {
    var data = {
      'mailOptions': {
        'to': 'info@serviceclub-app.de',
        'subject': subject,
        'text': 'Neue Mitteilung von $name mit der Email Adresse: $eMail\n$msg',
      }
    };

    final HttpsCallable callable =
        FirebaseFunctions.instance.httpsCallable('sendEmailWithAttachments');
    try {
      await callable(data);
      Navigator.pushNamed(context, '/Donations');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Vielen Dank für Ihre Nachricht!'),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(top: 64),
        ),
      );
      sendCopyMailToCreator(name, eMail, subject, msg);
      print("mail sent");
    } catch (e) {
      print('Error sending email: $e');
    }
  }

  Future<void> sendCopyMailToCreator(
      String? name, String? eMail, String subject, String msg) async {
    if (eMail!.isNotEmpty) {
      var data = {
        'mailOptions': {
          'from': 'info@serviceclub-app.de',
          'to': eMail,
          'subject': 'Ihre Nachricht an Service Club "$subject"',
          'text':
              'Hallo $name,\nVielen Dank für Ihre Nachricht!\n\nIhre Nachricht lautete:\n$msg\n\n Wir versuchen Ihnen so schnell wie möglich zu antworten!\n Ihr Service Club Team!',
          /* 'attachments': [
          //TODO: Pfad der späteren Quittung und Text bisschen anpassen
          {'filename': '', 'path': pdf},
        ], */
        }
      };

      final HttpsCallable callable =
          FirebaseFunctions.instance.httpsCallable('sendEmailWithAttachments');
      try {
        await callable(data);
      } catch (e) {
        print('Error sending email: $e');
      }
    }
  }
}
