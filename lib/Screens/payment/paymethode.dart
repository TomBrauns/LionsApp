import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lionsapp/Screens/donation_received.dart';
import 'package:lionsapp/util/color.dart';

import 'paypalfuncweb.dart';
import 'paypalfunc.dart';
import 'stripefunc.dart';
import 'stripefuncweb.dart';
import 'payment_sidefunc.dart';
import 'payfunc.dart';
import 'dart:core';

import 'package:pay/pay.dart';
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

//import 'package:flutter_stripe/flutter_stripe.dart';

double amount = 50.00;
String eventId = "evenid";

bool paymentSuccess = false;
String? baseUrl = getBaseUrl();

String returnUrl = Uri.base.toString();

var _paymentItems = [
  PaymentItem(
    label: 'Spende',
    amount: amount.toString(),
    status: PaymentItemStatus.final_price,
  )
];

class Paymethode extends StatefulWidget {
  final String? token;
  final String? paymentId;
  final String? PayerID;

  const Paymethode({Key? key, this.token, this.paymentId, this.PayerID})
      : super(key: key);

  @override
  State<Paymethode> createState() => _PaymethodeState();
}

class _PaymethodeState extends State<Paymethode> {
  @override
  void initState() {
    super.initState();
    urlPaymentValidate(context);
  }

  void onApplePayResult(paymentResult) {
    // Send the resulting Apple Pay token to your server / PSP
  }

  void onGooglePayResult(paymentResult) {
    print(paymentResult.runtimeType);
    print(paymentResult);
    print(jsonDecode(
        paymentResult['paymentMethodData']['tokenizationData']['token']['id']));

    //payProcessing(tokenId, amount, eventId); //DA HIN MUSS ES
    //TODO: bekomme id zur function
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '$amount€ Spende',
              style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
            ),
            Container(
              padding: const EdgeInsets.all(20.0),
              margin: const EdgeInsets.symmetric(horizontal: 100),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: ColorUtils.primaryColor,
                    elevation: 0,
                    padding: const EdgeInsets.all(10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    )),
                onPressed: () async {
                  if (GetPlatform.currentPlatform != GetPlatform.web) {
                    paypalOnPressApp(
                        amount, eventId, context, returnUrl, baseUrl);
                  } else if (GetPlatform.currentPlatform == GetPlatform.web) {
                    paypalOnPressWeb(
                        amount, eventId, context, returnUrl, baseUrl);
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.paypal),
                    SizedBox(width: 8),
                    const Text("Paypal"),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20.0),
              margin: const EdgeInsets.symmetric(horizontal: 100),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorUtils.primaryColor,
                  padding: const EdgeInsets.all(10),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () async {
                  if (GetPlatform.currentPlatform != GetPlatform.web) {
                    paymentSuccess =
                        (await stripeOnPressApp(amount, eventId, context))!;
                    if (paymentSuccess == false) {
                      showErrorSnackbar(context);
                    } else if (paymentSuccess == true) {
                      Navigator.pop(context);
                      Navigator.pushNamed(
                          context, '/ThankYou?amount=$amount?eventId=$eventId');
                    }
                  } else if (GetPlatform.currentPlatform == GetPlatform.web) {
                    stripeOnPressWeb(
                        amount, eventId, context, returnUrl, baseUrl);
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.payment),
                    SizedBox(width: 8),
                    Text("Kartenzahlung"),
                  ],
                ),
              ),
            ),
            //TODO: make it functional
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
          ],
        ),
      ),
    );
  }

/*
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

*/
  void showErrorSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Zahlung abgebrochen'),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 4),
      ),
    );
  }

  /*
  final List<String> Paypalreturn = [
            uri.queryParameters['paymentId'] ?? '',
            uri.queryParameters['token'] ?? '',
            uri.queryParameters['PayerID'] ?? ''
  */
  void urlPaymentValidate(context) async {
    print("current URL:");
    print(Uri.base);
    final uri = Uri.base;
    final url = uri.toString();
    if (await url.contains('cancel') == true) {
      showErrorSnackbar(context);
    } else if (url.contains('cancel') == false) {
      print('default Page');
    }
  }
}

String? getBaseUrl() {
  final url = Uri.base.toString();
  final regex = RegExp(r'^.+?\/\/[^\/#]+(?:[\/#]|$)#');
  final match = regex.firstMatch(url);
  final extractedUrl = match!.group(0);
  return extractedUrl;
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
