import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../Widgets/appbar.dart';

class UserTypeScreen extends StatefulWidget{
  const UserTypeScreen({Key? key}) : super(key: key);

  @override
  _UserTypeScreenState createState() => _UserTypeScreenState();
}


class _UserTypeScreenState extends State<UserTypeScreen> {
  String? get eventId{
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    return args?['eventId'];
  }


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
                Navigator.pushNamed(context, '/Donations/UserType/PayMethode', arguments: {'eventId': eventId});
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
