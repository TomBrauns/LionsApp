import 'package:flutter/material.dart';
import 'package:lionsapp/widgets/burgermenu.dart';

class Imprint extends StatefulWidget {
  const Imprint({Key? key}) : super(key: key);

  @override
  State<Imprint> createState() => _ImprintState();
}

class _ImprintState extends State<Imprint> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const BurgerMenu(),
      appBar: AppBar(
        title: const Text("Impressum"),
      ),
    );
  }
}
