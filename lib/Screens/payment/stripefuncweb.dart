import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'stripe_checkout.dart'
    if (dart.library.io) 'stripe_sidefunc.dart'
    if (dart.library.html) 'stripe_checkout.dart';

void stripeOnPressWeb(double amount, String eventId, context) async {
  List<String> ProductObject = await createProduct(eventId, amount);
  stripeWebCheckout(context, ProductObject[1]);
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
  print(response.statusCode);
  print(response.body);
  String productId = jsonResponse['id'];

  String priceId = await createPrice(amount, productId);
  updateProduct(priceId, productId);
  List<String> ProductObject = [productId, priceId];
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
  print(response.statusCode);
  print(response.body);
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
  print(response.statusCode);
  print(response.body);
}
