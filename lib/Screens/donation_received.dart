import 'package:flutter/material.dart';
import 'package:lionsapp/Screens/donation.dart';
import 'package:lionsapp/Screens/contact.dart';
import 'package:lionsapp/Screens/events/events_liste.dart';
import '../../Widgets/appbar.dart';
import 'package:lionsapp/Widgets/burgermenu.dart';
import 'package:url_launcher/url_launcher.dart';

// Test Values
// ignore: non_constant_identifier_names
String DonationProjectName = "Test Projekt";
// ignore: non_constant_identifier_names
var DonationAmount = 1;

class DonationReceived extends StatefulWidget {
  const DonationReceived({super.key});

  @override
  State<DonationReceived> createState() => _DonationReceivedState();
}

class _DonationReceivedState extends State<DonationReceived> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const MyAppBar(title: "Danke für ihre Spende"),
        drawer: const BurgerMenu(),
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
                Navigator.pushNamed(context, '/Contact');
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
                Navigator.pushNamed(context, '/ThankYou/Receipt');
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
                Navigator.pushNamed(context, '/ThankYou/ShareDonation');
              },
            ),
          ),
          ButtonBar(
            mainAxisSize: MainAxisSize.min,
            // this will take space as minimum as possible(to center)
            children: <Widget>[
              ElevatedButton(
                child: const Text('Zurück zum Spenden'),
                onPressed: () {
                  // Push to Screen
                  Navigator.pushNamed(context, '/Donations');
                },
              ),

              // TODO: Right now this button is only supposed to show for Friends / Members / Admins, Guests are not supposed to see this
              ElevatedButton(
                child: const Text('Weitere Events'),
                onPressed: () {
                  // Update State of App
                  Navigator.pop(context);
                  // Push to Screen
                  Navigator.pushNamed(context, '/Events');
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
            child: Text(
                "Angemeldete Nutzer erhalten automatisch Quittungen per Mail"),
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

void shareToFacebook() async {
  final url = 'https://www.facebook.com/sharer/sharer.php?u=https://marc-wieland.de';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}



class _ShareDonationState extends State<ShareDonation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Teile deine Spende"),
        ),
        body: Center(
            child:
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: ElevatedButton(
                    onPressed: (){
                      shareToFacebook();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: const Color(0xFF1877F2),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)
                      ),
                      minimumSize: const Size(double.infinity, 50.0)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const <Widget>[
                        Icon(Icons.facebook,color: Colors.white),
                        SizedBox(
                            width: 10
                        ),
                        Text(
                            'Auf Facebook teilen',
                            style: TextStyle(color: Colors.white)
                        )
                      ],
                    ),
                  ),
                )

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