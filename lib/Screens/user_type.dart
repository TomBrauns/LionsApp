import 'package:flutter/material.dart';

class UserTypeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // TODO: Implement the 'Gast' button's functionality
              },
              child: Text('Gast'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // TODO: Implement the 'Anmelden' button's functionality
              },
              child: Text('Anmelden'),
            ),
            Text(
              'Noch kein Konto?',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // TODO: Implement the 'Hier registrieren' button's functionality
              },
              child: Text('Hier registrieren'),
            ),
          ],
        ),
      ),
    );
  }
}
