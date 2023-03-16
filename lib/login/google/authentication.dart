//Licensed under the EUPL v.1.2 or later
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:lionsapp/Screens/donation.dart';
import 'package:lionsapp/Widgets/privileges.dart';
import 'package:lionsapp/login/login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../../Widgets/burgermenu.dart';

class Authentication {
  static SnackBar customSnackBar({required String content}) {
    return SnackBar(
      backgroundColor: Colors.black,
      content: Text(
        content,
        style: TextStyle(color: Colors.redAccent, letterSpacing: 0.5),
      ),
    );
  }

  static Future<FirebaseApp> initializeFirebase({
    required BuildContext context,
  }) async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    User? user = FirebaseAuth.instance.currentUser;
    return firebaseApp;
  }

  //Einloggen und User in Firebase Collection users erstellen, falls er noch nicht existiert
  static Future<User?> signInWithGoogle({required BuildContext context}) async {
    String Endpoint = "https://europe-west3-serviceclub-app.cloudfunctions.net/flask-backend";
    //Stripe Customer Creation
    Future<String> createCustomer(Endpoint, country, email, firstname, lastname) async {
      final body = {
        "country": country,
        "email": email,
        "firstname": firstname,
        "lastname": lastname,
      };

      // Make post request to Stripe

      final response = await http.post(
        Uri.parse('$Endpoint/StripeCreateCustomer'),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: body,
      );

      var jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;
      //print(response.statusCode);
      //print(response.body);
      String Id = jsonResponse['id'];

      return Id;
    }

    //PostDetailsToFirestore Function
    void createUserInFirestore(UserCredential userCredential) async {
      final user = userCredential.user!;
      String vorName = user.displayName!.split(' ')[0];
      String nachName = user.displayName!.split(' ')[1];
      String Email = user.email!;
      String? deviceToken = "";
      if (!kIsWeb) {
        deviceToken = await FirebaseMessaging.instance.getToken();
      }
      final String customerId = await createCustomer(Endpoint, "DE", Email, vorName, nachName);
      CollectionReference ref = FirebaseFirestore.instance.collection('users');
      if (!(await ref.doc(user.uid).get()).exists) {
        ref.doc(user.uid).set(
          {
            'firstname': vorName,
            'lastname': nachName,
            'email': Email,
            'rool': 'Friend',
            'device': deviceToken,
            'receiveNotification': true,
            'stripeCustomerId': customerId,
          },
        );
      } else {
        //update deviceToken at every login, when on mobile device
        if (!kIsWeb) {
          ref.doc(user.uid).update(
            {
              'device': deviceToken,
            },
          );
        }
      }
      checkRool();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Donations(),
        ),
      );
    }

    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    //wenn WEB
    if (kIsWeb) {
      GoogleAuthProvider authProvider = GoogleAuthProvider();
      try {
        //einloggen
        final UserCredential userCredential = await auth.signInWithPopup(authProvider);
        createUserInFirestore(userCredential);
        //User in Firebase anlegen
      } catch (e) {}
      //wenn NICHT WEB
    } else {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        try {
          final UserCredential userCredential = await auth.signInWithCredential(credential);
          createUserInFirestore(userCredential);
        } catch (e) {}
      }
    }

    return user;
  }
}
