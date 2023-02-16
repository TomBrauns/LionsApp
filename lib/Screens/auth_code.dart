import 'package:flutter/material.dart';

class AuthCodeScreen extends StatefulWidget {
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
        title: Text('Auth Code eingeben'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bitte geben Sie den Authentifizierungscode ein, den Sie erhalten haben:',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _authCodeController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Auth Code',
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
