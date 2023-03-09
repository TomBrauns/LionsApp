import 'dart:convert';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lionsapp/util/color.dart';
import 'package:path_provider/path_provider.dart';
import '../../Widgets/appbar.dart';
import 'package:lionsapp/Widgets/burgermenu.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_social_button/flutter_social_button.dart';
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:open_filex/open_filex.dart';
import 'dart:io';
import 'package:universal_html/html.dart' as html;

import '../Widgets/textSize.dart';

class DonationReceived extends StatelessWidget {
  final String? token;
  final String? paymentId;
  final String? PayerID;
  final double amount;
  final String eventId;

  DonationReceived({super.key, this.token, this.paymentId, this.PayerID, required this.amount, required this.eventId});

  Future<void> sendMailWithReceipt(String eventName) async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final docSnapshot = await FirebaseFirestore.instance.collection('users').doc(userId).get();
    final userData = docSnapshot.data() as Map<String, dynamic>;
    String firstName = userData['firstname'] as String;
    String lastName = userData['lastname'] as String;
    String eMail = userData['email'] as String;

    var pdf = await _ReceiptState()._handlePdfUpload();

    var data = {
      'mailOptions': {
        'from': 'Team Lions',
        'to': eMail,
        'subject': 'Danke für Ihre Spende! Ihre Spendenquittung',
        'text': 'Hallo $firstName $lastName \nWir bedanken uns recht herzlich für Ihre Spende an $eventName in Höhe von $amount!.\n'
            'Damit tust etwas gutes usw.\n'
            'Im Anhang finden Sie Ihre Spendenquittung!\n'
            'Mit freundlichen Grüßen\n'
            'Deine Lions Team\n',
        'attachments': [
          //TODO: Pfad der späteren Quittung und Text bisschen anpassen
          {'filename': 'Spenden_Quittung.pdf', 'path': pdf},
        ],
      }
    };

