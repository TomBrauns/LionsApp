import 'package:http/http.dart' as http;
import 'package:http_auth/http_auth.dart';
import 'package:lionsapp/Screens/payment/paymethode.dart';
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert' as convert;

Future<void> paypalOnPressApp(
    double amount, eventId, context, TEST, Endpoint) async {
  switch (TEST) {
    case true:
      final token = await paypalAuthTest();

      List<dynamic> PaypalObject =
          await makePaypalPaymentTest(amount, token, eventId);
      print(PaypalObject);

      if (await canLaunchUrl(Uri.parse(PaypalObject[0]))) {
        await launchUrl(Uri.parse(PaypalObject[0]));
      } else {
        //print("Could not launch URL");
      }
      break;
    case false:
      List<dynamic> PaypalObject =
          await makePaypalPayment(amount, eventId, Endpoint);
      print(PaypalObject);

      if (await canLaunchUrl(Uri.parse(PaypalObject[0]))) {
        await launchUrl(Uri.parse(PaypalObject[0]));
      } else {
        //print("Could not launch URL");
      }
      break;
  }
}

//TODO: Test Function to be removed before release
Future<String> paypalAuthTest() async {
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

  print(response.body);

  if (response.statusCode == 200) {
    final body = jsonDecode(response.body);
    return body['access_token'];
  } else {
    final body = jsonDecode(response.body);
    throw Exception("Failed to authenticate: ${body['error_description']}");
  }
}

Future<List<String>> makePaypalPaymentTest(
    double amount, String token, eventId) async {
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
        'description': eventId,
      },
    ],
    'redirect_urls': {
      'return_url': '/ThankYou?amount=$amount&eventId=$eventId',
      'cancel_url':
          '/Donations/UserType/PayMethode/cancel?amount=$amount&eventId=$eventId',
    },
  });

  final response = await http.post(apiUrl, headers: headers, body: requestBody);
  print(response.body);
  final responseData = jsonDecode(response.body);
  final approvalUrl = responseData['links'][1]['href'];
  print('Payment created successfully: $approvalUrl');
  List<String> paypalObject = [
    responseData['links'][1]['href'],
    responseData["transactions"][0]['description'],
    responseData["transactions"][0]['amount']['total']
  ];
  print(paypalObject);
  return paypalObject;
  // Open the approvalUrl in a web view to allow the user to approve the payment
}

Future<String> paypalAuth() async {
  final response = await http.post(
    Uri.parse('$Endpoint/PaypalAuthenticate'),
  );
  print(response.runtimeType);
  if (response.statusCode == 200) {
    final body = convert.jsonDecode(response.body);
    return body['access_token'];
  } else {
    final body = convert.jsonDecode(response.body);
    throw Exception("Failed to authenticate: ${body['error_description']}");
  }
}

Future<List<String>> makePaypalPayment(double amount, eventId, Endpoint) async {
  String token = await paypalAuth();
  final body = {
    'authToken': token,
    'amount': amount.toString(),
    'eventId': eventId.toString(),
    'success_url': '/ThankYou?amount=$amount&eventId=$eventId',
    'cancel_url':
        '/Donations/UserType/PayMethode/cancel?amount=$amount&eventId=$eventId',
    'currency': "EUR",
  };

  final response =
      await http.post(Uri.parse('$Endpoint/PaypalPayment'), body: body);
  print(response.runtimeType);
  print(response.body);
  final responseData = jsonDecode(response.body);
  final approvalUrl = responseData['links'][1]['href'];
  print('Payment created successfully: $approvalUrl');
  List<String> paypalObject = [
    responseData['links'][1]['href'],
    responseData["transactions"][0]['description'],
    responseData["transactions"][0]['amount']['total']
  ];
  print(paypalObject);
  return paypalObject;
  // Open the approvalUrl in a web view to allow the user to approve the payment
}
