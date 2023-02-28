import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

void stripeWebCheckout(context, Productid) async {
  throw Exception('wrong Platform handled function call');
}

Future<List<String>> retrieveCheckoutId() async {
  final body = {
    'limit': 1,
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
  print(response.statusCode);
  print(response.body);
  String checkoutId = jsonResponse['id'];

  List<String> CheckoutObject = await retrieveCheckout(checkoutId);
  return CheckoutObject;
}

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
  String productId = jsonResponse['id'];

  List<String> CheckoutObject = [];
  return CheckoutObject;
}

Future<List<String>> retrievePaymentIntent() async {
  final body = {};

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

  List<String> PaymentIntentObject = [];
  return PaymentIntentObject;
}
