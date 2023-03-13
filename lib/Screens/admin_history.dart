import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lionsapp/Widgets/appbar.dart';
import 'package:lionsapp/Widgets/textSize.dart';
import 'package:url_launcher/url_launcher.dart';

class AdminHistory extends StatefulWidget {
  const AdminHistory({Key? key}) : super(key: key);

  @override
  State<AdminHistory> createState() => _AdminHistoryState();
}

class _AdminHistoryState extends State<AdminHistory> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MyAppBar(title: "Gesamter Spendenverlauf"),
      body: HistoryList(),
    );
  }
}

class HistoryList extends StatefulWidget {
  const HistoryList({Key? key}) : super(key: key);

  @override
  State<HistoryList> createState() => _HistoryListState();
}

class _HistoryListState extends State<HistoryList> with SingleTickerProviderStateMixin {
  final dateFormat = DateFormat("dd. MMM yyyy HH:mm");
  final _donationsStream = FirebaseFirestore.instance
      .collection("donations")
      .orderBy("event_name")
      .snapshots()
      .map((snapshot) => snapshot.docs);
  final _userStream = FirebaseFirestore.instance.collection("users").snapshots().map((snapshot) => snapshot.docs);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<QueryDocumentSnapshot<Map<String, dynamic>>>>(
        stream: _donationsStream,
        builder: (context, donationsSnapshots) {
          return StreamBuilder<List<QueryDocumentSnapshot<Map<String, dynamic>>>>(
              stream: _userStream,
              builder: (context, userSnapshots) {
                if (donationsSnapshots.hasError || userSnapshots.hasError) {
                  return const Center(
                    child: Text('Error'),
                  );
                }
                if (donationsSnapshots.connectionState == ConnectionState.waiting ||
                    userSnapshots.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final eventIds = donationsSnapshots.data!.map((d) => d["event_id"] as String).toSet();
                return ListView.builder(
                    itemCount: eventIds.length,
                    itemBuilder: (context, index) {
                      final eventId = eventIds.elementAt(index);
                      final donations = donationsSnapshots.data!.where((d) => d["event_id"] == eventId).toList();
                      donations.sort((d1, d2) => (d1["date"] as Timestamp).compareTo(d2["date"] as Timestamp));
                      final eventName = donations.first["event_name"];
                      final double eventSum =
                          donations.map((d) => d["amount"]).reduce((value, element) => value + element);
                      return Column(children: [
                        ListTile(
                            title: Text(eventName, style: CustomTextSize.medium),
                            trailing: Text("${eventSum.toStringAsFixed(2)}€", style: CustomTextSize.medium)),
                        ListView.builder(
                            shrinkWrap: true,
                            physics: const ClampingScrollPhysics(),
                            itemCount: donations.length,
                            itemBuilder: (context, index) {
                              final donation = donations.elementAt(index);
                              final double amount = donation["amount"];
                              final String date = dateFormat.format((donation["date"] as Timestamp).toDate());
                              final String pdfUrl = donation["receipt_url"];
                              String? imageUrl;
                              String userName;
                              try {
                                final user = userSnapshots.data!.firstWhere((u) => u.id == donation["user"]);
                                imageUrl = user.data().containsKey("image_url") ? user["image_url"] : null;
                                userName = user["firstname"] + " " + user["lastname"];
                              } catch (e) {
                                imageUrl = null;
                                userName = "Unbekannt";
                              }
                              return ListTile(
                                leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: imageUrl != null
                                      ? Image.network(
                                          imageUrl,
                                          fit: BoxFit.cover,
                                          width: 40,
                                          height: 40,
                                        )
                                      : Container(color: Colors.grey, width: 40, height: 40),
                                ),
                                title: Text("${amount.toStringAsFixed(2)}€ von $userName"),
                                subtitle: Text("Spendendatum: $date"),
                                trailing: IconButton(
                                    icon: const Icon(Icons.download),
                                    onPressed: () async {
                                      if (await canLaunchUrl(Uri.parse(pdfUrl))) {
                                        await launchUrl(Uri.parse(pdfUrl));
                                      }
                                    }),
                              );
                            }),
                      ]);
                    });
              });
        });
  }
}