    final HttpsCallable callable = FirebaseFunctions.instance.httpsCallable('sendEmailWithAttachments');
    try {
      await callable(data);
      print('Email sent successfully');
    } catch (e) {
      print('Error sending email: $e');
    }
  }

  Future<void> _updateEventDonation(String eventId) async {
      final documentRef = FirebaseFirestore.instance.collection('events').doc(eventId);
      final event = await documentRef.get();
      final double currentValue = event.get("currentDonationValue");
      return await documentRef.update({'currentDonationValue': currentValue + amount});
  }

  Future<void> _updateDonationHistory(String eventId, String eventName) async {
    final User? currentUser = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance.collection("donations").add({
      "user": currentUser != null ? currentUser.uid : "guest",
      "amount": amount,
      "event_name": eventName,
      "event_id": eventId,
      "date": DateTime.now(),
    });
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const MyAppBar(title: "Danke für ihre Spende"),
        drawer: const BurgerMenu(),
        body: FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance.collection('events').doc(eventId).get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            /*if (!snapshot.hasData || !snapshot.data!.exists) {
              return const Center(child: Text('Event nicht gefunden'));
            }*/

            final eventName;

            if (eventId == '0000000000000000') {
              print(amount.runtimeType);
              eventName = 'Wichtigstes Event';
            } else {
              eventName = snapshot.data!.get('eventName');
            }

            final message = "Danke für Ihre Spende von $amount€ an $eventName. Wenn Sie uns noch etwas mitteilen möchten, zögern Sie nicht, uns über das Kontaktformular zu benachrichtigen.";

            if (FirebaseAuth.instance.currentUser != null) {
              sendMailWithReceipt(eventName);
            }

            _updateEventDonation(eventId);
            _updateDonationHistory(eventId, eventName);

            return Column(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.all(40),
                  padding: const EdgeInsets.all(40.0),
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(156, 141, 196, 241),
                      border: Border.all(
                        color: ColorUtils.primaryColor,
                      ),
                      borderRadius: BorderRadius.circular(20)),
                  child: Text(message, style: CustomTextSize.small),
                ),
                if (amount >= 300)
                  Column(children: <Widget>[
                    Container(
                      margin: const EdgeInsets.all(40),
                      padding: const EdgeInsets.all(40.0),
                      decoration: BoxDecoration(
                          color: Colors.amber,
                          border: Border.all(
                            color: Colors.amber,
                          ),
                          borderRadius: BorderRadius.circular(20)),
                      child: Text('Sie haben mehr als 299.99€ gespendet, Sie sind legitimiert für eine Bestätigung einer Sachzuwendung an den Lions Club Kaiserslautern', style: CustomTextSize.small),
                    ),
                    Container(
                      padding: const EdgeInsets.all(20.0),
                      width: 400,
                      child: ElevatedButton(
                        child: Text('zur Zuwendungsbestätigung', style: CustomTextSize.medium),
                        onPressed: () {
                          // Update State of App
                          Navigator.pop(context);
                          // Push to Screen
                          Navigator.pushNamed(context, '/ThankYou/Receipt');
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.amber,
                            elevation: 0,
                            padding: const EdgeInsets.all(10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            )),
                      ),
                    ),
                  ]),
                Container(
                  padding: const EdgeInsets.all(20.0),
                  width: 400,
                  child: ElevatedButton.icon(
                    icon: const Icon(
                      Icons.contact_support,
                      size: 24.0,
                    ),
                    label: Text('Kontaktformular', style: CustomTextSize.medium),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: ColorUtils.primaryColor,
                        elevation: 0,
                        padding: const EdgeInsets.all(10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        )),
                    onPressed: () {
                      Navigator.pushNamed(context, '/Contact');
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20.0),
                  width: 400,
                  child: ElevatedButton.icon(
                    icon: const Icon(
                      Icons.receipt,
                      size: 24.0,
                    ),
                    label: Text('Quittung', style: CustomTextSize.medium),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: ColorUtils.primaryColor,
                        elevation: 0,
                        padding: const EdgeInsets.all(10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        )),
                    onPressed: () {
                      Navigator.pushNamed(context, '/ThankYou/Receipt');
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20.0),
                  width: 400,
                  child: ElevatedButton.icon(
                    icon: const Icon(
                      Icons.share,
                      size: 24.0,
                    ),
                    label: Text('Teilen', style: CustomTextSize.medium),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: ColorUtils.primaryColor,
                        elevation: 0,
                        padding: const EdgeInsets.all(10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        )),
                    onPressed: () {
                      print("Rufe Share Button mit eventId auf: $eventId");
                      Navigator.pushNamed(context, '/ThankYou/ShareDonation', arguments: {'eventId': eventId});
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20.0),
                  width: 400,
                  child: ElevatedButton(
                    child: Text('Zurück zum Spenden', style: CustomTextSize.medium),
                    onPressed: () {
                      // Push to Screen
                      Navigator.pushNamed(context, '/Donations');
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: ColorUtils.primaryColor,
                        elevation: 0,
                        padding: const EdgeInsets.all(10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        )),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20.0),
                  width: 400,
                  child: ElevatedButton(
                    child: Text('Weitere Events', style: CustomTextSize.medium),
                    onPressed: () {
                      // Update State of App
                      Navigator.pop(context);
                      // Push to Screen
                      Navigator.pushNamed(context, '/Events');
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: ColorUtils.primaryColor,
                        elevation: 0,
                        padding: const EdgeInsets.all(10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        )),
                  ),
                ),
              ],
            );
          },
        ));
  }
}

class Receipt extends StatefulWidget {
  const Receipt({super.key});

  @override
  State<Receipt> createState() => _ReceiptState();
}

class _ReceiptState extends State<Receipt> {
  List<int>? _bytes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Spendenquittung", style: CustomTextSize.large),
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
              label: Text('PDF herunterladen', style: CustomTextSize.large),
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorUtils.primaryColor,
                elevation: 0,
              ),
              onPressed: () async {
                if (kIsWeb) {
                  _handleWebDownloadButtonPressed();
                } else {
                  _handleDownloadButtonPressed();
                }
              },
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
              label: Text('Cloud hochladen', style: CustomTextSize.large),
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorUtils.primaryColor,
                elevation: 0,
              ),
              onPressed: () async {
                print("Button gedrückt");
                if (kIsWeb) {
                  _handleWebDownloadButtonPressed();
                  print("Web erkannt");
                } else {
                  _handleDownloadButtonPressed();
                }
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.all(40),
            height: 50,
            child: Text("Als angemeldeter Nutzer erhalten Sie automatisch eine Quittung per Mail", style: CustomTextSize.small),
          ),
        ])));
  }

  Future<List<int>> _createPDF() async {
    PdfDocument document = PdfDocument();
    final page = document.pages.add();

    page.graphics.drawImage(PdfBitmap(await _readImageData()), Rect.fromLTWH(0, 0, page.getClientSize().width, page.getClientSize().height));
    page.graphics.drawString("Test", PdfStandardFont(PdfFontFamily.helvetica, 10));

    List<int> bytes = await document.save();
    document.dispose();

    return bytes;
  }

  Future<String?> _handlePdfUpload() async {
    if (kIsWeb) {
      final uniqueId = UniqueKey().toString();
      final reference = FirebaseStorage.instance.ref('donator_receipts').child(FirebaseAuth.instance.currentUser!.uid).child(uniqueId);
      //Web

      final bytes = await _createPDF();

      Uint8List newFile = Uint8List.fromList(bytes);

      await reference.putData(newFile);

      return reference.getDownloadURL();
    }

    return null;
  }

  Future<Uint8List> _readImageData() async {
    final data = await rootBundle.load('assets/images/spendenquittung.jpg');
    return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  }

  //Download in App
  void _handleDownloadButtonPressed() async {
    List<int> pdfBytes = await _createPDF();

    Directory tempDir = await getTemporaryDirectory();
    File tempFile = File('${tempDir.path}/spendenquittung.pdf');
    await tempFile.writeAsBytes(pdfBytes);

    await OpenFilex.open(tempFile.path);
  }

  //Download im Web
  void _handleWebDownloadButtonPressed() async {
    List<int> bytes = await _createPDF();

    html.AnchorElement(href: "data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}")
      ..setAttribute("download", "spendenquittung.pdf")
      ..click();
  }
}

