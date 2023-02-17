import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

import '../Widgets/appbar.dart';

class Contact extends StatefulWidget {
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
        title: Text('Success'),
        content: Text('Nachricht erfolgreich gesendet.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showErrorDialog(String errorMessage) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text('Ihre Nachricht wurde nicht gesendet: $errorMessage'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Kontakt und Hilfe"),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 16),
          children: [
            SizedBox(height: 16),
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                hintText: 'Vor uund Nachnamen eingeben',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Bitte, Vor und Nachname eingeben.';
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                hintText: 'E-Mail eingeben',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Bitte E-Mail Adresse eingeben.';
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _messageController,
              maxLines: 5,
              decoration: InputDecoration(
                labelText: 'Text',
                hintText: 'Text hier tippen',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Text eingeben.';
                }
                return null;
              },
            ),
            SizedBox(height: 32),
            _isSending
                ? Center(child: CircularProgressIndicator())
                : ElevatedButton(
                    onPressed: _sendEmail,
                    child: Text('Senden'),
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
