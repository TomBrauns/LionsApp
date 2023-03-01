import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lionsapp/Screens/donation.dart';
import 'package:lionsapp/Screens/user/confirmMailForPwReset.dart';
import 'package:lionsapp/login/apple/apple_sign_in_button.dart';
import 'register.dart';
import 'package:lionsapp/Widgets/burgermenu.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lionsapp/login/google/authentication.dart';
import 'package:lionsapp/login/google/google_sign_in_button.dart';
import 'package:lionsapp/Widgets/privileges.dart';
import 'package:lionsapp/Widgets/burgermenu.dart' as constant;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lionsapp/login/register.dart' as test;

class LoginPage extends StatefulWidget {
  final String? prefilledEmail;
  const LoginPage({super.key, this.prefilledEmail});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  /* TEST */
  bool isLoggedIN = false;
  GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);

  /* ENDE */
  bool _isObscure3 = true;
  bool _isLoading = false;
  final _formkey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    if (widget.prefilledEmail != null) {
      emailController.text = widget.prefilledEmail!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const BurgerMenu(),
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              color: const Color.fromARGB(255, 29, 89, 167),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Center(
                //LoginText
                child: Container(
                  margin: const EdgeInsets.all(12),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "Login",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 40,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Email',
                            enabled: true,
                            contentPadding: const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          validator: (value) {
                            if (value!.length == 0) {
                              return "Email cannot be empty";
                            }
                            if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
                              return ("Please enter a valid email");
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) {
                            emailController.text = value!;
                          },
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: passwordController,
                          obscureText: _isObscure3,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                                icon: Icon(_isObscure3 ? Icons.visibility : Icons.visibility_off),
                                onPressed: () {
                                  setState(() {
                                    _isObscure3 = !_isObscure3;
                                  });
                                }),
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Password',
                            enabled: true,
                            contentPadding: const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 15.0),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          validator: (value) {
                            RegExp regex = RegExp(r'^.{6,}$');
                            if (value!.isEmpty) {
                              return "Password cannot be empty";
                            }
                            if (!regex.hasMatch(value)) {
                              return ("please enter valid password min. 6 character");
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) {
                            passwordController.text = value!;
                          },
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            MaterialButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const PwReset(),
                                  ),
                                );
                              },
                              child: const Text(
                                "Passwort vergessen",
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 60,
                        ),
                        MaterialButton(
                          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
                          elevation: 5.0,
                          height: 40,
                          onPressed: () {
                            setState(
                              () {
                                _isLoading = true;
                              },
                            );
                            signIn(emailController.text, passwordController.text);
                          },
                          child: const Text(
                            "Login",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          color: Colors.white,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Visibility(
                            maintainSize: true,
                            maintainAnimation: true,
                            maintainState: true,
                            visible: _isLoading,
                            child: Container(
                                child: const CircularProgressIndicator(
                              color: Colors.white,
                            ))),
                        //TEST
                        FutureBuilder(
                          future: Authentication.initializeFirebase(context: context),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return const Text('Error initializing Firebase');
                            } else if (snapshot.connectionState == ConnectionState.done) {
                              return GoogleSignInButton();
                            }
                            return const CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.orange,
                              ),
                            );
                          },
                        ),
                        // Apple testing
                        /* FutureBuilder(
                          future: Authentication.initializeFirebase(context: context),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return const Text('Error initializing Firebase');
                            } else if (snapshot.connectionState == ConnectionState.done) {
                              return AppleSignInButton();
                            }
                            return const CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.orange,
                              ),
                            );
                          },
                        ), */
                        MaterialButton(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                          ),
                          elevation: 5.0,
                          height: 40,
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Register(),
                              ),
                            );
                          },
                          color: Colors.blue[900],
                          child: const Text(
                            "Register Now",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  void signIn(String email, String password) async {
    if (_formkey.currentState!.validate()) {
      FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((cred) {
        //if (!cred.user!.emailVerified) {
        //TODO: Sollte eigentlich eingeschaltet sein - aber nervt beim developen
        //ScaffoldMessenger.of(context).showSnackBar(
        //  const SnackBar(content: Text('Bitte bestätigen sie zu erst ihre Email Adresse')),
        //);
        //} else {
        checkRool().then((_) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Donations(),
              ));
          setState(() {
            _isLoading = false;
          });
        });
        //}
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Die E-Mail oder das Passwort ist falsch.'), backgroundColor: Colors.redAccent),
        );
        setState(() {
          _isLoading = false;
        });
      });
    }
  }
}

Future<void> checkRool() async {
  User? user = FirebaseAuth.instance.currentUser;

  DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance.collection('users').doc(user!.uid).get();
  Privileges.privilege = documentSnapshot.get('rool');
  print(Privileges.privilege);
}
