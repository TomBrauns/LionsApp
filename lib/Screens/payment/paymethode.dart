import 'package:flutter/material.dart';
import 'package:lionsapp/Screens/donation_received.dart';

import 'paypalfunc.dart';
import 'stripefunc.dart';
import 'stripefuncweb.dart';
import 'payment_sidefunc.dart';
import 'dart:core';

import 'package:pay/pay.dart';
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

//import 'package:flutter_stripe/flutter_stripe.dart';

double amount = 10.00;
String eventId = "evenid test";

bool paymentSuccess = false;

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
  @override
  void initState() {
    super.initState();
    urlPaymentVerify(context);
  }

  void onGooglePayResult(paymentResult) {
    print(paymentResult);
    // Send the resulting Google Pay token to your server / PSP
  }

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
                    paypalOnPress(amount, eventId, Uri.base.toString());
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
                      paymentSuccess =
                          (await stripeOnPressApp(amount, eventId, context))!;
                      if (paymentSuccess == false) {
                        showErrorSnackbar(context);
                      } else if (paymentSuccess == true) {
                        showSuccessSnackbar(context);
                      }
                    } else if (GetPlatform.currentPlatform == GetPlatform.web) {
                      stripeOnPressWeb(
                          amount, eventId, context, Uri.base.toString());
                    }
                  },
                  child: const Text("Stripe"),
                ),
              ),
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
            ],
          ),
        ),
      ),
    );
  }

  void showErrorSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Zahlung abgebrochen'),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 4),
      ),
    );
  }

  void showSuccessSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Zahlung erfolgreich'),
        backgroundColor: Colors.green,
        action: SnackBarAction(
          label: 'weiter',
          onPressed: () {
            Navigator.pushNamed(context, '/ThankYou');
          },
        ),
      ),
    );
  }

  void urlPaymentVerify(context) {
    final uri = Uri.base;
    final url = uri.toString();
    final regex = RegExp('(success|cancel)\$');
    final match = regex.firstMatch(url);

    if (match != null) {
      final result = match.group(0);
      if (result == 'success') {
        print(true); // Output: true
        showSuccessSnackbar(context);
      } else if (result == 'cancel') {
        print(false); // Output: false
        showErrorSnackbar(context);
      }
    } else {
      print('No match found.');
    }
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
