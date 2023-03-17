//Licensed under the EUPL v.1.2 or later
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lionsapp/Widgets/appbar.dart';
import 'package:lionsapp/util/textSize.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:lionsapp/Widgets/privileges.dart';

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

class _HistoryListState extends State<HistoryList>
    with SingleTickerProviderStateMixin {
  final dateFormat = DateFormat("dd. MMM yyyy HH:mm");
  final _donationsStream = FirebaseFirestore.instance
      .collection("donations")
      .orderBy("name")
      .snapshots()
      .map((snapshot) => snapshot.docs);
  final _userStream = FirebaseFirestore.instance
      .collection("users")
      .snapshots()
      .map((snapshot) => snapshot.docs);
  String _searchQuery = "";

  @override
  Widget build(BuildContext context) {
    return Privileges.privilege == Privilege.admin
        ? Column(children: [
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
                    prefixIcon: Icon(Icons.search)),
              ),
            ),
            Expanded(
                child: StreamBuilder<
                        List<QueryDocumentSnapshot<Map<String, dynamic>>>>(
                    stream: _donationsStream,
                    builder: (context, donationsSnapshots) {
                      return StreamBuilder<
                              List<
                                  QueryDocumentSnapshot<Map<String, dynamic>>>>(
                          stream: _userStream,
                          builder: (context, userSnapshots) {
                            if (donationsSnapshots.hasError ||
                                userSnapshots.hasError) {
                              return const Center(
                                child: Text('Error'),
                              );
                            }
                            if (donationsSnapshots.connectionState ==
                                    ConnectionState.waiting ||
                                userSnapshots.connectionState ==
                                    ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            final ids = donationsSnapshots.data!
                                .where((d) => (d["name"] as String)
                                    .toLowerCase()
                                    .contains(_searchQuery.toLowerCase()))
                                .map((d) => d["id"] as String)
                                .toSet();

                            return ListView.builder(
                                itemCount: ids.length,
                                itemBuilder: (context, index) {
                                  final id = ids.elementAt(index);
                                  final donations = donationsSnapshots.data!
                                      .where((d) => d["id"] == id)
                                      .toList();
                                  donations.sort((d1, d2) =>
                                      (d1["date"] as Timestamp)
                                          .compareTo(d2["date"] as Timestamp));
                                  final name = donations.first["name"];
                                  final type =
                                      donations.first["type"] == "events"
                                          ? "Aktivität"
                                          : "Projekt";
                                  final double sum = donations
                                      .map((d) => d["amount"])
                                      .reduce(
                                          (value, element) => value + element);
                                  return Column(children: [
                                    ListTile(
                                        title: Text("$type '$name'",
                                            style: CustomTextSize.small),
                                        trailing: Text(
                                            "${sum.toStringAsFixed(2)}€",
                                            style: CustomTextSize.small)),
                                    ListView.builder(
                                        shrinkWrap: true,
                                        physics: const ClampingScrollPhysics(),
                                        itemCount: donations.length,
                                        itemBuilder: (context, index) {
                                          final donation =
                                              donations.elementAt(index);
                                          final double amount =
                                              donation["amount"];
                                          final String date = dateFormat.format(
                                              (donation["date"] as Timestamp)
                                                  .toDate());
                                          final String pdfUrl =
                                              donation["receipt_url"];
                                          String? imageUrl;
                                          String userName;
                                          try {
                                            final user = userSnapshots.data!
                                                .firstWhere((u) =>
                                                    u.id == donation["user"]);
                                            imageUrl = user
                                                    .data()
                                                    .containsKey("image_url")
                                                ? user["image_url"]
                                                : null;
                                            userName = user["firstname"] +
                                                " " +
                                                user["lastname"];
                                          } catch (e) {
                                            imageUrl = null;
                                            userName = "Unbekannt";
                                          }
                                          return ListTile(
                                            leading: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: imageUrl != null
                                                  ? Image.network(
                                                      imageUrl,
                                                      fit: BoxFit.cover,
                                                      width: 40,
                                                      height: 40,
                                                    )
                                                  : Container(
                                                      color: Colors.grey,
                                                      width: 40,
                                                      height: 40),
                                            ),
                                            title: Text(
                                                "${amount.toStringAsFixed(2)}€ von $userName"),
                                            subtitle:
                                                Text("Spendendatum: $date"),
                                            trailing: IconButton(
                                                icon:
                                                    const Icon(Icons.download),
                                                onPressed: () async {
                                                  if (await canLaunchUrl(
                                                      Uri.parse(pdfUrl))) {
                                                    await launchUrl(
                                                        Uri.parse(pdfUrl));
                                                  }
                                                }),
                                          );
                                        }),
                                  ]);
                                });
                          });
                    }))
          ])
        : Center(
            child: Column(children: [
            Padding(padding: EdgeInsets.fromLTRB(0, 250, 0, 0)),
            Text('ERROR: 403', style: CustomTextSize.large),
            Padding(padding: EdgeInsets.fromLTRB(0, 50, 0, 0)),
            Text('nicht die benötigten Berechtigungen vorhanden',
                style: CustomTextSize.medium),
            Padding(padding: EdgeInsets.fromLTRB(0, 50, 0, 0)),
            Image.asset(
              "assets/images/gandalf.gif",
            ),
            Padding(padding: EdgeInsets.fromLTRB(0, 50, 0, 0)),
            Text('You shall not pass!', style: CustomTextSize.large),
          ]));
  }
}
