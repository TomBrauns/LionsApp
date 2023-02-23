import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lionsapp/Screens/user_type.dart';
import 'package:lionsapp/Widgets/burgermenu.dart';
import 'package:lionsapp/Widgets/bottomNavigationView.dart';
import 'package:lionsapp/Widgets/appbar.dart';

class Donations extends StatefulWidget {
  final String? interneId;

  Donations({Key? key, this.interneId}) : super(key: key);

  @override
  State<Donations> createState() => _DonationsState();
}

class _DonationsState extends State<Donations> {
  var _documentStream;

  String? interneId;

  @override
  void initState() {
    super.initState();

    //Umwandlung der aus der main.dart kommenden Document ID in eine Variable der Klasse _DonationState
    interneId = widget.interneId;

    if (widget.interneId != null) {
      _documentStream = FirebaseFirestore.instance
          .collection('events')
          .doc(widget.interneId)
          .snapshots();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        drawer: const BurgerMenu(),
        appBar: const MyAppBar(title: "Spenden"),
        bottomNavigationBar: const BottomNavigation(
          currentPage: "Donations",
          privilege: "Admin",
        ),
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

              String donationTitle = snapshot.data?.get('eventName') ?? "";

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
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontSize: 24))),
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
                          const SizedBox(height: 8),
                          TextFormField(
                            controller: _inputController,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "Betrag",
                                suffix: Text("€")),
                          ),
                          Container(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [5, 10, 25, 50, 100]
                                      .map((int amount) => FilledButton(
                                          onPressed: () => _handleAdd(amount),
                                          child: Text("+ $amount€")))
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
                                child: const Text(
                                    "Ich möchte eine Quittung erhalten."))
                          ]),
                          const SizedBox(height: 16),
                          SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                  // onPressed: _handleSubmit,
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/Donations/UserType');
                                  },
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
                                decoration:
                                    const BoxDecoration(color: Colors.grey),
                              ))
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
