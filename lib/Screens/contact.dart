import 'package:cloud_firestore/cloud_firestore.dart';
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

  void _handleSubmit() {
    String text = "Sie haben eine neue Nachricht von:\n";
    text += "Name: ${_nameController.text}\n";
    text += "E-Mail: ${_emailController.text}\n";
    text += "\n";
    text += _messageController.text;
    FirebaseFirestore.instance.collection("mail").add({
      "to": "teamlions@web.de",
      "message": {"subject": _subjectController.text, "text": text}
    });
    Navigator.pushNamed(context, '/Donations');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Ihre Kontaktanfrage wurde versendet!'),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(top: 64),

      ),
    );
  }

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
                    helperText: 'Mit diesem Namen werden wir Sie zukünftig ansprechen.',
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
                    helperText: 'Wir werden unsere Antwort auf Ihre Anfrage an diese E-Mail-Adresse senden.',
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
                    helperText: 'Pflichtfeld: Bitte fassen Sie Ihr Anliegen in wenigen Worten zusammen.',
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
                    helperText: 'Pflichtfeld: Bitte schreiben Sie uns hier, worum es geht.',
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
                          _handleSubmit();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Bitte überprüfen Sie ihre Eingaben!'),
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
}
