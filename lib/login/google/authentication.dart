import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:lionsapp/Screens/donation.dart';
import 'package:lionsapp/Widgets/privileges.dart';
import 'package:lionsapp/login/login.dart';

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
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    //wenn WEB
    if (kIsWeb) {
      GoogleAuthProvider authProvider = GoogleAuthProvider();
      try {
        //einloggen
        final UserCredential userCredential = await auth.signInWithPopup(authProvider);
        //User in Firebase anlegen
        user = userCredential.user!;
        String vorName = user.displayName!.split(' ')[0];
        String nachName = user.displayName!.split(' ')[1];
        String Email = user.email!;
        FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
        CollectionReference ref = FirebaseFirestore.instance.collection('users');
        if (!(await ref.doc(user.uid).get()).exists) {
          ref.doc(user.uid).set(
            {
              'firstname': vorName,
              'lastname': nachName,
              'email': Email,
              'rool': 'Friend',
            },
          );
        }
        //Rolle checken und weiterleiten
        FirebaseFirestore.instance.collection('users').doc(user.uid).get().then(
          (DocumentSnapshot documentSnapshot) {
            if (documentSnapshot.exists) {
              checkRool();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => Donations(),
                ),
              );
            } else {
              print('Document does not exist on the database');
            }
          },
        );
      } catch (e) {
        print(e);
      }
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
          user = userCredential.user!;
          String vorName = user.displayName!.split(' ')[0];
          String nachName = user.displayName!.split(' ')[1];
          String Email = user.email!;
          FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
          CollectionReference ref = FirebaseFirestore.instance.collection('users');
          if (!(await ref.doc(user.uid).get()).exists) {
            ref.doc(user.uid).set(
              {
                'firstname': vorName,
                'lastname': nachName,
                'email': Email,
                'rool': 'Friend',
              },
            );
          }
          FirebaseFirestore.instance.collection('users').doc(user.uid).get().then(
            (DocumentSnapshot documentSnapshot) {
              if (documentSnapshot.exists) {
                checkRool();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Donations(),
                  ),
                );
              } else {
                print('Document does not exist on the database');
              }
            },
          );
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            Authentication.customSnackBar(
              content: 'Error beim Einloggen mit Google.',
            ),
          );
        }
      }
    }

    return user;
  }
}
