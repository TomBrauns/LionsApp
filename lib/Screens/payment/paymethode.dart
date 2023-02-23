import 'package:flutter/material.dart';
import 'package:lionsapp/Screens/donation_received.dart';
import 'paypalfunc.dart';
import 'stripefunc.dart';
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

final String STRIPE_PUBLISHABLE_KEY =
    "pk_test_51MdYkcIUPbRZz1M7GaXIS2CVXWQByUEtV1EuJLpUwywrj6DhLH4Q3TYW7OGbmZICAU7Qrl5LZ6ZzbILonuk6Vf2D00yjifRoo7";

class Paymethode extends StatefulWidget {
  const Paymethode({Key? key}) : super(key: key);
  final double amount = 10.00;

  @override
  State<Paymethode> createState() => _PaymethodeState();
}

class _PaymethodeState extends State<Paymethode> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Zahlungsmethode"),
      ),
      body: Center(
        child: SizedBox(
          width: 250,
          height: 500,
          child: Column(
            children: <Widget>[
              Container(
                height: 100,
                width: 350,
                padding: const EdgeInsets.all(15.0),
                margin: const EdgeInsets.all(15),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    elevation: 0,
                  ),
                  onPressed: () async {
                    paypalOnPress();
                  },
                  child: const Text("Paypal"),
                ),
              ),
              Container(
                height: 100,
                width: 350,
                padding: const EdgeInsets.all(15.0),
                margin: const EdgeInsets.all(15),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    elevation: 0,
                  ),
                  onPressed: () async {
                    stripeOnPress(widget.amount);
                  },
                  child: const Text("Kartenzahlung/Giro"),
                ),
              ),
              Container(
                  height: 50,
                  width: 350,
                  padding: const EdgeInsets.all(15.0),
                  margin: const EdgeInsets.all(15),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      elevation: 0,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/ThankYou');
                    },
                    child: const Text("Skip"),
                  ))
            ],
          ),
        ),
      ),
    );
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
