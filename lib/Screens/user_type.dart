import 'package:flutter/material.dart';

class UserTypeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // TODO: Implement the 'Gast' button's functionality
              },
              child: const Text('Gast'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // TODO: Implement the 'Anmelden' button's functionality
              },
              child: const Text('Anmelden'),
            ),
            const Text(
              'Noch kein Konto?',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // TODO: Implement the 'Hier registrieren' button's functionality
              },
              child: const Text('Hier registrieren'),
            ),
          ],
        ),
      ),
    );
  }
}
