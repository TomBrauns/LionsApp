import 'package:flutter/material.dart';
import 'package:lionsapp/Screens/user_configs.dart';
import 'package:lionsapp/Widgets/burgermenu.dart';
import 'package:lionsapp/Screens/user_configs.dart';

class Donations extends StatefulWidget {
  const Donations({Key? key}) : super(key: key);

  @override
  State<Donations> createState() => _DonationsState();
}

class _DonationsState extends State<Donations> {
  static const subscriptions = [
    "Einmalig",
    "Monatlich",
    "Halbjährlich",
    "Jährlich"
  ];

  // Test Value
  String privilege = "Member";
  //

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _inputController = TextEditingController();
  bool _isReceiptChecked = false;
  String selectedSubscription = subscriptions[0];

  int _getCurrentValue() {
    return int.tryParse(_inputController.value.text) ?? 0;
  }

  void _handleAdd(int value) {
    _inputController.text = (_getCurrentValue() + value).toString();
  }

  void _handleSubscriptionChange(String? subscription) {
    selectedSubscription = subscription ?? selectedSubscription;
  }

  void _handleSubmit() {
    int value = _getCurrentValue();
    // TODO Submitted
    print(
        "Value=$value, Quittung=$_isReceiptChecked, Sub=$selectedSubscription");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const BurgerMenu(),
        appBar: AppBar(
            title: const Text("Spenden"),
            // User Icon in AppBar
            actions: <Widget>[
              privilege == "Member" || privilege == "Friend"
                  ? IconButton(
                      icon: Icon(Icons.person),
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => User()),
                        );
                      })
                  : Container(),
              // End User Icon
            ]),
        body: Container(
            padding: const EdgeInsets.all(16),
            child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                        width: double.infinity,
                        child: Text(
                            "Spendensammlung für die Erdbebenopfer in der Türkei",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 24))),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 32),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text("Spendenziel: 10.000€"),
                            LinearProgressIndicator(
                                value: 0.42, minHeight: 24.0),
                          ]),
                    ),
                    DropdownButtonFormField(
                      value: selectedSubscription,
                      items: subscriptions
                          .map<DropdownMenuItem<String>>(((sub) =>
                              DropdownMenuItem(value: sub, child: Text(sub))))
                          .toList(),
                      onChanged: _handleSubscriptionChange,
                      decoration:
                          const InputDecoration(border: OutlineInputBorder()),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _inputController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Betrag",
                          suffix: Text("€")),
                    ),
                    Container(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [5, 10, 25, 50, 100]
                                .map((int amount) => FilledButton(
                                    onPressed: () => _handleAdd(amount),
                                    child: Text("+ $amount€")))
                                .toList())),
                    const SizedBox(height: 24),
                    Row(children: [
                      Checkbox(
                        value: _isReceiptChecked,
                        onChanged: (checked) => setState(() {
                          _isReceiptChecked = checked ?? false;
                        }),
                      ),
                      const Text("Ich möchte eine Quittung erhalten.")
                    ]),
                    const SizedBox(height: 16),
                    SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: _handleSubmit,
                            child: Container(
                                padding: const EdgeInsets.all(8.0),
                                child: const Text("Spenden",
                                    style: TextStyle(fontSize: 18))))),
                    Expanded(child: Container()),
                    const Text("Gesponsort von: Rewe"),
                    SizedBox(
                        width: double.infinity,
                        height: 128,
                        child: Container(
                          decoration: const BoxDecoration(color: Colors.grey),
                        ))
                  ],
                ))));
  }
}
