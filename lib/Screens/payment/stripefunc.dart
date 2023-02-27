import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import 'package:http/http.dart' as http;

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

Future<void> stripeOnPressApp(double amount, context) async {
  final amountInCents = calculateAmount(amount);
  stripeSettings();
  try {
    // STEP 1: Create Payment Intent
    paymentIntent = await createPaymentIntent(amountInCents.toString(), 'EUR');

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
  } catch (e, stackTrace) {
    if (e is Exception) {
      // Handle the cancellation of the payment flow
      if (e is StripeException &&
          e.error.localizedMessage == 'The payment flow has been canceled') {
        // Display a message to the user indicating that the payment has been canceled
      } else {
        // Handle other exceptions
        print('Error occurred: $e');
        print(stackTrace);
      }
    }
  }
}

Future<Map<String, dynamic>> createPaymentIntent(
    String amount, String currency) async {
  try {
    // Request body
    final body = {
      'amount': amount,
      'currency': currency,
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

Future<void> displayPaymentSheet() async {
  await Stripe.instance.presentPaymentSheet().then((_) {
    // Clear paymentIntent variable after successful payment
    paymentIntent = null;
  }).catchError((error, stackTrace) {
    print('Error occurred: $error');
    print(stackTrace);
  });
}
