import 'package:flutter/material.dart';
import 'package:lionsapp/Screens/donation.dart';
import 'package:lionsapp/Screens/contact.dart';
import 'package:lionsapp/Screens/events/events_liste.dart';
// Test Values
// ignore: non_constant_identifier_names
String DonationProjectName = "Test Projekt";
// ignore: non_constant_identifier_names
var DonationAmount = 1;
//

class DonationReceived extends StatefulWidget {
  const DonationReceived({super.key});

  @override
  State<DonationReceived> createState() => _DonationReceivedState();
}

class _DonationReceivedState extends State<DonationReceived> {
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
                "Danke für ihre Spende von $DonationAmount€ an $DonationProjectName ."
                    "Wenn sie uns noch etwas mitteilen wollen, zögern sie nicht uns "
                    "über das Kontaktformular zu erreichen."),
          ),
              Container(
                margin: const EdgeInsets.all(25),
                child: ElevatedButton.icon(
                  icon: const Icon(
                    Icons.receipt,
                    size: 24.0,
                  ),
                  label: const Text('Kontaktformular'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    elevation: 0,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Contact()),
                    );
                  },
                ),
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
                backgroundColor: Colors.blue,
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
                backgroundColor: Colors.blue,
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

              // TODO: Right now this button is only supposed to show for Friends / Members / Admins, Guests are not supposed to see this
              ElevatedButton(
                child: const Text('Weitere Events'),
                onPressed: () {
                  // Update State of App
                  Navigator.pop(context);
                  // Push to Screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Events()),
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
            margin: const EdgeInsets.all(40),
            height: 50,
            child: ElevatedButton.icon(
              icon: const Icon(
                Icons.download,
                size: 24.0,
              ),
              label: const Text('PDF herunterladen'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                elevation: 0,
              ),
              onPressed: () {},
            ),
          ),
          Container(
            margin: const EdgeInsets.all(40),
            height: 50,
            child: ElevatedButton.icon(
              icon: const Icon(
                Icons.cloud_upload,
                size: 24.0,
              ),
              label: const Text('Cloud hochladen'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                elevation: 0,
              ),
              onPressed: () {},
            ),
          ),
              Container(
                margin: const EdgeInsets.all(40),
                height: 50,
                child: Text("Angemeldete Nutzer erhalten automatisch Quittungen per Mail"),

              ),
        ])));
  }
}

// The Following ReceiptEmail-Class is deprecated and is no longer in use due to
// an user being able to missspelling their Email. Its saver to just open this possibility to
// Signed in users and by automatizing it

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
                      decoration: const InputDecoration(
                        labelText: 'eMail',
                      ),
                      obscureText: false,
                      onSubmitted: (value) {},
                    ),
                    Container(
                      margin: const EdgeInsets.all(25),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          elevation: 0,
                        ),
                        onPressed: () {},
                        child: const Text("Bestätigen"),
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
                                      const DonationReceived()));
                        },
                      ),
                    ),
                  ],
                ))));
  }
}
