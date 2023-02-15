import 'package:flutter/material.dart';
import 'package:lionsapp/Screens/donation.dart';
import 'package:lionsapp/main.dart';

// Test Values
String DonationProjectName = "Test Projekt";
var DonationAmount = 1;
//

class DonationRecieved extends StatefulWidget {
  const DonationRecieved({super.key});

  @override
  State<DonationRecieved> createState() => _DonationRecievedState();
}

class _DonationRecievedState extends State<DonationRecieved> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Danke fürs Spenden"),
        ),
        body: Center(
            child: Column(children: <Widget>[
          Container(
            margin: const EdgeInsets.all(40),
            padding: const EdgeInsets.all(40.0),
            decoration: BoxDecoration(
                color: Color.fromARGB(156, 141, 196, 241),
                border: Border.all(color: Colors.blueAccent)),
            child: Text(
                "Danke für ihre Spende von $DonationAmount€ an $DonationProjectName"),
          ),
          Container(
            margin: const EdgeInsets.all(25),
            child: ElevatedButton.icon(
              icon: const Icon(
                Icons.receipt,
                size: 24.0,
              ),
              label: const Text('Quittung'),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                elevation: 0,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Receipt()),
                );
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.all(25),
            child: ElevatedButton.icon(
              icon: const Icon(
                Icons.share,
                size: 24.0,
              ),
              label: const Text('Teilen'),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                elevation: 0,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ShareDonation()),
                );
              },
            ),
          ),
          ButtonBar(
            mainAxisSize: MainAxisSize
                .min, // this will take space as minimum as posible(to center)
            children: <Widget>[
              ElevatedButton(
                child: const Text('Startseite'),
                onPressed: () {
                  // Update State of App
                  Navigator.pop(context);
                  // Push to Screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Donations()),
                  );
                },
              ),
              ElevatedButton(
                child: const Text('Eventseite'),
                onPressed: () {
                  // Update State of App
                  Navigator.pop(context);
                  // Push to Screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Donations()),
                  );
                },
              ),
            ],
          ),
        ])));
  }
}

class Receipt extends StatefulWidget {
  const Receipt({super.key});

  @override
  State<Receipt> createState() => _ReceiptState();
}

class _ReceiptState extends State<Receipt> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Quittung"),
        ),
        body: Center(
            child: Column(children: <Widget>[
          Container(
            margin: EdgeInsets.all(40),
            height: 50,
            child: ElevatedButton.icon(
              icon: Icon(
                Icons.download,
                size: 24.0,
              ),
              label: Text('PDF herunterladen'),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                elevation: 0,
              ),
              onPressed: () {},
            ),
          ),
          Container(
            margin: EdgeInsets.all(40),
            height: 50,
            child: ElevatedButton.icon(
              icon: Icon(
                Icons.email,
                size: 24.0,
              ),
              label: Text('Email senden'),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                elevation: 0,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ReceiptEmail()));
              },
            ),
          ),
          Container(
            margin: EdgeInsets.all(40),
            height: 50,
            child: ElevatedButton.icon(
              icon: Icon(
                Icons.cloud_upload,
                size: 24.0,
              ),
              label: Text('Cloud hochladen'),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                elevation: 0,
              ),
              onPressed: () {},
            ),
          ),
        ])));
  }
}

class ReceiptEmail extends StatefulWidget {
  const ReceiptEmail({super.key});

  @override
  State<ReceiptEmail> createState() => _ReceiptEmailState();
}

class _ReceiptEmailState extends State<ReceiptEmail> {
  String EMail = "";
  final myController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Quittung"),
        ),
        body: Center(
            child: SizedBox(
                width: 250,
                height: 200,
                child: Column(
                  children: <Widget>[
                    TextField(
                      controller: myController,
                      decoration: InputDecoration(
                        labelText: 'eMail',
                      ),
                      obscureText: false,
                      onSubmitted: (value) {},
                    ),
                    Container(
                      margin: EdgeInsets.all(25),
                      child: ElevatedButton(
                        child: Text("Bestätigen"),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue,
                          elevation: 0,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ))));
  }
}

//Social Media missing
class ShareDonation extends StatefulWidget {
  const ShareDonation({super.key});

  @override
  State<ShareDonation> createState() => _ShareDonationState();
}

class _ShareDonationState extends State<ShareDonation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Teile deine Spende"),
      ),
    );
  }
}

class Receiptdata extends StatefulWidget {
  const Receiptdata({super.key});

  @override
  State<Receiptdata> createState() => _ReceiptdataState();
}

class _ReceiptdataState extends State<Receiptdata> {
  final myController = TextEditingController();
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Quittung"),
        ),
        body: Center(
            child: SizedBox(
                width: 250,
                height: 500,
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.all(15),
                    ),
                    TextField(
                      controller: myController,
                      decoration: InputDecoration(
                        labelText: 'Vor-/Nachname',
                      ),
                      obscureText: false,
                      onSubmitted: (value) {},
                    ),
                    Container(
                      margin: const EdgeInsets.all(15),
                    ),
                    TextField(
                      controller: myController,
                      decoration: InputDecoration(
                        labelText: 'Postleitzahl u. Ort',
                      ),
                      obscureText: false,
                      onSubmitted: (value) {},
                    ),
                    Container(
                      margin: const EdgeInsets.all(15),
                    ),
                    TextField(
                      controller: myController,
                      decoration: InputDecoration(
                        labelText: 'Straße u. Hausnummer',
                      ),
                      obscureText: false,
                      onSubmitted: (value) {},
                    ),
                    Container(
                      margin: const EdgeInsets.all(15),
                    ),
                    Container(
                        child: Row(children: <Widget>[
                      Checkbox(
                        value: isChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            isChecked = value!;
                          });
                        },
                      ),
                      const Text(
                        "Daten speichern?",
                      ),
                    ])),
                    Container(
                      margin: EdgeInsets.all(25),
                      child: ElevatedButton(
                        child: Text("Weiter"),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue,
                          elevation: 0,
                        ),
                        onPressed: () {
                          //
                          // Submit missing
                          //
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const DonationRecieved()));
                        },
                      ),
                    ),
                  ],
                ))));
  }
}
