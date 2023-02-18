import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lionsapp/Screens/donation.dart';

class EventDetailsPage extends StatefulWidget {
  const EventDetailsPage({Key? key, required QueryDocumentSnapshot<Object?> event}) : super(key: key);

  @override
  State<EventDetailsPage> createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends State<EventDetailsPage> {
  // TODO fetch this
  final String _title = "Martini-Konzert";
  final String _imgUri = "assets/events/martini-konzert.jpg";
  final String _location = "Markhalle Worms";
  final DateTime _date = DateTime.now();
  final String _project = "Kinderkrebs";
  final int _target = 10000;
  final String _description =
      "Gerade in schwierigen Zeiten wird einem der Wert von Freundschaft bewusst. Und deshalb stellte der Lions Club in diesem Jahr das Thema der Freundschaft in den Mittelpunkt. Für unser 8. Martini-Konzert haben wir gemeinsam mit der Fruchthalle Kaiserslautern die USAFE Ambassadors Rock Band für ein deutsch-amerikanisches Freundschaftskonzert gewinnen können. Die USAFE Ambassadors Rock Band ist ein 9-köpfiges Ensemble und brachte mit den besten Pop-, Funk- und Soul-Klassikern viel freundschaftliche Freude in die Fruchhalle. Vielen Dank für Ihren Besuch.";

  // Style
  final TextStyle _headlineStyle =
  const TextStyle(fontWeight: FontWeight.bold, fontSize: 18);
  final TextStyle _textStyle = const TextStyle(fontSize: 16);

  void _handleDonation() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Donations()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_title),
        ),
        body: SingleChildScrollView(
            child:
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Image.asset(_imgUri,
                  width: double.infinity, height: 250, fit: BoxFit.cover),
              Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Expanded(
                            child: Card(
                                child: ListTile(
                                  title: Row(children: const [
                                    Icon(
                                      Icons.calendar_month,
                                      size: 16,
                                      color: Colors.black,
                                    ),
                                    Text("Datum")
                                  ]),
                                  subtitle: Text(DateFormat("d. MMM y").format(_date),
                                      maxLines: 1),
                                ))),
                        Expanded(
                            child: Card(
                                child: ListTile(
                                  title: Row(children: const [
                                    Icon(
                                      Icons.location_on,
                                      size: 16,
                                      color: Colors.black,
                                    ),
                                    Text("Ort")
                                  ]),
                                  subtitle: Text(_location, maxLines: 1),
                                ))),
                      ]),
                      Row(children: [
                        Expanded(
                            child: Card(
                                child: ListTile(
                                  title: Row(children: const [
                                    Icon(
                                      Icons.supervised_user_circle,
                                      size: 16,
                                      color: Colors.black,
                                    ),
                                    Text("Zweck")
                                  ]),
                                  subtitle: Text(_project, maxLines: 1),
                                ))),
                        Expanded(
                            child: Card(
                                child: ListTile(
                                  title: Row(children: const [
                                    Icon(
                                      Icons.crisis_alert,
                                      size: 16,
                                      color: Colors.black,
                                    ),
                                    Text("Ziel")
                                  ]),
                                  subtitle: Text("$_target€", maxLines: 1),
                                ))),
                      ]),
                      const SizedBox(height: 16),
                      Text("Was machen wir?", style: _headlineStyle),
                      const SizedBox(height: 4),
                      Text(_description, style: _textStyle),
                      const SizedBox(height: 32),
                      Center(
                          child: ElevatedButton(
                            onPressed: _handleDonation,
                            child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 6.0, horizontal: 4.0),
                                child: Text("Spenden", style: TextStyle(fontSize: 22))),
                          )),
                      const SizedBox(height: 32),
                    ],
                  ))
            ])));
  }
}
