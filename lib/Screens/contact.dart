import 'package:flutter/material.dart';
import 'package:lionsapp/Widgets/burgermenu.dart';
import 'package:mb_contact_form/mb_contact_form.dart';

class Contact extends StatefulWidget {
  const Contact({Key? key}) : super(key: key);

  @override
  State<Contact> createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  get child => null;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const BurgerMenu(),
      appBar: AppBar(
        title: const Text("Kontakt"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsetsDirectional.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            MBContactForm(
                hasHeading: true,
                withIcons: false,
                destinationEmail: "XXXXX@yahoo.com"),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.blue)),
              onPressed: null,
              child: Text(
                "Weitere Datei zu hochladen hier reinziehen",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  color(Color white) {}
}






class Contactform extends StatefulWidget {
  const Contactform({super.key});

  @override
  State<Contactform> createState() => _ContactformState();
}

class _ContactformState extends State<Contactform> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
/*import 'package:flutter/material.dart';
import 'package:mb_button/mb_button.dart';
import 'package:url_launcher/url_launcher.dart';

class Contact extends StatefulWidget {
  final bool withIcons;
  final String destinationEmail;
  final bool hasHeading;

  const Contact({
    Key? key,
    this.hasHeading = true,
    required this.withIcons,
    required this.destinationEmail,
  }) : super(key: key);

  @override
  State<Contact> createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameEditingController = TextEditingController();
  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _messageEditingController =
      TextEditingController();

  String name = '';
  String email = '';
  String message = '';

  @override
  void dispose() {
    _nameEditingController.dispose();
    _emailEditingController.dispose();
    _messageEditingController.dispose();
    super.dispose();
  }

  String? _validateName(String name) {
    String nameRegExp = r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$";

    if (name.isEmpty) {
      return 'Vor und Nachname eingeben';
    }
    if (!RegExp(nameRegExp).hasMatch(name)) {
      return 'Give a space between \nyour first name and last name';
    }
    return null;
  }

  String? _validateEmail(String email) {
    String emailRegExp =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    if (email.isEmpty) {
      return 'Enter your email';
    }
    if (!RegExp(emailRegExp).hasMatch(email)) {
      return 'Enter correctly.\nexample: username@example.com';
    }
    return null;
  }

  String? _validateMessage(String name) {
    if (name.isEmpty) {
      return 'Message is empty. Please fill it.';
    }
    return null;
  }

  void _sendEmail(
      {required String destEmail, required String body, required String name}) {
    String? encodeQueryParameters(Map<String, String> params) {
      return params.entries
          .map((e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
          .join('&');
    }

    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: destEmail,
      query: encodeQueryParameters(<String, String>{
        'subject': 'Feedback from $name',
        'body': body,
      }),
    );

    launchUrl(emailLaunchUri);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(
        left: 32,
        right: 32,
        top: 32,
        bottom: 32,
      ),

      ///contact form
      child: Form(
        key: _formKey,
        child: Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              20,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              left: 24,
              right: 24,
              top: 32,
              bottom: 32,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                widget.hasHeading
                    ? const Text(
                        'Kontakt und Hilfe',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      )
                    : Container(),

                const SizedBox(
                  height: 32,
                ),
                // Name Field
                TextFormField(
                  controller: _nameEditingController,
                  keyboardType: TextInputType.name,
                  textCapitalization: TextCapitalization.words,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) => _validateName(value!),
                  onChanged: (value) {
                    setState(() {
                      name = value;
                    });
                  },
                  onSaved: (value) {
                    setState(() {
                      name = value!;
                    });
                  },
                  decoration: InputDecoration(
                    icon: widget.withIcons
                        ? const Icon(Icons.person_outline)
                        : null,
                    label: const Text('Name'),
                    hintText: 'Vor und -Nachname eingeben',
                    border: const OutlineInputBorder(),
                  ),
                ),

                const SizedBox(
                  height: 32,
                ),

                // Email Field
                TextFormField(
                  controller: _emailEditingController,
                  keyboardType: TextInputType.emailAddress,
                  textCapitalization: TextCapitalization.none,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) => _validateEmail(value!),
                  onChanged: (value) {
                    setState(() {
                      email = value;
                    });
                  },
                  onSaved: (value) {
                    setState(() {
                      email = value!;
                    });
                  },
                  decoration: InputDecoration(
                    icon: widget.withIcons
                        ? const Icon(Icons.alternate_email)
                        : null,
                    label: const Text('E-mail'),
                    hintText: 'E-Mail eingeben',
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),

                // Message or Feedback Field
                TextFormField(
                  controller: _messageEditingController,
                  keyboardType: TextInputType.text,
                  maxLines: 5,
                  textCapitalization: TextCapitalization.sentences,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) => _validateMessage(value!),
                  onChanged: (value) {
                    setState(() {
                      message = value;
                    });
                  },
                  onSaved: (value) {
                    setState(() {
                      message = value!;
                    });
                  },
                  decoration: InputDecoration(
                    icon: widget.withIcons
                        ? const Icon(Icons.message_outlined)
                        : null,
                    label: const Text('Text'),
                    hintText: 'Text eingeben',
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),

                // Submit button
                MBButton(
                  isIconButton: true,
                  elevation: 0,
                  roundness: 10,
                  text: 'Senden',
                  onTapFunction: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      setState(() {
                        _sendEmail(
                          name: name,
                          destEmail: widget.destinationEmail,
                          body: message,
                        );
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}*/
