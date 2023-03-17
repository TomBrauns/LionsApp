//Licensed under the EUPL v.1.2 or later
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lionsapp/Screens/events/event_details_page.dart';
import 'package:lionsapp/Widgets/appbar.dart';
import 'package:lionsapp/Widgets/bottomNavigationView.dart';
import 'package:lionsapp/Widgets/burgermenu.dart';
import 'package:lionsapp/Widgets/privileges.dart';
import 'package:lionsapp/util/color.dart';
import 'package:url_launcher/url_launcher.dart';

import '../util/textSize.dart';
import 'generateQR/generateqr.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final dateFormat = DateFormat("dd. MMM yyyy");
  late Stream<QuerySnapshot<Map<String, dynamic>>> _eventsStream;
  late String _searchQuery;

  // BAB with Privilege
  Widget? _getBAB() {
    if (Privileges.privilege == Privilege.admin ||
        Privileges.privilege == Privilege.member ||
        Privileges.privilege == Privilege.friend) {
      return BottomNavigation();
    } else {
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    _searchQuery = '';
    _eventsStream = FirebaseFirestore.instance
        .collection('events')
        .where('startDate', isGreaterThanOrEqualTo: DateTime.now())
        .orderBy('startDate', descending: false)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: "Startseite"),
      drawer: const BurgerMenu(),
      bottomNavigationBar: _getBAB(),
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(10, 5, 10, 0),
            height: 300,
            width: 300,
            child: TextButton(
                onPressed: () {
                  launchUrl(Uri.parse('https://lions-club-kl.de/'));
                },
                child: Image.asset("assets/appicon/lions.png",
                    fit: BoxFit.contain)),
          ),
          SizedBox(
            child: Container(
              child: TextButton(
                onPressed: () =>
                    launchUrl(Uri.parse('https://lions-club-kl.de/')),
                child: Text(
                  "Weitere Informationen zum Verein hier",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ),
          ),

          // Next Event:
          SizedBox(
            child: Container(
              margin: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child: Text(
                      "Nächstes Event:",
                      style: CustomTextSize.medium,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: new BorderRadius.circular(16.0),
                      color: ColorUtils.secondaryColor,
                    ),
                    child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                      stream: _eventsStream,
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                              snapshot) {
                        if (snapshot.hasError) {
                          return Center(
                            child: Text('Error: ${snapshot.error}'),
                          );
                        }

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        final List<QueryDocumentSnapshot<Map<String, dynamic>>>
                            eventsList = snapshot.data!.docs;
                        if (eventsList.isEmpty) {
                          return const Center(
                            child: Text('No events found.'),
                          );
                        }

                        final QueryDocumentSnapshot<Map<String, dynamic>>
                            newestEvent = eventsList.first;

                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    EventDetailsPage(eventId: newestEvent.id),
                              ),
                            );
                          },
                          child: Container(
                            child: Stack(
                              children: [
                                SizedBox(
                                  height: 128,
                                  width: double.infinity,
                                  child: Row(
                                    children: [
                                      if (newestEvent["image_url"] != null &&
                                          (newestEvent["image_url"] as String)
                                              .isNotEmpty)
                                        ClipRRect(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(16.0),
                                            bottomLeft: Radius.circular(16.0),
                                          ),
                                          child: Image.network(
                                            newestEvent["image_url"],
                                            width: 128,
                                            height: 128,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      else
                                        Container(
                                          width: 128,
                                          height: 128,
                                          color: Colors.grey,
                                        ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              newestEvent['eventName'],
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            if (newestEvent["eventInfo"] !=
                                                null)
                                              Text(
                                                newestEvent['eventInfo'],
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            Expanded(child: Container()),
                                            if (newestEvent["ort"] != null)
                                              Row(
                                                children: [
                                                  const Icon(Icons.location_on,
                                                      size: 16),
                                                  const SizedBox(width: 4),
                                                  Expanded(
                                                    child: Text(
                                                      newestEvent['ort'],
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            if (newestEvent["startDate"] !=
                                                null)
                                              Row(
                                                children: [
                                                  const Icon(
                                                      Icons.calendar_month,
                                                      size: 16),
                                                  const SizedBox(width: 4),
                                                  Expanded(
                                                    child: Text(
                                                      dateFormat.format(
                                                          (newestEvent[
                                                                      "startDate"]
                                                                  as Timestamp)
                                                              .toDate()),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            const SizedBox(height: 4),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Positioned(
                                  bottom: 4.0,
                                  right: 4.0,
                                  child: IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => QrCodeWithImage(
                                              link:
                                                  'serviceclub-app.de/#/Donations',
                                              documentId: newestEvent.id),
                                        ),
                                      );
                                    },
                                    icon: const Icon(Icons.qr_code),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          /*SizedBox(
            child: Center(
              child: Container(
                margin: EdgeInsets.all(20),
                child: Text(
                  "Moin Moin un Herzlich Willkamen op de Homepage vun de Lions Club Luthras in Kaiserslautern! Wi sünd en Gemeinschaft vun Lüüd, de sik för de Gemeenschap un de Minschen in unsere Regioun insetten. Wi freut uns, dat du uns hier besöökst un wünscht di veel Spaß un Informatiounen op disse Siet. Meld di gern, wenn du Frogen hest oder uns gern ünnerstütten wüllt. Wi wünscht di en goden Dag!",
                  style: CustomTextSize.small,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),*/
          SizedBox(
            child: Center(
              child: Container(
                margin: EdgeInsets.all(20),
                child: Text(
                  '„We serve.“',
                  style: CustomTextSize.large,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          SizedBox(
            child: Center(
              child: Container(
                margin: EdgeInsets.all(20),
                child: Text(
                  'Unter diesem Motto steht all unser Handeln, alle Projekte sind diesem großen Ziel verpflichtet, ob auf internationaler, nationaler oder lokaler Ebene.',
                  style: CustomTextSize.small,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
