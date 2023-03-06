import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

Future<void> stripeOnPressWeb(
    amount, eventId, context, paymethodsite, baseUrl) async {
  List<String> ProductObject = await createProduct(eventId, amount);
  List<String> CheckoutObject = await stripeWebCheckout(
      ProductObject[1], paymethodsite, baseUrl, amount, eventId);
  var _url = CheckoutObject[2];
  if (await canLaunchUrl(Uri.parse(_url))) {
    await launchUrl(Uri.parse(_url), webOnlyWindowName: '_self');
  } else {
    print("Could not launch URL");
  }
}

int calculateAmount(double amount) => (amount * 100).toInt();

Future<List<String>> createProduct(eventId, amount) async {
  final body = {
    'name': 'Lions Club Spende',
    'description': eventId,
  };

  // Make post request to Stripe

  final response = await http.post(
    Uri.parse('https://api.stripe.com/v1/products'),
    headers: {
      'Authorization':
          'Bearer sk_test_51Mf6KIGgaqubfEkYS7pbs6IfLklaHU6aXN0nb0tLBfkQvF0OOKrohYNpevT8eYJxAclTOlT3L2hU4aHrMjFsKUwU00O9gO7YOK',
      'Content-Type': 'application/x-www-form-urlencoded'
    },
    body: body,
  );

  var jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;
  //print(response.statusCode);
  //print(response.body);
  String productId = jsonResponse['id'];

  String priceId = await createPrice(amount, productId);
  updateProduct(priceId, productId);
  List<String> ProductObject = [jsonResponse['id'], priceId];
  return ProductObject;
}

Future<String> createPrice(amount, productId) async {
  int amountInCents = calculateAmount(amount);

  final body = {
    "currency": "eur",
    "unit_amount": amountInCents.toString(),
    "product": productId
  };

  // Make post request to Stripe

  final response = await http.post(
    Uri.parse('https://api.stripe.com/v1/prices'),
    headers: {
      'Authorization':
          'Bearer sk_test_51Mf6KIGgaqubfEkYS7pbs6IfLklaHU6aXN0nb0tLBfkQvF0OOKrohYNpevT8eYJxAclTOlT3L2hU4aHrMjFsKUwU00O9gO7YOK',
      'Content-Type': 'application/x-www-form-urlencoded'
    },
    body: body,
  );

  var jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;
  //print(response.statusCode);
  //print(response.body);
  String priceId = jsonResponse['id'];

  return priceId;
}

void updateProduct(priceId, productId) async {
  final body = {"default_price": priceId};

  // Make post request to Stripe

  final response = await http.post(
    Uri.parse('https://api.stripe.com/v1/products/$productId'),
    headers: {
      'Authorization':
          'Bearer sk_test_51Mf6KIGgaqubfEkYS7pbs6IfLklaHU6aXN0nb0tLBfkQvF0OOKrohYNpevT8eYJxAclTOlT3L2hU4aHrMjFsKUwU00O9gO7YOK',
      'Content-Type': 'application/x-www-form-urlencoded'
    },
    body: body,
  );

  var jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;
  //print(response.statusCode);
  //print(response.body);
}

Future<List<String>> stripeWebCheckout(
    priceId, paymethodesite, baseUrl, amount, eventId) async {
  final body = {
    'mode': "payment",
    'line_items[0][price]': priceId,
    'line_items[0][quantity]': '1',
    'success_url': '$baseUrl/ThankYou?amount=$amount&eventId=$eventId',
    'cancel_url':
        '$baseUrl/Donations/UserType/PayMethode/cancel?amount=$amount&eventId=$eventId'
  };

  // Make post request to Stripe

  final response = await http.post(
    Uri.parse('https://api.stripe.com/v1/checkout/sessions'),
    headers: {
      'Authorization':
          'Bearer sk_test_51Mf6KIGgaqubfEkYS7pbs6IfLklaHU6aXN0nb0tLBfkQvF0OOKrohYNpevT8eYJxAclTOlT3L2hU4aHrMjFsKUwU00O9gO7YOK',
      'Content-Type': 'application/x-www-form-urlencoded'
    },
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
