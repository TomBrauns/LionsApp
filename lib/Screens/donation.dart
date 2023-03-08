import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lionsapp/Widgets/burgermenu.dart';
import 'package:lionsapp/Widgets/bottomNavigationView.dart';
import 'package:lionsapp/Widgets/appbar.dart';
import 'package:lionsapp/Widgets/privileges.dart';
import 'package:lionsapp/Widgets/textSize.dart';
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

  final formatter = CurrencyTextInputFormatter(locale: 'eu', symbol: '€');

  String? eventId;
  String? projectId;
  double _donationInput = 0.0;

  // BAB with Priviledge
  //Copy that
  Widget? _getBAB() {
    if (Privileges.privilege == "Admin" ||
        Privileges.privilege == "Member" ||
        Privileges.privilege == "Friend") {
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


    if (eventId != null && eventId!.isNotEmpty) {
      _documentStream = FirebaseFirestore.instance
          .collection('events')
          .doc(eventId)
          .snapshots();
    } else if (projectId != null && projectId!.isNotEmpty) {
      _documentStream = FirebaseFirestore.instance
          .collection("projects")
          .doc(projectId)
          .snapshots();
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

              String donationTitle =
                  "Kein Event gefunden - Spenden Sie dorthin, wo es am meisten benötigt wird.";
              String? sponsor, sponsorImgUrl, donationTarget;
              double donationCounter = 0.0;

              if (snapshot.hasData && snapshot.data!.exists) {
                Map<String, dynamic>? data =
                    snapshot.data!.data() as Map<String, dynamic>?;
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
                      donationCounter = data["currentDonationValue"];
                    }
                  }
                } else if (projectId != null && projectId!.isNotEmpty) {
                  if (data != null) {
                    donationTitle = data["name"] as String;
                  }
                }
              }

              Future<void> _updateDonationValue(double newDonationValue) async {
                try {
                  final documentReference = FirebaseFirestore.instance
                      .collection('events')
                      .doc(eventId);

                  await documentReference
                      .update({'currentDonationValue': newDonationValue});
                } catch (e) {
                  return null;
                }
              }
              //String donationTitle = snapshot.data?.get('eventName') ?? "";

              return SingleChildScrollView(
                  child: Container(
                      padding: const EdgeInsets.all(16),
                      child: ConstrainedBox(
                          constraints: BoxConstraints(
                              minHeight: MediaQuery.of(context).size.height -
                                  AppBar().preferredSize.height -
                                  32),
                          child: Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(children: [
                                    SizedBox(
                                        width: double.infinity,
                                        child: Text(donationTitle,
                                            textAlign: TextAlign.center,
                                            style: CustomTextSize.large)),
                                    if (donationTarget != null && donationTarget.isNotEmpty)
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 32),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  "Spendenziel: ${formatter.format((double.parse(donationCounter.toStringAsFixed(2)) * 100).toString())} / $donationTarget",
                                                  style: CustomTextSize.large),
                                              DualLinearProgressIndicator(
                                                maxValue:
                                                    _parseEuroStringToDouble(
                                                        donationTarget),
                                                progressValue:
                                                    donationCounter.toDouble(),
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
                                      inputFormatters: [formatter],
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          hintText: "Betrag"),
                                    ),
                                    Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8.0),
                                        child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: (MediaQuery.of(context).size.width > 400
                                                    ? [5, 10, 25, 50, 100]
                                                    : [5, 10, 25, 50])
                                                .map((int amount) => FilledButton(
                                                    onPressed: () => _handleAdd(amount),
                                                    child: Text("+ $amount€", style: CustomTextSize.small)))
                                                .toList())),
                                    const SizedBox(height: 16),
                                    SizedBox(
                                        width: double.infinity,
                                        child: ElevatedButton(
                                            // onPressed: _handleSubmit,
                                            onPressed: () async {
                                              double currentValue =
                                                  _getCurrentValue();
                                              double newDonationValue =
                                                  donationCounter +
                                                      currentValue;
                                              if (currentValue > 0.0) {
                                                await _updateDonationValue(
                                                    newDonationValue); // TODO move this to the end of donation process
                                                _inputController.text = "";
                                                _handleAdd(0);
                                                eventId ??=
                                                    'mwYLrlsbZC5kZNPSEkJB';

                                                // If the User is already signed in, the User_type Screen (To log in or continue as guest) is skipped as it is not necessary.
                                                if (FirebaseAuth
                                                        .instance.currentUser !=
                                                    null) {
                                                  Navigator.pushNamed(context,
                                                      '/Donations/UserType/PayMethode',
                                                      arguments: {
                                                        'eventId': eventId
                                                      });
                                                } else {
                                                  Navigator.pushNamed(context,
                                                      '/Donations/UserType',
                                                      arguments: {
                                                        'eventId': eventId
                                                      });
                                                }
                                              }
                                            },
                                            child: Container(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text("Spenden",
                                                    style: CustomTextSize
                                                        .large)))),
                                  ]),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      if (sponsor != null && sponsor.isNotEmpty)
                                        const SizedBox(height: 64),
                                      if (sponsor != null && sponsor.isNotEmpty)
                                        Text("Gesponsort von $sponsor",
                                            style: CustomTextSize.medium),
                                      if (sponsorImgUrl != null &&
                                          sponsorImgUrl.isNotEmpty)
                                        Image.network(sponsorImgUrl,
                                            height: 128,
                                            width: double.infinity,
                                            fit: BoxFit.contain)
                                    ],
                                  )
                                ],
                              )
                          )
                      )
                  )
              );
            })
    );
  }

  // Test Value
  String privilege = "Member";

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _inputController = TextEditingController();
  bool _isReceiptChecked = false;

  double _getCurrentValue() {
    return _parseEuroStringToDouble(_inputController.text);
  }

  void _handleAdd(int value) {
    final String updatedText =
        formatter.format((_getCurrentValue() * 10 + value * 10).toString());
    _inputController.text = updatedText;
    setState(() {
      _donationInput = _parseEuroStringToDouble(updatedText);
    });
  }
}
