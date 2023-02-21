import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lionsapp/Screens/donation.dart';
import 'package:lionsapp/Screens/imprint.dart';
import 'firebase_options.dart';
import 'package:lionsapp/login/login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseAuth.instance.authStateChanges().listen((User? user) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    if (user != null) {
      String uid = user.uid;
      print("User ID: $uid");
      print("There's a active User!");
      await checkRool();
    }
  });
  //await checkRool();
  /*await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyDK3jiaInoOq5NqipMNVujttL0VJr7DcKw",
          appId: "1:923321843822:android:e238895b700aaf2180e67f",
          messagingSenderId: "923321843822",
          projectId: "lionsapp-973b3"));*/
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blue[900],
      ),
      home: Donations(),
    );
  }
}