class ShareDonation extends StatefulWidget {
  const ShareDonation({Key? key}) : super(key: key);

  @override
  State<ShareDonation> createState() => _ShareDonationState();
}

Future<void> shareToFacebook(String url) async {
  if (GetPlatform.currentPlatform == GetPlatform.web) {
    if (await canLaunchUrl(Uri.parse("https://www.facebook.com/sharer/sharer.php?u=$url"))) {
      await launchUrl(Uri.parse("https://www.facebook.com/sharer/sharer.php?u=$url"));
    } else {
      //print("Could not launch URL");
    }
  } else {
    if (await canLaunchUrl(Uri.parse("https://www.facebook.com/sharer/sharer.php?u=$url"))) {
      await launchUrl(Uri.parse("https://www.facebook.com/sharer/sharer.php?u=$url"));
    } else {
      //print("Could not launch URL");
    }
  }
}

Future<void> shareToTwitter(String url) async {
  if (GetPlatform.currentPlatform == GetPlatform.web) {
    if (await canLaunchUrl(Uri.parse(
      "https://twitter.com/intent/tweet?url=$url",
    ))) {
      await launchUrl(Uri.parse("https://twitter.com/intent/tweet?url=$url"));
    } else {
      //print("Could not launch URL");
    }
  } else {
    if (await canLaunchUrl(Uri.parse("https://twitter.com/intent/tweet?url=$url"))) {
      await launchUrl(Uri.parse("https://twitter.com/intent/tweet?url=$url"));
    } else {
      //print("Could not launch URL");
    }
  }
}

class _ShareDonationState extends State<ShareDonation> {
  String? get eventId {
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    return args?['eventId'];
  }

  @override
  Widget build(BuildContext context) {
    print(eventId);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Teile deine Spende"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //For facebook Button
              FlutterSocialButton(
                onTap: () async {
                  try {
                    await shareToFacebook('https://marc-wieland.de/#/Donations?interneId=$eventId');
                  } catch (e) {
                    //print("Failed to share to Facebook: $e");
                  }
                },
                title: "Auf Facebook teilen",
                mini: false,
                buttonType: ButtonType.facebook,
              ),
              const SizedBox(
                height: 2,
              ),

              //For twitter Button
              FlutterSocialButton(
                onTap: () async {
                  try {
                    await shareToTwitter('https://marc-wieland.de/#/Donations?interneId=$eventId');
                  } catch (e) {
                    //print("Failed to share to Twitter: $e");
                  }
                },
                title: "Auf Twitter teilen",
                mini: false,
                buttonType: ButtonType.twitter,
              ),
              const SizedBox(
                height: 2,
              ),
            ],
          ),
        ),
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
          title: const Text("Spendenquittung"),
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
                      decoration: const InputDecoration(
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
                      decoration: const InputDecoration(
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
                      decoration: const InputDecoration(
                        labelText: 'Straße u. Hausnummer',
                      ),
                      obscureText: false,
                      onSubmitted: (value) {},
                    ),
                    Container(
                      margin: const EdgeInsets.all(15),
                    ),
                    Row(children: <Widget>[
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
                    ]),
                    Container(
                      margin: const EdgeInsets.all(25),
                      child: ElevatedButton(
                        child: const Text("Weiter"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorUtils.primaryColor,
                          elevation: 0,
                        ),
                        onPressed: () {
                          //
                          // Submit missing
                          //
                          Navigator.pushNamed(context, '/ThankYou');
                        },
                      ),
                    ),
                  ],
                ))));
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
