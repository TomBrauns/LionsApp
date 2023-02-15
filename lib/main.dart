import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import './Widgets/burgermenu.dart';
import '../Screens/donation.dart';

import 'Widgets/datepicker.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lions App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Donations(),
    );
  }
}
