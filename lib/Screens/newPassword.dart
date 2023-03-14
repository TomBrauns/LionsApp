//Licensed under the EUPL v.1.2 or later
import 'package:flutter/material.dart';

class NewPasswordScreen extends StatefulWidget {
  @override
  _NewPasswordScreenState createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _repeatPasswordController =
      TextEditingController();

  void _submitForm() {
    // TODO: Implement functionality to update the user's password
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Neues Passwort festlegen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Bitte geben Sie Ihr neues Passwort ein:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _newPasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Neues Passwort',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _repeatPasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Passwort wiederholen',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitForm,
              child: const Text('Bestätigen'),
            ),
          ],
        ),
      ),
    );
  }
}
