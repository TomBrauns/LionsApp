import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lionsapp/util/color.dart';
import 'package:path_provider/path_provider.dart';
import '../../Widgets/appbar.dart';
import 'package:lionsapp/Widgets/burgermenu.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_social_button/flutter_social_button.dart';
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:open_filex/open_filex.dart';
import 'dart:io';
import 'package:universal_html/html.dart' as html;

// Test Values
// ignore: non_constant_identifier_names
String DonationProjectName = "Test Projekt";
// ignore: non_constant_identifier_names
var DonationAmount = 1;

class DonationReceived extends StatelessWidget {
  final String? token;
  final String? paymentId;
  final String? PayerID;
  final String amount;
  final String eventId;

  DonationReceived(
      {super.key,
      this.token,
      this.paymentId,
      this.PayerID,
      required this.amount,
      required this.eventId});

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
                color: const Color.fromARGB(156, 141, 196, 241),
                border: Border.all(
                  color: ColorUtils.primaryColor,
                )),
            child: Text("Danke für ihre Spende von $amount€ an $eventId ."
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
                backgroundColor: ColorUtils.primaryColor,
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
                backgroundColor: ColorUtils.primaryColor,
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
                backgroundColor: ColorUtils.primaryColor,
                elevation: 0,
              ),
              onPressed: () {
                print("Rufe Share Button mit eventId auf: $eventId");
                Navigator.pushNamed(context, '/ThankYou/ShareDonation',
                arguments: {'eventId': eventId});
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
  List<int>? _bytes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Spendenquittung"),
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
              label: const Text('Cloud hochladen'),
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
            child: const Text(
                "Angemeldete Nutzer erhalten automatisch Quittungen per Mail"),
          ),
        ])));
  }

  Future<List<int>> _createPDF() async {
    PdfDocument document = PdfDocument();
    final page = document.pages.add();

    page.graphics.drawImage(
        PdfBitmap(await _readImageData()),
        Rect.fromLTWH(
            0, 0, page.getClientSize().width, page.getClientSize().height));
    page.graphics
        .drawString("Test", PdfStandardFont(PdfFontFamily.helvetica, 10));

    List<int> bytes = await document.save();
    document.dispose();

    return bytes;
  }

  Future<Uint8List> _readImageData() async {
    final data = await rootBundle.load(
        '/Users/marcwieland/Uni/TOP/lionsapp/assets/images/spendenquittung.jpg');
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

    html.AnchorElement(
        href:
            "data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}")
      ..setAttribute("download", "spendenquittung.pdf")
      ..click();
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
          title: const Text("Spendenquittung"),
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
                          backgroundColor: ColorUtils.primaryColor,
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


  const ShareDonation({Key? key}) : super(key: key);

  @override
  State<ShareDonation> createState() => _ShareDonationState();
}

Future<void> shareToFacebook(String url) async {
  if (GetPlatform.currentPlatform == GetPlatform.web) {
    if (await canLaunchUrl(
        Uri.parse("https://www.facebook.com/sharer/sharer.php?u=$url"))) {
      await launchUrl(
          Uri.parse("https://www.facebook.com/sharer/sharer.php?u=$url"));
    } else {
      //print("Could not launch URL");
    }
  } else {
    if (await canLaunchUrl(
        Uri.parse("https://www.facebook.com/sharer/sharer.php?u=$url"))) {
      await launchUrl(
          Uri.parse("https://www.facebook.com/sharer/sharer.php?u=$url"));
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
    if (await canLaunchUrl(
        Uri.parse("https://twitter.com/intent/tweet?url=$url"))) {
      await launchUrl(Uri.parse("https://twitter.com/intent/tweet?url=$url"));
    } else {
      //print("Could not launch URL");
    }
  }
}

class _ShareDonationState extends State<ShareDonation> {

  String? get eventId{
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
                    await shareToFacebook(
                        'https://marc-wieland.de/#/Donations?interneId=$eventId');
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
                    await shareToTwitter(
                        'https://marc-wieland.de/#/Donations?interneId=$eventId');
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
