import 'package:flutter/material.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AppleSignInButton extends StatefulWidget {
  @override
  _AppleSignInButtonState createState() => _AppleSignInButtonState();
}

class _AppleSignInButtonState extends State<AppleSignInButton> {

  Future<void> _handleSignInWithApple() async{
    try{
      final credential = await SignInWithApple.getAppleIDCredential(
          scopes: [
            AppleIDAuthorizationScopes.email,
            AppleIDAuthorizationScopes.fullName
          ]
      );

      print(credential);

      final String? userIdentifier = credential.userIdentifier;
      final String? email = credential.email;
      final String fullName = '${credential.givenName} ${credential.familyName}';

    }catch (error){
      print("Sign in ist fehlgeschlagen");
    }
  }

  bool _isSigningIn = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30.0),
      child: _isSigningIn
          ? const CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      )
          : GestureDetector(
        onTap: () async {

          _handleSignInWithApple();

        },
        child: SignInWithAppleButton(
          text: 'Mit Apple anmelden',
          onPressed: () {
            _handleSignInWithApple();
          },
        ),
      ),
    );
  }
}