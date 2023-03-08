import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

Future<void> stripeOnPressWeb(
    amount, eventId, context, baseUrl, Endpoint) async {
  List<String> ProductObject = await createProduct(eventId, amount, Endpoint);
  List<String> CheckoutObject = await stripeWebCheckout(
      ProductObject[1], baseUrl, amount, eventId, Endpoint);
  var _url = CheckoutObject[2];
  if (await canLaunchUrl(Uri.parse(_url))) {
    await launchUrl(Uri.parse(_url), webOnlyWindowName: '_self');
  } else {
    print("Could not launch URL");
  }
}

int calculateAmount(double amount) => (amount * 100).toInt();

Future<List<String>> createProduct(eventId, amount, Endpoint) async {
  final body = {
    'name': 'Lions Club Spende',
    'description': eventId,
  };

  // Make post request to Stripe

  final response = await http.post(
    Uri.parse('$Endpoint/StripeCreateProduct'),
    headers: {'Content-Type': 'application/x-www-form-urlencoded'},
    body: body,
  );

  var jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;
  //print(response.statusCode);
  //print(response.body);
  String productId = jsonResponse['id'];
  String priceId = await createPrice(amount, productId, Endpoint);
  updateProduct(priceId, productId, Endpoint);
  List<String> ProductObject = [jsonResponse['id'], priceId];
  return ProductObject;
}

Future<String> createPrice(amount, productId, Endpoint) async {
  int amountInCents = calculateAmount(amount);

  final body = {
    "currency": "eur",
    'unit_amount': amountInCents.toString(),
    "product": productId,
  };

  // Make post request to Stripe

  final response = await http.post(
    Uri.parse('$Endpoint/StripeCreatePrice'),
    headers: {'Content-Type': 'application/x-www-form-urlencoded'},
    body: body,
  );

  var jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;
  //print(response.statusCode);
  //print(response.body);
  String priceId = jsonResponse['id'];

  return priceId;
}

void updateProduct(priceId, productId, Endpoint) async {
  final body = {'productId': productId, 'price': priceId};

  // Make post request to Stripe

  final response = await http.post(
    Uri.parse('$Endpoint/StripeUpdateProduct'),
    headers: {'Content-Type': 'application/x-www-form-urlencoded'},
    body: body,
  );

  var jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;
  //print(response.statusCode);
  //print(response.body);
}

Future<List<String>> stripeWebCheckout(
    priceId, baseUrl, amount, eventId, Endpoint) async {
  final body = {
    'mode': "payment",
    'price': priceId,
    'quantity': '1',
    'success_url': '$baseUrl/ThankYou?amount=$amount&eventId=$eventId',
    'cancel_url':
        '$baseUrl/Donations/UserType/PayMethode/cancel?amount=$amount&eventId=$eventId'
  };

  // Make post request to Stripe

  final response = await http.post(
    Uri.parse('$Endpoint/StripeCreateCheckoutSession'),
    headers: {'Content-Type': 'application/x-www-form-urlencoded'},
    body: body,
  );

  var jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;
  var checkoutSessionId = jsonResponse['id'];
  //print('Checkout session ID: $checkoutSessionId');
  print(response.body);

  List<String> CheckoutObject = [
    jsonResponse['id'].toString(),
    jsonResponse['payment_intent'].toString(),
    jsonResponse['url'].toString()
  ];

  return CheckoutObject;
}
