//Licensed under the EUPL v.1.2 or later
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lionsapp/Widgets/burgermenu.dart';
import 'package:lionsapp/Widgets/bottomNavigationView.dart';
import 'package:lionsapp/Widgets/appbar.dart';
import 'package:lionsapp/Widgets/privileges.dart';
import 'package:lionsapp/Widgets/textSize.dart';
import '../Widgets/dual_progress_bar.dart';

class Donations extends StatefulWidget {
  final String? eventId;
  final String? projectId;

  const Donations({Key? key, this.eventId, this.projectId}) : super(key: key);

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
    if (Privileges.privilege == Privilege.admin ||
        Privileges.privilege == Privilege.member ||
        Privileges.privilege == Privilege.friend) {
      return BottomNavigation();
    } else {
      return null;
    }
  }

  @override
  void initState() {
    super.initState();

    //Umwandlung der aus der main.dart kommenden Document ID in eine Variable der Klasse _DonationState
    eventId = widget.eventId;
    projectId = widget.projectId;

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

  void _handleClearButton() {
    _inputController.clear();
  }

  String selectedSubscription = 'keins';

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

              String donationTitle = "Kein Event gefunden - Spenden Sie dorthin, wo es am meisten benötigt wird.";
              String? sponsor, sponsorImgUrl, donationTarget;
              double donationCounter = 0.0;

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
                      donationCounter = data["currentDonationValue"].toDouble();
                    }
                  }
                } else if (projectId != null && projectId!.isNotEmpty) {
                  if (data != null) {
                    donationTitle = data["name"] as String;
                  }
                }
              }

              //String donationTitle = snapshot.data?.get('eventName') ?? "";

              return SingleChildScrollView(
                  child: Container(
                      padding: const EdgeInsets.all(16),
                      child: ConstrainedBox(
                          constraints: BoxConstraints(
                              minHeight: MediaQuery.of(context).size.height - AppBar().preferredSize.height - 32),
                          child: Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(children: [
                                    SizedBox(
                                        width: double.infinity,
                                        child: Text(donationTitle,
                                            textAlign: TextAlign.center, style: CustomTextSize.large)),
                                    if (donationTarget != null && donationTarget.isNotEmpty)
                                      Container(
                                        padding: const EdgeInsets.symmetric(vertical: 32),
                                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                          Text(
                                              //Im Web wird mit 100cent = 1€ gerechnet, auf Mobile sind 10ct = 1€
                                              "Spendenziel: ${formatter.format((double.parse(donationCounter.toStringAsFixed(2)) * (kIsWeb ? 100 : 10)).toString())} / $donationTarget",
                                              style: CustomTextSize.large),
                                          DualLinearProgressIndicator(
                                            maxValue: _parseEuroStringToDouble(donationTarget),
                                            progressValue: donationCounter.toDouble(),
                                            addValue: _donationInput,
                                          )
                                        ]),
                                      )
                                    else
                                      const SizedBox(height: 64),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: TextFormField(
                                            controller: _inputController,
                                            onChanged: _handleInputChange,
                                            inputFormatters: [formatter],
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              hintText: "Betrag",
                                            ),
                                          ),
                                        ),
                                        Visibility(
                                          visible: _donationInput != 0.0,
                                          child: SizedBox(
                                              width: 50,
                                              child: RawMaterialButton(
                                                onPressed: () {
                                                  _inputController.clear();
                                                  setState(() {
                                                    _donationInput = 0.0;
                                                  });
                                                },
                                                elevation: 2.0,
                                                fillColor: Colors.red,
                                                shape: const CircleBorder(),
                                                child: const Icon(Icons.clear, color: Colors.white),
                                              )),
                                        ),
                                      ],
                                    ),
                                    Container(
                                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                                        child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: (MediaQuery.of(context).size.width > 400
                                                    ? [5, 10, 25, 50, 100]
                                                    : [5, 10, 25, 50])
                                                .map((int amount) => FilledButton(
                                                    onPressed: () => _handleAdd(amount),
                                                    child: Text("+ $amount€", style: CustomTextSize.small)))
                                                .toList())),
                                    if (Privileges.privilege == Privilege.friend ||
                                        Privileges.privilege == Privilege.admin &&
                                            GetPlatform.currentPlatform == GetPlatform.web)
                                      const SizedBox(height: 16),
                                    // The Subscription Button and the Drop down menu is only appearing when the User has the Role Friend
                                    // or Admin AND is logged in on a web Platform
                                    if (Privileges.privilege == Privilege.friend ||
                                        Privileges.privilege == Privilege.admin &&
                                            GetPlatform.currentPlatform == GetPlatform.web)
                                      Text(
                                        "Ein Spendenabonnement abschließen?",
                                        style: CustomTextSize.small,
                                      ),
                                    if (Privileges.privilege == Privilege.friend ||
                                        Privileges.privilege == Privilege.admin &&
                                            GetPlatform.currentPlatform == GetPlatform.web)
                                      SizedBox(height: 16),
                                    if (Privileges.privilege == Privilege.friend ||
                                        Privileges.privilege == Privilege.admin &&
                                            GetPlatform.currentPlatform == GetPlatform.web)
                                      DropdownButton<String>(
                                        value: selectedSubscription,
                                        items: <String>['keins', 'Monatlich', 'Jährlich']
                                            .map<DropdownMenuItem<String>>((String value) {
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
                                    if (Privileges.privilege == Privilege.friend ||
                                        Privileges.privilege == Privilege.admin &&
                                            GetPlatform.currentPlatform == GetPlatform.web)
                                      SizedBox(height: 16),

                                    SizedBox(
                                        width: double.infinity,
                                        child: ElevatedButton(
                                            // onPressed: _handleSubmit,
                                            onPressed: () async {
                                              double currentValue = _getCurrentValue();
                                              if (currentValue > 0.0) {
                                                _inputController.text = "";
                                                _handleAdd(0);

                                                if ((eventId == null || eventId == "") &&
                                                    (projectId == null || projectId == "")) {
                                                  projectId = '0000000000000000';
                                                }

                                                String idType =
                                                    (eventId != null && eventId!.isNotEmpty) ? "events" : "projects";

                                                // If the User is already signed in, the User_type Screen (To log in or continue as guest) is skipped as it is not necessary.
                                                if (FirebaseAuth.instance.currentUser != null) {
                                                  print("Die EventID auf dem Zahl Screen: $eventId");
                                                  Navigator.pushNamed(context, '/Donations/UserType/PayMethode',
                                                      arguments: {
                                                        'Id': idType == "events" ? eventId : projectId,
                                                        'amount': currentValue,
                                                        'sub': selectedSubscription,
                                                        //TODO: richtigen Typ übergeben
                                                        'Idtype': idType,
                                                      });
                                                } else {
                                                  Navigator.pushNamed(context, '/Donations/UserType', arguments: {
                                                    'Id': idType == "events" ? eventId : projectId,
                                                    'amount': currentValue,
                                                    'sub': selectedSubscription,
                                                    //TODO: richtigen Typ übergeben
                                                    'Idtype': idType,
                                                  });
                                                }
                                              }
                                            },
                                            style: ElevatedButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(20.0),
                                            )),
                                            child: Container(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text("Spenden", style: CustomTextSize.large)))),
                                  ]),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      if (sponsor != null && sponsor.isNotEmpty) const SizedBox(height: 64),
                                      if (sponsor != null && sponsor.isNotEmpty)
                                        Text("Gesponsort von $sponsor", style: CustomTextSize.medium),
                                      if (sponsorImgUrl != null && sponsorImgUrl.isNotEmpty)
                                        Image.network(sponsorImgUrl,
                                            height: 128, width: double.infinity, fit: BoxFit.contain)
                                    ],
                                  )
                                ],
                              )))));
            }));
  }

  // Test Value
  String privilege = "Member";

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _inputController = TextEditingController();
  bool _isReceiptChecked = false;

  double _getCurrentValue() {
    String text = _inputController.text;
    if (text.isEmpty) {
      return 0.0;
    } else {
      return _parseEuroStringToDouble(text);
    }
  }

  void _handleAdd(int value) {
    final String updatedText;
    if (!kIsWeb) {
      updatedText = formatter.format((_getCurrentValue() * 10 + value * 10).toString());
    } else {
      updatedText = formatter.format((_getCurrentValue() * 100 + value * 100).toString());
    }
    _inputController.text = updatedText;
    setState(() {
      _donationInput = _getCurrentValue();
    });
  }
}

class GetPlatform {
  static String get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'GetPlatform have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'GetPlatform have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'GetPlatform are not supported for this platform.',
        );
    }
  }

  static const String web = "web";

  static const String android = "android";

  static const String ios = "ios";

  static const String macos = "macos";
}
