import 'package:flutter/material.dart';
import 'package:lionsapp/Widgets/appbar.dart';
import 'package:lionsapp/main.dart';
import 'package:lionsapp/Widgets/burgermenu.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

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
      appBar: const MyAppBar(title: "Contact"),
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
                    labelText: 'Bitte tragen Sie hier ihren Namen ein, damit wir einen besseren Bezug zu ihrer Nachricht bekommen.',
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
                const SizedBox(height: 16),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Bitte Email eingeben, über die wir mit Ihnen in Kontakt treten können.',
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
                const SizedBox(height: 16),
                TextFormField(
                  controller: _subjectController,
                  decoration: const InputDecoration(
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
                const SizedBox(height: 16),
                TextFormField(
                  controller: _messageController,
                  maxLines: 6,
                  decoration: const InputDecoration(
                    labelText: 'Hier bitte die Nachricht eintragen, die Sie uns mitgeben möchten.',
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
                Container(
                  margin: const EdgeInsets.only(top: 40),
                  child: const Text("Weitere Daten"),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [Text("Datei zum Hochladen hier reinziehen"), Icon(Icons.upload)],
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        //sendEmail();
                        sendMail(_nameController.text, _emailController.text, _subjectController.text, _messageController.text);
                      }
                    },
                    child: const Text('Senden'),
                  ),
                ),
                const Center(
                  child: Divider(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //works only for Android
  void sendMail(String name, String email, String subject, String msg) async {
    String username = "qimuweb2023@gmail.com";
    String password = 'ojsggwapxmckvusi';
    final smtpServer = gmail(username, password);

    final message = Message()
      ..from = Address(username, 'Team Lions')
      //TODO: Empfänger angeben
      ..recipients.add('')
      //..ccRecipients.addAll(['destCc1@example.com', 'destCc2@example.com'])
      //..bccRecipients.add(Address('bccAddress@example.com'))
      ..subject = '$subject :: 😀 :: ${DateTime.now()}'
      //..text = 'This is the plain text.\nThis is line 2 of the text part.'
      ..html = "<h1>Nachricht von $name mit dem email Adresse $email</h1>\n<p>$msg</p>";

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
  }
}
