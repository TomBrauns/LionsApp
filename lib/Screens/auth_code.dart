import 'package:flutter/material.dart';

class AuthCodeScreen extends StatefulWidget {
  const AuthCodeScreen({super.key});

  @override
  _AuthCodeScreenState createState() => _AuthCodeScreenState();
}

class _AuthCodeScreenState extends State<AuthCodeScreen> {
  final TextEditingController _authCodeController = TextEditingController();

  void _submitForm() {
    // TODO: Implement functionality to verify the entered auth code
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
