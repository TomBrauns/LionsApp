import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';import 'package:lionsapp/Widgets/burgermenu.dart';

import 'package:mailer/smtp_server/gmail.dart';

class Contact extends StatefulWidget {
  const Contact({super.key});

  @override
  _ContactState createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> sendEmail() async {
    final name = _nameController.text;
    final email = _emailController.text;
    final subject = _subjectController.text;
    final message = _messageController.text;

    final smtpServer = gmail('xxx@gmail.com', 'passwort');
    final emailMessage = Message()
      ..from = Address(email, name)
      ..recipients.add('xxx@gmail.com')
      ..subject = subject
      ..text = message;

    try {
      await send(emailMessage, smtpServer);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Nachricht erfolgreich gesendet'),
      ));
      _formKey.currentState!.reset();
    } on MailerException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
            'Es ist ein Fehler aufgetreten. Bitte versuchen Sie es später noch einmal.'),
      ));
      print('Fehler beim Versenden der E-Mail: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Kontakt Formular'),
        ),
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
                    decoration: InputDecoration(
                      labelText: 'Bitte tragen sie hier ihren Namen ein, damit wir besser bezug zu ihrer Nachricht nehmen können.',
                      hintText: 'Vor und Nachnamen eingeben',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vor und Nachnamen eingeben';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Bitte Email eingeben, über die wir Sie erreichen können.',
                      hintText: 'E-Mail eingeben',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email eingeben ';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _subjectController,
                    decoration: InputDecoration(
                      labelText: 'Betreff',
                      hintText: 'Betreff eingeben',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Betreff eingeben';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _messageController,
                    maxLines: 6,
                    decoration: InputDecoration(
                      labelText: 'Hier bitte die Nachricht eintragen, die sie uns mitgeben möchten.',
                      hintText: 'Nachricht tippen',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Text tippen';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        sendEmail();
                      }
                    },
                    child: Text('Senden'),
                  ),
                  Center(
                    child: Divider(),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
