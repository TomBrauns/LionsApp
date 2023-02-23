import 'package:flutter/material.dart';
import 'package:lionsapp/Screens/payment/paymethode.dart';
import 'package:lionsapp/login/login.dart';


//TODO: Add Appbar + Burgermenu to this screen
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
                Navigator.pushNamed(context, '/Donations/UserType/PayMethode');
              },
              child: const Text('Als Gast fortfahren'),
            ),
            const SizedBox(height: 20),

            //TODO: Wenn hier jemand rausfindet wie man von der Route mit nem POP zurückkommt ists fast schon gg
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/Donations/UserType/Login');
              },
              child: const Text('Anmelden'),
            ),
          ],
        ),
      ),
    );
  }
}
