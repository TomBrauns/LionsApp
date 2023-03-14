//Licensed under the EUPL v.1.2 or later
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

Future<Map<String, dynamic>?> payProcessing(
    token, amount, eventId, Endpoint) async {
  Map<String, dynamic> result =
      await payprocessPostRequest(token, amount, eventId, Endpoint);
  return result;
}

int calculateAmount(double amount) => (amount * 100).toInt();

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
