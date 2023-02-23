import 'package:flutter/material.dart';
import 'package:lionsapp/Screens/passwordForgotten.dart';
import 'package:lionsapp/Screens/payment/paymethode.dart';
import 'package:lionsapp/login/google/google_sign_in_button.dart';
import 'package:lionsapp/login/register.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _nameOrEmail;
  late String _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Name/Email',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Bitte geben Sie Ihren Namen oder Ihre E-Mail-Adresse ein!';
                  }
                  return null;
                },
                onSaved: (value) {
                  _nameOrEmail = value!;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Passwort',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Bitte geben Sie Ihr Passwort ein!';
                  }
                  return null;
                },
                onSaved: (value) {
                  _password = value!;
                },
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Paymethode()),
                        );
                      }
                    },
                    child: const Text('Anmelden'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Register()),
                      );
                    },
                    child: const Text('Hier registrieren'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PasswordForgottenScreen()),
                      );
                    },
                    child: const Text('Passwort vergessen?'),
                  ),
                  GoogleSignInButton(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
