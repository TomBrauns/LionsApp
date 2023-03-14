import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

Future<void> stripeSubOnPress(
    amount, eventId, context, baseUrl, Endpoint, sub, customerId) async {
  String? subdate = subtodate(sub);
  List<String> ProductObject =
      await createProduct(eventId, amount, Endpoint, subdate);
  //String subId = await createSubscription(Endpoint, customerId, ProductObject[1], eventId);
  List<String> CheckoutObject = await stripeWebCheckout(ProductObject[1],
      baseUrl, amount, eventId, Endpoint, subdate, customerId);
  var _url = CheckoutObject[2];
  if (await canLaunchUrl(Uri.parse(_url))) {
    await launchUrl(Uri.parse(_url), webOnlyWindowName: '_self');
  } else {
    print("Could not launch URL");
  }
}

String? subtodate(String sub) {
  switch (sub) {
    case "Monatlich":
      return 'month';
    case "Jährlich":
      return 'year';
  }
}

int calculateAmount(double amount) => (amount * 100).toInt();

Future<List<String>> createProduct(eventId, amount, Endpoint, subdate) async {
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

  String priceId = await createPrice(amount, productId, Endpoint, subdate);
  updateProduct(priceId, productId, Endpoint);
  List<String> ProductObject = [productId, priceId];
  return ProductObject;
}

Future<String> createPrice(amount, productId, Endpoint, subdate) async {
  int amountInCents = calculateAmount(amount);

  final body = {
    "currency": "eur",
    'unit_amount': amountInCents.toString(),
    "product": productId,
    "interval": subdate
  };

  // Make post request to Stripe

  final response = await http.post(
    Uri.parse('$Endpoint/StripeCreateSubscriptionPrice'),
    headers: {'Content-Type': 'application/x-www-form-urlencoded'},
    body: body,
  );

  var jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;
  //print(response.statusCode);
  //print(response.body);
  print("still alive");
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

Future<String> createSubscription(Endpoint, customerId, price, eventId) async {
  final body = {
    "description": eventId,
    "customerId": customerId,
    "priceId": price,
    "anchor": "now"
  };

  // Make post request to Stripe

  final response = await http.post(
    Uri.parse('$Endpoint/StripeCreateSubscription'),
    headers: {'Content-Type': 'application/x-www-form-urlencoded'},
    body: body,
  );

  var jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;
  //print(response.statusCode);
  //print(response.body);
  String subId = jsonResponse['id'];

  return subId;
}

Future<List<String>> stripeWebCheckout(
    priceId, baseUrl, amount, eventId, Endpoint, sub, customerId) async {
  final body = {
    'mode': "subscription",
    'price': priceId,
    'quantity': '1',
    'customer': customerId,
    'interval': sub,
    'success_url':
        '$baseUrl/Donations/UserType/PayMethode/success?amount=$amount&eventId=$eventId&sub=$sub',
    'cancel_url':
        '$baseUrl/Donations/UserType/PayMethode/cancel?amount=$amount&eventId=$eventId&sub=$sub'
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
