import 'package:flutter/material.dart';
import 'package:lionsapp/Screens/newPassword.dart';

class AuthCodeScreen extends StatefulWidget {
  const AuthCodeScreen({super.key});

  @override
  _AuthCodeScreenState createState() => _AuthCodeScreenState();
}

class _AuthCodeScreenState extends State<AuthCodeScreen> {
  final TextEditingController _authCodeController = TextEditingController();

  void _submitForm() {
    final String enteredCode = _authCodeController.text;

    // Implement functionality to verify the entered auth code
    // For example, you can use a network call to a backend service to validate the code

    // If the code is valid, navigate to the next screen
    if (enteredCode == '1234') {
      // Replace '1234' with the actual valid code
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => NewPasswordScreen()),
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Fehler'),
            content:
                const Text('Der eingegebene Authentifizierungscode ist ungültig.'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Auth Code eingeben'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Bitte geben Sie den Authentifizierungscode ein, den Sie erhalten haben:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _authCodeController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Auth Code',
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
