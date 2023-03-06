import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

Future<Map<String, dynamic>?> payProcessing(
    token, amount, eventId, TEST, Endpoint) async {
  switch (TEST) {
    case true:
      Map<String, dynamic> result =
          await payprocessPostRequestTest(token, amount, eventId);
      return result;
    case false:
      Map<String, dynamic> result =
          await payprocessPostRequest(token, amount, eventId, Endpoint);
      return result;
  }
}

int calculateAmount(double amount) => (amount * 100).toInt();

//TODO: Test Function to be removed before release
Future<Map<String, dynamic>> payprocessPostRequestTest(
    token, amount, eventId) async {
  final body = {
    'amount': calculateAmount(amount).toString(),
    'currency': 'eur',
    'source': token,
    'description': eventId
  };

  // Make post request to Stripe

  final response = await http.post(
    Uri.parse('https://api.stripe.com/v1/charges'),
    headers: {
      'Authorization':
          'Bearer sk_test_51Mf6KIGgaqubfEkYS7pbs6IfLklaHU6aXN0nb0tLBfkQvF0OOKrohYNpevT8eYJxAclTOlT3L2hU4aHrMjFsKUwU00O9gO7YOK',
      'Content-Type': 'application/x-www-form-urlencoded'
    },
    body: body,
  );

  var jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;
  print(jsonResponse);
  return jsonResponse;
}

Future<Map<String, dynamic>> payprocessPostRequest(
    token, amount, eventId, Endpoint) async {
  final body = {
    'amount': calculateAmount(amount).toString(),
    'currency': 'eur',
    'source': token,
    'description': eventId
  };

  // Make post request to Stripe

  final response = await http.post(
    Uri.parse('$Endpoint/StripeCharge'),
    headers: {'Content-Type': 'application/x-www-form-urlencoded'},
    body: body,
  );

  var jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;
  print(jsonResponse);
  return jsonResponse;
}
