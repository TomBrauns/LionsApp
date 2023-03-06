import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:lionsapp/Screens/donation_received.dart';
import 'package:lionsapp/Screens/payment/payment_sidefunc.dart';

import 'package:http/http.dart' as http;
import 'package:lionsapp/Screens/payment/paymethode.dart';

Map<String, dynamic>? paymentIntent;

void stripeSettings() {
  WidgetsFlutterBinding.ensureInitialized();

  Stripe.publishableKey =
      "pk_test_51Mf6KIGgaqubfEkY4mjPoHhaJCcKIl202B51rY22iMrPKfh4mqNREIT0cBn9EmypeyJ92nC7mJpCwWHg1ZexBY8V00BAEi7S8t";
  Stripe.merchantIdentifier = 'Team Lions App';
  Stripe.instance.applySettings();
}

// Calculate amount in cents
int calculateAmount(double amount) => (amount * 100).toInt();

Future<bool?> stripeOnPressApp(
    double amount, eventId, context, TEST, Endpoint) async {
  final amountInCents = calculateAmount(amount);
  stripeSettings();
  bool returnvalue = false;
  try {
    // STEP 1: Create Payment Intent

    switch (TEST) {
      case true:
        Map<String, dynamic> result = paymentIntent =
            await createPaymentIntentTest(
                amountInCents.toString(), 'EUR', eventId);
        break;
      case false:
        Map<String, dynamic> result = paymentIntent = await createPaymentIntent(
            amountInCents.toString(), 'EUR', eventId, Endpoint);
        break;
    }

    // Get the paymentintentObject
    String paymentIntentId = paymentIntent!['id'];
    print('Payment Intent ID: $paymentIntentId');

    // STEP 2: Initialize Payment Sheet
    await Stripe.instance
        .initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
                paymentIntentClientSecret:
                    paymentIntent!['client_secret'] as String,
                style: ThemeMode.light,
                merchantDisplayName: 'Lions Team'))
        .then((_) {});

    // STEP 3: Display Payment sheet
    await displayPaymentSheet();
    returnvalue = true;
  } catch (e) {
    print('Payment cancelled by user: ${e}');
    returnvalue = false;
  } catch (e, stackTrace) {
    print('Error occurred: $e');
    print(stackTrace);
    returnvalue = false;
  }
  return returnvalue;
}

//TODO: Test Function to be removed before release
Future<Map<String, dynamic>> createPaymentIntentTest(
    String amount, String currency, eventId) async {
  try {
    // Request body
    final body = {
      'amount': amount,
      'currency': currency,
      'description': eventId,
    };

    // Make post request to Stripe
    final response = await http.post(
      Uri.parse('https://api.stripe.com/v1/payment_intents'),
      headers: {
        'Authorization':
            'Bearer sk_test_51Mf6KIGgaqubfEkYS7pbs6IfLklaHU6aXN0nb0tLBfkQvF0OOKrohYNpevT8eYJxAclTOlT3L2hU4aHrMjFsKUwU00O9gO7YOK',
        'Content-Type': 'application/x-www-form-urlencoded'
      },
      body: body,
    );
    return json.decode(response.body);
  } catch (err, stackTrace) {
    throw Exception('Failed to create payment intent: $err');
  }
}

Future<Map<String, dynamic>> createPaymentIntent(
    String amount, String currency, eventId, Endpoint) async {
  try {
    // Request body
    final body = {
      'amount': amount,
      'currency': currency,
      'description': eventId,
    };

    // Make post request to Stripe

    final response = await http.post(
      Uri.parse('$Endpoint/StripePaymentIntent'),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: body,
    );

    return json.decode(response.body);
  } catch (err, stackTrace) {
    throw Exception('Failed to create payment intent: $err');
  }
}

Future<void> displayPaymentSheet() async {
  try {
    await Stripe.instance.presentPaymentSheet().then((_) {
      // Clear paymentIntent variable after successful payment
      paymentIntent = null;
    });
  } catch (e) {
    print('Payment cancelled by user: ${e}');
    // Handle the cancellation of the payment flow
    throw e;
  } catch (e, stackTrace) {
    print('Error occurred: $e');
    print(stackTrace);
  }
}
