import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lionsapp/Widgets/appbar.dart';
import 'package:lionsapp/Widgets/textSize.dart';
import 'package:url_launcher/url_launcher.dart';

class History extends StatefulWidget {
  History({Key? key}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MyAppBar(title: "Mein Spendenverlauf"),
      body: HistoryList(),
    );
  }
}

class HistoryList extends StatefulWidget {
  const HistoryList({Key? key}) : super(key: key);

  @override
  State<HistoryList> createState() => _HistoryListState();
}

class _HistoryListState extends State<HistoryList> {
  final dateFormat = DateFormat("dd. MMM yyyy HH:mm");
  final _historyStream = FirebaseFirestore.instance
      .collection('donations')
      .where("user", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .snapshots()
      .map((snapshot) => snapshot.docs);

  String _searchQuery = "";

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<QueryDocumentSnapshot<Map<String, dynamic>>>>(
      stream: _historyStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print("Error: ${snapshot.error}");
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final history =
            snapshot.data!.where((d) => (d["event_name"]).toLowerCase().contains(_searchQuery.toLowerCase())).toList();
        history.sort((d1, d2) => (d2["date"] as Timestamp).compareTo(d1["date"] as Timestamp));

        final double sum = history.map((d) => d["amount"] as double).reduce((value, element) => value + element);

        return Column(children: [
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Gespendeter Gesamtbetrag: $sum€", style: CustomTextSize.medium)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: const InputDecoration(
                hintText: 'Suchen',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
              child: ListView.builder(
            itemCount: history.length,
            itemBuilder: (context, index) {
              final donation = history.elementAt(index);
              final double amount = donation["amount"];
              final String eventName = donation["event_name"];
              final String date = dateFormat.format((donation["date"] as Timestamp).toDate());
              final String pdfUrl = donation["receipt_url"];
              return ListTile(
                title: Text("$amount€ Spende an $eventName"),
                subtitle: Text("Spendendatum: $date"),
                trailing: IconButton(
                    icon: const Icon(Icons.download),
                    onPressed: () async {
                      if (await canLaunchUrl(Uri.parse(pdfUrl))) {
                        await launchUrl(Uri.parse(pdfUrl));
                      }
                    }),
              );
            },
          ))
        ]);
      },
    );
  }
}
