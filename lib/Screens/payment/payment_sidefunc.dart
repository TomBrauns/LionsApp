//Licensed under the EUPL v.1.2 or later
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

Future<List<String>> retrieveCheckout(id) async {
  final body = {};

  // Make post request to Stripe

  final response = await http.post(
    Uri.parse('https://api.stripe.com/v1/checkout/sessions/$id'),
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

  String PaymentIntentId = jsonResponse['payment_intent'];
  List<String> PaymentIntentObject =
      await retrievePaymentIntent(PaymentIntentId);
  return PaymentIntentObject;
}

Future<List<String>> retrievePaymentIntent(id) async {
  final body = {};

  // Make post request to Stripe

  final response = await http.post(
    Uri.parse('https://api.stripe.com/v1/payment_intents/$id'),
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

  List<String> PaymentIntentObject = [
    jsonResponse['amount'],
    jsonResponse['description']
  ];
  return PaymentIntentObject;
}
