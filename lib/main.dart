import 'package:flutter/material.dart';
import './Widgets/burgermenu.dart';
import '../Screens/donation.dart';

import 'Widgets/datepicker.dart';

//Hier mal ein Kommi, um den Branch zu testen

void main() {
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
