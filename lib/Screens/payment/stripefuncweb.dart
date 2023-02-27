import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'stripe_checkout.dart'
    if (dart.library.io) ''
    if (dart.library.html) 'stripe_checkout.dart';

void stripeOnPressWeb(double amount, context) async {
  //String Productid = await createProduct(amount);
  String Productid = "price_1MgCCcGgaqubfEkYDv6mI32x";
  //TODO: include function from excluded import
  //stripeWebCheckout(context, Productid);
}

int calculateAmount(double amount) => (amount * 100).toInt();

//TODO: Stripe create Product request post to be completed
//TODO: remove Product after completion
// https://stripe.com/docs/api/products/list
Future<String> createProduct(amount) async {
  int amountInCents = calculateAmount(amount);

  final body = {
    'name': 'Lions Club Spende',
    'description': 'test',
    'unit_amount': amountInCents.toString(),
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
  String Productid = jsonResponse['id'];
  return Productid;
}
