import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lionsapp/Screens/user_type.dart';
import 'package:lionsapp/Widgets/burgermenu.dart';
import 'package:lionsapp/Widgets/bottomNavigationView.dart';
import 'package:lionsapp/Widgets/appbar.dart';
import 'package:lionsapp/Widgets/privileges.dart';

import '../Widgets/dual_progress_bar.dart';

class Donations extends StatefulWidget {
  final String? interneId;

  Donations({Key? key, this.interneId}) : super(key: key);

  @override
  State<Donations> createState() => _DonationsState();
}

class _DonationsState extends State<Donations> {
  var _documentStream;

  String? eventId;
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


  // and use Function for Fab in Scaffold

  @override
  void initState() {
    super.initState();

    //Umwandlung der aus der main.dart kommenden Document ID in eine Variable der Klasse _DonationState
    eventId = widget.interneId;

    print("Hier EventID: $eventId");
    print("Hier widget id: ${widget.interneId}");

    if (eventId != "") {
      _documentStream = FirebaseFirestore.instance.collection('events').doc(eventId).snapshots();
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
                  /*if(data.containsKey("spendenCounter")){
                    spendenCounter = data["spendenCounter"];
                  }*/
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
                                Text("Spendenziel: $spendenCounter / $donationTarget", style: const TextStyle(fontSize: 16)),
                                DualLinearProgressIndicator(
                                  maxValue: _parseEuroStringToDouble(donationTarget),
                                  // TODO show actual progressValue not that random value:
                                  progressValue: _parseEuroStringToDouble(donationTarget) * 0.35,
                                  addValue: _donationInput,
                                ),
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
                                  onPressed: () {
                                    spendenCounter += _getCurrentValue();
                                    print(spendenCounter);
                                    Navigator.pushNamed(context, '/Donations/UserType');
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

/*@override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        drawer: const BurgerMenu(),
        appBar: AppBar(
            title: const Text("Spenden"),
            // User Icon in AppBar
            actions: <Widget>[
              privilege == "Member" || privilege == "Friend"
                  ? IconButton(
                  icon: Icon(Icons.person),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => User()),
                    );
                  })
                  : Container(),
              // End User Icon
            ]),
        bottomNavigationBar: const BottomNavigation(),
        body: Container(
            padding: const EdgeInsets.all(16),
            child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        width: double.infinity,
                        child: Text("Erdbebenhilfe in der Türkei",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 24))),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 32),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text("Spendenziel: 10.000€"),
                            LinearProgressIndicator(
                                value: 0.42, minHeight: 24.0),
                          ]),
                    ),
                    DropdownButtonFormField(
                      value: selectedSubscription,
                      items: subscriptions
                          .map<DropdownMenuItem<String>>(((sub) =>
                          DropdownMenuItem(value: sub, child: Text(sub))))
                          .toList(),
                      onChanged: _handleSubscriptionChange,
                      decoration:
                      const InputDecoration(border: OutlineInputBorder()),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _inputController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Betrag",
                          suffix: Text("€")),
                    ),
                    Container(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [5, 10, 25, 50, 100]
                                .map((int amount) =>
                                FilledButton(
                                    onPressed: () => _handleAdd(amount),
                                    child: Text("+ $amount€")))
                                .toList())),
                    const SizedBox(height: 24),
                    Row(children: [
                      Checkbox(
                        value: _isReceiptChecked,
                        onChanged: (checked) =>
                            setState(() {
                              _isReceiptChecked = checked ?? false;
                            }),
                      ),
                      const Text("Ich möchte eine Quittung erhalten.")
                    ]),
                    const SizedBox(height: 16),
                    SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: _handleSubmit,
                            child: Container(
                                padding: const EdgeInsets.all(8.0),
                                child: const Text("Spenden",
                                    style: TextStyle(fontSize: 18))))),
                    Expanded(child: Container()),
                    const Text("Gesponsort von: Rewe"),
                    SizedBox(
                        width: double.infinity,
                        height: 128,
                        child: Container(
                          decoration: const BoxDecoration(color: Colors.grey),
                        ))
                  ],
                )
            )
        )
    );*/
