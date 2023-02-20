import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:http_auth/http_auth.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:lionsapp/Screens/payment/paymethode.dart';

Future<void> stripeOnPress(amount) async {
  final String paymentUrl = 'https://checkout.stripe.com/pay' +
      '?key=${STRIPE_PUBLISHABLE_KEY}' +
      '&amount=${amount * 100}' + // Convert amount to cents
      '&currency=EUR';
  await launchUrl(Uri.parse(paymentUrl));
}
