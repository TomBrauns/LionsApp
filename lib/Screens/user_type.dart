import 'package:flutter/material.dart';
import 'package:lionsapp/Screens/payment/paymethode.dart';
import 'package:lionsapp/login/login.dart';

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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Paymethode()),
                );
              },
              child: const Text('Als Gast fortfahren'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: const Text('Anmelden'),
            ),
          ],
        ),
      ),
    );
  }
}
