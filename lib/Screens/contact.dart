import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:lionsapp/Widgets/burgermenu.dart';

import '../Widgets/appbar.dart';

class Contact extends StatefulWidget {
  const Contact({super.key});

  @override
  _ContactState createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  bool _isSending = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _sendEmail() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isSending = true;
      });

      final Email email = Email(
        body: _messageController.text,
        subject: 'Contact Form Submission',
        recipients: ['xxxx@gmail.com'],
        isHTML: false,
      );

      try {
        await FlutterEmailSender.send(email);
        _showSuccessDialog();
      } catch (error) {
        _showErrorDialog(error.toString());
      } finally {
        setState(() {
          _isSending = false;
        });
      }
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Success'),
        content: const Text('Nachricht erfolgreich gesendet.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showErrorDialog(String errorMessage) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text('Ihre Nachricht wurde nicht gesendet: $errorMessage'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: "Kontakt und Hilfe"),
      drawer: BurgerMenu(),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          children: [
            const SizedBox(height: 16),
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText:
                    'Bitte tragen sie hier ihren Namen ein, damit wir besser bezug zu ihrer Nachricht nehmen können.',
                hintText: 'Vor und Nachname',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Bitte Vor- und Nachnamen eingeben.';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText:
                    'Bitte Email eingeben, über die wir Sie erreichen können.',
                hintText: 'E-Mail',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Bitte E-Mail Adresse eingeben.';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _messageController,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText:
                    'Hier bitte die Nachricht eintragen, die sie uns mitgeben möchten.',
                hintText: 'Nachricht',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Text eingeben.';
                }
                return null;
              },
            ),
            const SizedBox(height: 32),
            _isSending
                ? const Center(child: CircularProgressIndicator())
                : ElevatedButton(
                    onPressed: _sendEmail,
                    child: const Text('Senden'),
                  ),
          ],
        ),
      ),
    );
  }
}

class Contactform extends StatefulWidget {
  const Contactform({super.key});

  @override
  State<Contactform> createState() => _ContactformState();
}

class _ContactformState extends State<Contactform> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
