import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lionsapp/Screens/donation_received.dart';
import 'package:lionsapp/Screens/payment/subpayment.dart';
import 'package:lionsapp/util/color.dart';

import '../../Widgets/textSize.dart';
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

String Endpoint =
    "https://europe-west3-serviceclub-app.cloudfunctions.net/flask-backend";
//String Endpoint = "http://127.0.0.1:5000";

String customerId = 'cus_NQuDfnRv0Gky79';

bool paymentSuccess = false;
String? baseUrl = getBaseUrl();

String returnUrl = Uri.base.toString();

class Paymethode extends StatefulWidget {
  final String? token;
  final String? paymentId;
  final String? PayerID;
  final double amount;
  final String Id;
  final String Idtype;
  final String sub;

  const Paymethode(
      {Key? key,
      this.token,
      this.paymentId,
      this.PayerID,
      required this.amount,
      required this.Id,
      required this.Idtype,
      required this.sub})
      : super(key: key);

  @override
  State<Paymethode> createState() => _PaymethodeState();
}

class _PaymethodeState extends State<Paymethode> {
  String? get Id {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    return args?['Id'];
  }

  double get amount {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    return args?['amount'];
  }

  String get sub {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    return args?['sub'];
  }

  String get Idtype {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    return args?['Idtype'];
  }

  @override
  void initState() {
    super.initState();
  }

  void onApplePayResult(paymentResult) {
    // Send the resulting Apple Pay token to your server / PSP
  }

  void onGooglePayResult(paymentResult) async {
    String tokenString =
        paymentResult['paymentMethodData']['tokenizationData']['token'];
    Map<String, dynamic> tokenData = json.decode(tokenString);
    String tokenId = tokenData['id'];
    print(tokenId);
    Map<String, dynamic>? result =
        await payProcessing(tokenId, amount, Id, Endpoint);
    if (result!['outcome']['seller_message'] == "Payment complete.") {
      Navigator.pop(context);

      Navigator.pushNamed(context,
          '/Donations/UserType/PayMethode/success?amount=$amount&Id=$Id&sub=$sub&Idtype=$Idtype');
    } else {
      showErrorSnackbar(context);
    }
  }

  final Future<PaymentConfiguration> _applePayConfigFuture =
      PaymentConfiguration.fromAsset('default_payment_profile_apple_pay.json');

  final Future<PaymentConfiguration> _googlePayConfigFuture =
      PaymentConfiguration.fromAsset('default_payment_profile_google_pay.json');

  @override
  Widget build(BuildContext context) {
    final paymentItems = [
      PaymentItem(
        label: 'Spende',
        amount: amount.toString(),
        status: PaymentItemStatus.final_price,
      )
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text("Zahlungsmethode"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: sub == 'keins'
              ? <Widget>[
                  Text('$amount€ Spende', style: CustomTextSize.large),
                  SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(20.0),
                    margin: const EdgeInsets.symmetric(horizontal: 90),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 255, 196, 57),
                          elevation: 0,
                          padding: const EdgeInsets.all(10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          )),
                      onPressed: () async {
                        if (GetPlatform.currentPlatform != GetPlatform.web) {
                          paypalOnPressApp(
                              amount, Id, context, Endpoint, sub, Idtype);
                        } else if (GetPlatform.currentPlatform ==
                            GetPlatform.web) {
                          paypalOnPressWeb(amount, Id, context, baseUrl,
                              Endpoint, sub, Idtype);
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.paypal,
                            color: Colors.blue,
                          ),
                          SizedBox(width: 8),
                          Text(
                            "Paypal",
                            style: CustomTextSize.large,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(20.0),
                    margin: const EdgeInsets.symmetric(horizontal: 90),
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
                          paymentSuccess = (await stripeOnPressApp(
                              amount, Id, context, Endpoint))!;
                          if (paymentSuccess == false) {
                            showErrorSnackbar(context);
                          } else if (paymentSuccess == true) {
                            print(Id);
                            Navigator.pop(context);
                            Navigator.pushNamed(context,
                                '/Donations/UserType/PayMethode/success?amount=$amount&Id=$Id&sub=$sub&Idtype=$Idtype');
                          }
                        } else if (GetPlatform.currentPlatform ==
                            GetPlatform.web) {
                          stripeOnPressWeb(amount, Id, context, baseUrl,
                              Endpoint, sub, Idtype);
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.payment),
                          SizedBox(width: 8),
                          Text("Karte", style: CustomTextSize.large),
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
                                paymentItems: paymentItems,
                                type: ApplePayButtonType.donate,
                                margin: const EdgeInsets.only(top: 15.0),
                                onPaymentResult: onApplePayResult,
                                loadingIndicator: const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              )
                            : const SizedBox.shrink()),

                  if (GetPlatform.currentPlatform != GetPlatform.web)
                    Container(
                        padding: const EdgeInsets.all(20.0),
                        margin: const EdgeInsets.symmetric(horizontal: 90),
                        height: 100,
                        width: 500,
                        child: FutureBuilder<PaymentConfiguration>(
                            future: _googlePayConfigFuture,
                            builder: (context, snapshot) => snapshot.hasData
                                ? GooglePayButton(
                                    paymentConfiguration: snapshot.data!,
                                    paymentItems: paymentItems,
                                    type: GooglePayButtonType.donate,
                                    onPaymentResult: onGooglePayResult,
                                    loadingIndicator: const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  )
                                : const SizedBox.shrink())),
                ]
              : <Widget>[
                  Text('$amount€ Spende $sub', style: CustomTextSize.large),
                  Container(
                    padding: const EdgeInsets.all(20.0),
                    margin: const EdgeInsets.symmetric(horizontal: 90),
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
                        stripeSubOnPress(amount, Id, context, baseUrl, Endpoint,
                            sub, customerId, Idtype);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.payment),
                          SizedBox(width: 8),
                          Text("Karte", style: CustomTextSize.large),
                        ],
                      ),
                    ),
                  ),
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
}

class Paymethodecancel extends StatelessWidget {
  final String? token;
  final String? paymentId;
  final String? PayerID;
  final double amount;
  final String Id;
  final String Idtype;
  final String sub;

  const Paymethodecancel(
      {Key? key,
      this.token,
      this.paymentId,
      this.PayerID,
      required this.amount,
      required this.Id,
      required this.Idtype,
      required this.sub})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Zahlung abgebrochen'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 4),
        ),
      );

      Navigator.pushNamed(
        context,
        '/Donations/UserType/PayMethode',
        arguments: {'Id': Id, 'amount': amount, 'sub': sub, 'Idtype': Idtype},
      );
    });

    return Container();
  }
}

//TODO: Token generation for payment to donation recieved and usage of token
class Paymethodesuccess extends StatelessWidget {
  final String? token;
  final String? paymentId;
  final String? PayerID;
  final double amount;
  final String Id;
  final String Idtype;
  final String sub;

  const Paymethodesuccess(
      {Key? key,
      this.token,
      this.paymentId,
      this.PayerID,
      required this.amount,
      required this.Id,
      required this.Idtype,
      required this.sub})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () {
      print('this is the Id: $Id');
      Navigator.pushNamed(
        context,
        '/ThankYou',
        arguments: {
          'Id': Id,
          'amount': amount,
          'sub': sub,
          'Idtype': Idtype,
        },
      );
    });

    return Container();
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
