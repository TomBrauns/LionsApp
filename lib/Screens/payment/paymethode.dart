import 'package:flutter/material.dart';

import 'package:lionsapp/Screens/donation_received.dart';
import 'paypalfunc.dart';
import 'stripefunc.dart';
import 'stripefuncweb.dart';
import 'payment_sidefunc.dart';

import 'package:pay/pay.dart';
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

//import 'package:flutter_stripe/flutter_stripe.dart';

double amount = 10.00;
String eventId = "evenid test";

var _paymentItems = [
  PaymentItem(
    label: 'Spende',
    amount: amount.toString(),
    status: PaymentItemStatus.final_price,
  )
];

class Paymethode extends StatefulWidget {
  const Paymethode({Key? key}) : super(key: key);

  @override
  State<Paymethode> createState() => _PaymethodeState();
}

class _PaymethodeState extends State<Paymethode> {
  void onApplePayResult(paymentResult) {
    // Send the resulting Apple Pay token to your server / PSP
  }

  void onGooglePayResult(paymentResult) {
    // Send the resulting Google Pay token to your server / PSP
  }

  final Future<PaymentConfiguration> _applePayConfigFuture =
      PaymentConfiguration.fromAsset('default_payment_profile_apple_pay.json');
  final Future<PaymentConfiguration> _googlePayConfigFuture =
      PaymentConfiguration.fromAsset('default_payment_profile_google_pay.json');

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
                    paypalOnPress(amount);
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
                    if (GetPlatform.currentPlatform != GetPlatform.web) {
                      stripeOnPressApp(amount, eventId, context);
                    } else if (GetPlatform.currentPlatform == GetPlatform.web) {
                      stripeOnPressWeb(amount, eventId, context);
                      //retrieved Payment Object
                      print(await retrieveCheckoutId());
                    }
                  },
                  child: const Text("Stripe"),
                ),
              ),
              if (GetPlatform.currentPlatform != GetPlatform.web)
                FutureBuilder<PaymentConfiguration>(
                    future: _applePayConfigFuture,
                    builder: (context, snapshot) => snapshot.hasData
                        ? ApplePayButton(
                            paymentConfiguration: snapshot.data!,
                            paymentItems: _paymentItems,
                            type: ApplePayButtonType.donate,
                            margin: const EdgeInsets.only(top: 15.0),
                            onPaymentResult: onApplePayResult,
                            loadingIndicator: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : const SizedBox.shrink()),
              if (GetPlatform.currentPlatform != GetPlatform.web)
                FutureBuilder<PaymentConfiguration>(
                    future: _googlePayConfigFuture,
                    builder: (context, snapshot) => snapshot.hasData
                        ? GooglePayButton(
                            paymentConfiguration: snapshot.data!,
                            paymentItems: _paymentItems,
                            type: GooglePayButtonType.donate,
                            margin: const EdgeInsets.only(top: 15.0),
                            onPaymentResult: onGooglePayResult,
                            loadingIndicator: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : const SizedBox.shrink()),
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
                  )),
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
