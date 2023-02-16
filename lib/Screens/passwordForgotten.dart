import 'package:flutter/material.dart';

class PasswordForgottenScreen extends StatefulWidget {
  @override
  _PasswordForgottenScreenState createState() =>
      _PasswordForgottenScreenState();
}

class _PasswordForgottenScreenState extends State<PasswordForgottenScreen> {
  final TextEditingController _emailController = TextEditingController();

  void _submitForm() {
    // TODO: Implement functionality to send email to reset password
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Password vergessen'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bitte geben Sie Ihre E-Mail-Adresse ein, um Ihr Passwort zurückzusetzen:',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'E-Mail',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitForm,
              child: Text('Bestätigen'),
            ),
          ],
        ),
      ),
    );
  }
}
