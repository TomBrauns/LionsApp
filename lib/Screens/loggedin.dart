import 'package:flutter/material.dart';

class LoggedInScreen extends StatefulWidget {
  @override
  _LoggedInScreenState createState() => _LoggedInScreenState();
}

class _LoggedInScreenState extends State<LoggedInScreen> {
  String selectedSubscription = 'keins';
  double _betrag = 0.0;

  void _addBetrag(double value) {
    setState(() {
      _betrag += value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Logged In'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              decoration: const InputDecoration(
                labelText: 'Betrag',
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  _betrag = double.tryParse(value) ?? 0.0;
                });
              },
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () => _addBetrag(5),
                  child: const Text('+5 Euro'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () => _addBetrag(10),
                  child: const Text('+10 Euro'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () => _addBetrag(100),
                  child: const Text('+100 Euro'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Spenden'),
            ),
            const SizedBox(height: 20),
            CheckboxListTile(
              title: const Text('Quittung?'),
              value: false,
              onChanged: (value) {},
            ),
            const SizedBox(height: 20),
            DropdownButton<String>(
              value: selectedSubscription,
              items: <String>[
                'keins',
                'pro Monat',
                'alle 6 Monate',
                'jedes Jahr'
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedSubscription = value ?? 'keins';
                });
              },
              hint: const Text('Spenden Abo'),
            ),
          ],
        ),
      ),
    );
  }
}
