import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lionsapp/Widgets/burgermenu.dart';
import 'package:lionsapp/Widgets/bottomNavigationView.dart';
import 'package:lionsapp/Widgets/appbar.dart';
import 'package:lionsapp/Widgets/privileges.dart';

import '../Widgets/dual_progress_bar.dart';

class Donations extends StatefulWidget {
  final String? interneId;
  final String? projectId;

  const Donations({Key? key, this.interneId, this.projectId}) : super(key: key);

  @override
  State<Donations> createState() => _DonationsState();
}

class _DonationsState extends State<Donations> {
  var _documentStream;

  String? eventId;
  String? projectId;
  double _donationInput = 0.0;

  // BAB with Priviledge
  //Copy that
  Widget? _getBAB() {
    if (Privileges.privilege == "Admin" || Privileges.privilege == "Member" || Privileges.privilege == "Friend") {
      return BottomNavigation();
    } else {
      return null;
    }
  }

  @override
  void initState() {
    super.initState();

    //Umwandlung der aus der main.dart kommenden Document ID in eine Variable der Klasse _DonationState
    eventId = widget.interneId;
    projectId = widget.projectId;

    print("Hier EventID: $eventId");
    print("Hier ProjectID: $projectId");
    print("Hier widget id: ${widget.interneId}");

    if (eventId != null && eventId!.isNotEmpty) {
      _documentStream = FirebaseFirestore.instance.collection('events').doc(eventId).snapshots();
    } else if (projectId != null && projectId!.isNotEmpty) {
      _documentStream = FirebaseFirestore.instance.collection("projects").doc(projectId).snapshots();
    }
  }

  void _handleInputChange(String? text) {
    setState(() {
      _donationInput = _parseEuroStringToDouble(text);
    });
  }

  double _parseEuroStringToDouble(String? text) {
    if (text == null || text.isEmpty) {
      return 0.0;
    } else {
      text = text.replaceAll("€", "");
      text = text.replaceAll(".", "");
      text = text.replaceAll(",", ".");
      return double.parse(text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        drawer: const BurgerMenu(),
        appBar: const MyAppBar(title: "Spenden"),
        bottomNavigationBar: _getBAB(),
        body: StreamBuilder<DocumentSnapshot>(
            stream: _documentStream,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }

              //Hilfsvariable mit Null-Check, da Wert aus Datenbank auch leer sein kann bzw. init bei QR-Scan

              String donationTitle = "Kein Event gefunden.";
              String? sponsor, sponsorImgUrl, donationTarget;
              int spendenCounter = 0;

              if (snapshot.hasData && snapshot.data!.exists) {
                Map<String, dynamic>? data = snapshot.data!.data() as Map<String, dynamic>?;
                if (eventId != null && eventId!.isNotEmpty) {
                  if (data != null) {
                    if (data.containsKey("spendenZiel")) {
                      donationTarget = data["spendenZiel"] as String?;
                    }
                    if (data.containsKey('eventName')) {
                      donationTitle = data['eventName'] as String;
                    }
                    if (data.containsKey("sponsor")) {
                      sponsor = data["sponsor"] as String?;
                    }
                    if (data.containsKey("sponsor_img_url")) {
                      sponsorImgUrl = data["sponsor_img_url"] as String?;
                    }
                    if (data.containsKey("currentDonationValue")) {
                      spendenCounter = data["currentDonationValue"];
                      print(spendenCounter);
                    }
                  }
                } else if (projectId != null && projectId!.isNotEmpty) {
                  if (data != null) {
                    donationTitle = data["name"] as String;
                  }
                }
              }

              Future<void> _updateDonationValue(int newDonationValue) async {
                try {
                  print("Hier in Funktion");
                  // Get a reference to the document that needs to be updated
                  final documentReference = FirebaseFirestore.instance.collection('events').doc(eventId);

                  // Update the value of the 'currentDonationValue' field with the new value
                  await documentReference.update({'currentDonationValue': newDonationValue});

                  print('Donation value updated successfully');
                } catch (e) {
                  print('Error updating donation value: $e');
                }
              }
              //String donationTitle = snapshot.data?.get('eventName') ?? "";

              return Container(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                              width: double.infinity,
                              child: Text(donationTitle,
                                  textAlign: TextAlign.center, style: const TextStyle(fontSize: 24))),
                          if (donationTarget != null)
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 32),
                              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                Text("Spendenziel: ${spendenCounter} € / $donationTarget", style: const TextStyle(fontSize: 16)),
                                DualLinearProgressIndicator(
                                  maxValue: _parseEuroStringToDouble(donationTarget),
                                  progressValue: spendenCounter.toDouble(),
                                  addValue: _donationInput,

                                )
                              ]),
                            )
                          else
                            const SizedBox(height: 64),
                          const SizedBox(height: 8),
                          TextFormField(
                            controller: _inputController,
                            onChanged: _handleInputChange,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(), hintText: "Betrag", suffix: Text("€")),
                          ),
                          Container(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [5, 10, 25, 50, 100]
                                      .map((int amount) =>
                                          FilledButton(onPressed: () => _handleAdd(amount), child: Text("+ $amount€")))
                                      .toList())),
                          const SizedBox(height: 24),
                          Row(children: [
                            Checkbox(
                              value: _isReceiptChecked,
                              onChanged: (checked) => setState(() {
                                _isReceiptChecked = checked ?? false;
                              }),
                            ),
                            InkWell(
                                onTap: () {
                                  setState(() {
                                    _isReceiptChecked = !_isReceiptChecked;
                                  });
                                },
                                child: const Text("Ich möchte eine Quittung erhalten."))
                          ]),
                          const SizedBox(height: 16),
                          SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                  // onPressed: _handleSubmit,
                                  onPressed: () async {
                                    int currentDonationValue = _getCurrentValue();

                                    int newDonationValue = spendenCounter + currentDonationValue;

                                    // TODO Hier muss noch eine schönere Variante eingebaut werden, die checkt, ob das Feld gefüllt ist / größer 0 ist
                                    if(_inputController.text != "" && double.parse(_inputController.text) > 0){
                                      await _updateDonationValue(newDonationValue);
                                      _inputController.text = "";
                                      _handleAdd(0);

                                      Navigator.pushNamed(context, '/Donations/UserType');
                                    }

                                  },
                                  child: Container(
                                      padding: const EdgeInsets.all(8.0),
                                      child: const Text("Spenden", style: TextStyle(fontSize: 18))))),
                          Expanded(child: Container()),
                          if (sponsor != null && sponsor.isNotEmpty) Text("Gesponsort von $sponsor"),
                          if (sponsorImgUrl != null && sponsorImgUrl.isNotEmpty)
                            Image.network(sponsorImgUrl, height: 128, width: double.infinity, fit: BoxFit.contain)
                        ],
                      )));

              //return Text('Document data: $data');
            }));
  }

  // Test Value
  String privilege = "Member";

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _inputController = TextEditingController();
  bool _isReceiptChecked = false;

  int _getCurrentValue() {
    return int.tryParse(_inputController.value.text) ?? 0;
  }

  void _handleAdd(int value) {
    _inputController.text = (_getCurrentValue() + value).toString();
    setState(() {
      _donationInput = _parseEuroStringToDouble(_inputController.text);
      print(_donationInput);
    });
  }

  void _handleSubmit() {
    int value = _getCurrentValue();
  }
}
