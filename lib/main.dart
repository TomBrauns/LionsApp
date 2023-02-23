import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lionsapp/Screens/donation.dart';
import 'package:lionsapp/Screens/home.dart';
import 'package:lionsapp/Screens/imprint.dart';
import 'firebase_options.dart';
import 'package:lionsapp/login/login.dart';
import 'package:lionsapp/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  reAuthenticateUser();

  String myurl = Uri.base.toString();
  String? paramId = Uri.base.queryParameters['docid'];
  print(paramId);

  runApp(MyApp(documentId: paramId));
}

class MyApp extends StatefulWidget {
  String? documentId;
  MyApp({super.key, this.documentId});

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
      //home: Donations(interneId: widget.documentId),
      initialRoute: '/Donations',
      routes: routes,
    );
  }
}
