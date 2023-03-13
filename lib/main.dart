import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lionsapp/Screens/donation.dart';
import 'package:lionsapp/Screens/donation_received.dart';
import 'package:lionsapp/Screens/payment/paymethode.dart';
import 'package:lionsapp/login/agb.dart';
import 'package:lionsapp/util/color.dart';
import 'firebase_options.dart';
import 'package:lionsapp/login/login.dart';
import 'package:lionsapp/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseChatCore.instance
      .setConfig(const FirebaseChatCoreConfig(null, "rooms", "user_chat"));

  try {
    await checkRool();
  } catch (e) {}

  String myurl = Uri.base.toString();
  String? paramId = Uri.base.queryParameters['docid'];
  print(paramId);

  runApp(MyApp(documentId: paramId));
}

class MyApp extends StatefulWidget {
  String? documentId;

  MyApp({super.key, this.documentId});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final String interneId = ''; // Beispiel-Parameter

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) => MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: ColorUtils.primaryColor,
        primarySwatch: ColorUtils.primarySwatch,
      ),
      initialRoute: '/',
      // Route mit Parameter
      routes: routes,
      onGenerateRoute: (RouteSettings settings) {
        final uri = Uri.parse(settings.name!);
        // Überprüfe, ob die Route mit "/Donations" beginnt
        if (uri.path == '/Donations') {
          // Extrahiere den Parameter aus der Query-String-Variable "interneId"
          var interneId = uri.queryParameters['interneId'];
          // Erstelle die Donations-Seite mit dem Parameter
          //interneId = 'HWWbzQyOsVSbH7rS4BHR';
          return MaterialPageRoute(
              builder: (context) => Donations(interneId: interneId));
        } else if (uri.path == '/Donations/UserType/PayMethode') {
          final List<dynamic> Paymethodereturn = [
            double.tryParse(uri.queryParameters['amount'] ?? '') ?? 0.0,
            uri.queryParameters['eventId'] ?? '',
          ];
          return MaterialPageRoute(
            builder: (_) => Paymethode(
                amount: Paymethodereturn[0] as double,
                eventId: Paymethodereturn[1]),
          );
        } else if (uri.path == '/Donations/UserType/PayMethode/success') {
          final List<dynamic> Paymethodereturn = [
            double.tryParse(uri.queryParameters['amount'] ?? '') ?? 0.0,
            uri.queryParameters['eventId'] ?? '',
            uri.queryParameters['paymentId'] ?? '',
            uri.queryParameters['token'] ?? '',
            uri.queryParameters['PayerID'] ?? ''
          ];
          return MaterialPageRoute(
            builder: (_) => Paymethodesuccess(
                amount: Paymethodereturn[0], eventId: Paymethodereturn[1]),
          );
        } else if (uri.path == '/Donations/UserType/PayMethode/cancel') {
          final List<dynamic> Paymethodereturn = [
            double.tryParse(uri.queryParameters['amount'] ?? '') ?? 0.0,
            uri.queryParameters['eventId'] ?? '',
            uri.queryParameters['token'] ?? ''
          ];
          return MaterialPageRoute(
            builder: (_) => Paymethodecancel(
                amount: Paymethodereturn[0] as double,
                eventId: Paymethodereturn[1],
                token: Paymethodereturn[2]),
          );
        } else if (uri.path == '/ThankYou') {
          final List<dynamic> Paypalreturn = [
            uri.queryParameters['paymentId'] ?? '',
            uri.queryParameters['token'] ?? '',
            uri.queryParameters['PayerID'] ?? '',
            double.tryParse(uri.queryParameters['amount'] ?? '') ?? 0.0,
            uri.queryParameters['eventId'] ?? '',
          ];
          return MaterialPageRoute(
            builder: (_) => DonationReceived(
                paymentId: Paypalreturn[0],
                token: Paypalreturn[1],
                PayerID: Paypalreturn[2],
                amount: Paypalreturn[3] as double,
                eventId: Paypalreturn[4]),
          );
        } else if (uri.path == '/AGB') {
          var onRegister = uri.queryParameters['onRegister'];
          bool onRegisterbool = true;
          switch (onRegister) {
            case 'true':
              onRegisterbool = true;
              break;
            case 'false':
              onRegisterbool = false;
              break;
          }
          return MaterialPageRoute(
              builder: (_) => AGB(onRegister: onRegisterbool));
        }

        // Rückgabe einer Standardroute, falls keine passende Route gefunden wurde
        //return MaterialPageRoute(builder: (context) => HomePage());
        return MaterialPageRoute(builder: (context) => Container());
      },
    );
  }
}
