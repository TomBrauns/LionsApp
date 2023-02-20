import 'package:http/http.dart' as http;
import 'package:http_auth/http_auth.dart';
import 'package:lionsapp/Screens/payment/paymethode.dart';
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

Future<void> paypalOnPress() async {
  var url;
  var _url;
  final token = await paypalAuth();
  url = await makePaypalPayment(Paymethode().amount, token);
  _url = Uri.parse(url);
  if (!await launchUrl(_url)) {
    throw Exception('Could not launch $_url');
  }
}

Future<String> paypalAuth() async {
  const domain = "api.sandbox.paypal.com"; // for sandbox mode
  //  const domain = "api.paypal.com"; // for production mode

  // change clientId and secret with your own, provided by paypal
  const clientId =
      'ASWc84JED5XEgNRkOo2_f3JJP94KrXOwcQwig7WQ8HUeGN3Bqwi0xFuHMF1TQ3uEOnNB4IXgFrPw3SKh';
  const secret =
      'EEXhrXIRxgz5yoyXBNHoSKcXfiZMW0AeNC-YHTjfvRlVDmR-colaC1nZKXW0j3y8sKcdVRzTvNrno-b7';

  final apiUrl = Uri.https(domain, "/v1/oauth2/token");
  final client = BasicAuthClient(clientId, secret);
  final response = await client.post(apiUrl, headers: {
    'Accept': 'application/json',
    'Accept-Language': 'en_US',
  }, body: {
    'grant_type': 'client_credentials'
  });

  if (response.statusCode == 200) {
    final body = jsonDecode(response.body);
    return body['access_token'];
  } else {
    final body = jsonDecode(response.body);
    throw Exception("Failed to authenticate: ${body['error_description']}");
  }
}

Future<String?> makePaypalPayment(double amount, String token) async {
  const domain = "api.sandbox.paypal.com"; // for sandbox mode
  //  const domain = "api.paypal.com"; // for production mode

  final authToken = token;
  final apiUrl = Uri.https(domain, '/v1/payments/payment');

  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $authToken',
  };
  final requestBody = jsonEncode({
    'intent': 'sale',
    'payer': {
      'payment_method': 'paypal',
    },
    'transactions': [
      {
        'amount': {
          'total': amount,
          'currency': 'EUR',
        },
        'description': 'Test payment',
      },
    ],
    'redirect_urls': {
      'return_url': 'https://example.com/success',
      'cancel_url': 'https://example.com/cancel',
    },
  });

  final response = await http.post(apiUrl, headers: headers, body: requestBody);

  if (response.statusCode == 201) {
    final responseData = jsonDecode(response.body);
    final approvalUrl = responseData['links'][1]['href'];
    print('Payment created successfully: $approvalUrl');
    return approvalUrl;
    // Open the approvalUrl in a web view to allow the user to approve the payment
  } else {
    print('Failed to create payment: ${response.body}');
  }
}
