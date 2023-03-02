import 'package:flutter/material.dart';
import '../../Widgets/appbar.dart';

class UserTypeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: 'User Type'),
      backgroundColor:
          const Color.fromARGB(255, 29, 89, 167), // set the background color to blue
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/Donations/UserType/PayMethode');
              },
              child: const Text(
                'Als Gast fortfahren',
                style: TextStyle(
                    color: Colors.black,
                    fontSize:
                        20), // set text color to dark and increase font size
              ),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                minimumSize: const Size(200, 50),
                primary: Colors.white, // set button color to white
              ),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/Donations/UserType/Login');
              },
              child: Text(
                'Anmelden',
                style: TextStyle(
                    color: Colors.black,
                    fontSize:
                        20), // set text color to dark and increase font size
              ),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                minimumSize: const Size(200, 50),
                primary: Colors.white, // set button color to white
              ),
            ),
          ],
        ),
      ),
    );
  }
}
