import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lionsapp/widgets/burgermenu.dart';

class _Eingeloggt extends StatefulWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const BurgerMenu(),
      appBar: AppBar(
        title: const Text("Eingeloggt"),
      ),
      body: Column(
      TextField( 
        String value = "";
    onChanged: (text) {
    value = text;
  },
)
)
    );
  }
}
