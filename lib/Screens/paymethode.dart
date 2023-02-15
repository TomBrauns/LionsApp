import 'package:flutter/material.dart';

class Paymethode extends StatefulWidget {
  const Paymethode({super.key});

  @override
  State<Paymethode> createState() => _PaymethodeState();
}

class _PaymethodeState extends State<Paymethode> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Zahlungsmethode"),
        ),
        body: Center(
            child: SizedBox(
                width: 250,
                height: 500,
                child: Column(children: <Widget>[
                  Container(
                    height: 100,
                    width: 350,
                    padding: const EdgeInsets.all(15.0),
                    margin: const EdgeInsets.all(15),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        elevation: 0,
                      ),
                      onPressed: () {
                        //
                        // Submit missing
                        //
                      },
                      child: const Text("Paypal"),
                    ),
                  ),
                  Container(
                    height: 100,
                    width: 350,
                    padding: const EdgeInsets.all(15.0),
                    margin: const EdgeInsets.all(15),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        elevation: 0,
                      ),
                      onPressed: () {
                        //
                        // Submit missing
                        //
                      },
                      child: const Text("Kartenzahlung/Giro"),
                    ),
                  ),
                ]))));
  }
}
