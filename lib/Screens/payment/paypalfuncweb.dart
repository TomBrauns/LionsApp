import 'package:http/http.dart' as http;
import 'package:http_auth/http_auth.dart';
import 'package:lionsapp/Screens/payment/paymethode.dart';
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert' as convert;

Future<void> paypalOnPressWeb(
    double amount, Id, context, baseUrl, Endpoint, sub, Idtype) async {
  List<dynamic> PaypalObject =
      await makePaypalPayment(amount, Id, baseUrl, Endpoint, sub, Idtype);
  print(PaypalObject);

  if (await canLaunchUrl(Uri.parse(PaypalObject[0]))) {
    await launchUrl(Uri.parse(PaypalObject[0]), webOnlyWindowName: '_self');
  } else {
    //print("Could not launch URL");
  }
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

Future<List<String>> makePaypalPayment(
    double amount, Id, baseUrl, Endpoint, sub, Idtype) async {
  String token = await paypalAuth();
  final body = {
    'authToken': token,
    'amount': amount.toString(),
    'eventId': Id.toString(),
    'success_url':
        '$baseUrl/Donations/UserType/PayMethode/success?amount=$amount&Id=$Id&sub=$sub&Idtype=$Idtype',
    'cancel_url':
        '$baseUrl/Donations/UserType/PayMethode/cancel?amount=$amount&Id=$Id&sub=$sub&Idtype=$Idtype',
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
