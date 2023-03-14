//Licensed under the EUPL v.1.2 or later
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lionsapp/Widgets/textSize.dart';
import 'package:lionsapp/util/color.dart';
import '../../Widgets/appbar.dart';

class UserTypeScreen extends StatefulWidget {
  const UserTypeScreen({Key? key}) : super(key: key);

  @override
  _UserTypeScreenState createState() => _UserTypeScreenState();
}

class _UserTypeScreenState extends State<UserTypeScreen> {
  String? get eventId {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    return args?['eventId'];
  }

  double get amount {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    return args?['amount'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: 'User Type'),
      backgroundColor: const Color.fromARGB(255, 29, 89, 167),
      // set the background color to blue
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/Donations/UserType/Login');
              },
              child: Text('Anmelden', style: CustomTextSize.medium),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                minimumSize: const Size(200, 50),
                backgroundColor:
                    ColorUtils.primaryColor, // set button color to white
              ),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/Donations/UserType/PayMethode',
                    arguments: {'eventId': eventId, 'amount': amount});
              },
              child: Text('Als Gast fortfahren', style: CustomTextSize.medium),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                minimumSize: const Size(200, 50),
                backgroundColor:
                    ColorUtils.primaryColor, // set button color to white
              ),
            ),
          ],
        ),
      ),
    );
  }
}
