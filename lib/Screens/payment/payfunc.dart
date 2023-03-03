import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

Future<void> payProcessing(token, amount, eventId) async {
  payprocessPostRequest(token, amount, eventId);
}

int calculateAmount(double amount) => (amount * 100).toInt();

Future<void> payprocessPostRequest(token, amount, eventId) async {
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
}
