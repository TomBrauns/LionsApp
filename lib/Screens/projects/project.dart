import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../donation.dart';


final TextStyle _headlineStyle =
const TextStyle(fontWeight: FontWeight.bold, fontSize: 18);
final TextStyle _textStyle = const TextStyle(fontSize: 16);


class Project extends StatelessWidget{
  final String documentId;

  Project({required this.documentId});

  @override
  Widget build(BuildContext context){
    print(documentId);

    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance.collection('projects').doc(documentId).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){
        if(snapshot.hasError){
          return Text('Fehler beim Lesen der Daten');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;

        final String _title = data['name'];
        final String _imgUri = "assets/projects/example_project.jpg";
        final String _background = data['background'];
        final String _support = data['support'];

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
                          Text("Hintergrund", style: _headlineStyle),
                          const SizedBox(height: 4),
                          Text(_background, style: _textStyle),
                          const SizedBox(height: 16),
                          Text("Unsere Unterstützung", style: _headlineStyle),
                          const SizedBox(height: 4),
                          Text(_support, style: _textStyle),
                          const SizedBox(height: 32),
                          Center(
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Donations(documentId: documentId)
                                  ));
                                },
                                child: const Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 6.0, horizontal: 4.0),
                                    child: Text("Spenden", style: TextStyle(fontSize: 22))),
                              )),
                          const SizedBox(height: 32),
                        ],
                      ))
                ])));

      },

    );

    final String _title = "Kinderkrebs in Afrika";
    final String _imgUri = "assets/projects/example_project.jpg";
    final String _background =
        "Fast 80% der an Krebs erkrankten Kinder leben in Ländern mit niedrigem oder mittlerem Einkommen, wovon lediglich 10% der Kinder den Krebs überleben. In entwickelten Ländern wie Kanada, Japan und den Vereinigten Staaten überleben mehr als 80% der an Krebs erkrankten Kinder. Die gute Nachricht ist, dass die Heilung krebskranker Kinder weltweit erfolgreicher verlaufen könnte. Es muss jedoch noch viel getan werden, um den Zugang zu Medikamenten und Behandlungen zu verbessern, medizinische Fachkräfte auszubilden, Einrichtungen und Technologien zu optimieren und soziokulturelle Barrieren abzubauen, um die Überlebensraten von Krebserkrankungen im Kindesalter weltweit anzuheben.";
    final String _support =
        "Global HOPE ist eine Transformationsinitiative, die 2017 ins Leben gerufen wurde und den Standard der Betreuung krebskranker Kinder verbessert. Im Mai 2019 genehmigte der LCIF-Treuhändervorstand eine zweijährige strategische Partnerschaft, um langfristige Kapazitäten aufzubauen, die krebs- und blutkranke Kinder in Botswana, Malawi und Uganda behandeln und ihre Prognose dramatisch verbessern können. Diese Partnerschaft trägt dazu bei, die lokale Gesundheitsinfrastruktur zu stärken, um die multidisziplinäre Versorgung zu gewährleisten, die für eine Betreuung von Kindern mit Krebs und Blutkrankheiten erforderlich ist.";





    return Scaffold(


    );
  }

}



/*class Project extends StatefulWidget {
  //const Project({Key? key}) : super(key: key);

  final String documentId;

  Project({required this.documentId});

  @override
  State<Project> createState() => _ProjectState();
}

class _ProjectState extends State<Project> {
  // TODO fetch this
  final String _title = "Kinderkrebs in Afrika";
  final String _imgUri = "assets/projects/example_project.jpg";
  final String _background =
      "Fast 80% der an Krebs erkrankten Kinder leben in Ländern mit niedrigem oder mittlerem Einkommen, wovon lediglich 10% der Kinder den Krebs überleben. In entwickelten Ländern wie Kanada, Japan und den Vereinigten Staaten überleben mehr als 80% der an Krebs erkrankten Kinder. Die gute Nachricht ist, dass die Heilung krebskranker Kinder weltweit erfolgreicher verlaufen könnte. Es muss jedoch noch viel getan werden, um den Zugang zu Medikamenten und Behandlungen zu verbessern, medizinische Fachkräfte auszubilden, Einrichtungen und Technologien zu optimieren und soziokulturelle Barrieren abzubauen, um die Überlebensraten von Krebserkrankungen im Kindesalter weltweit anzuheben.";
  final String _support =
      "Global HOPE ist eine Transformationsinitiative, die 2017 ins Leben gerufen wurde und den Standard der Betreuung krebskranker Kinder verbessert. Im Mai 2019 genehmigte der LCIF-Treuhändervorstand eine zweijährige strategische Partnerschaft, um langfristige Kapazitäten aufzubauen, die krebs- und blutkranke Kinder in Botswana, Malawi und Uganda behandeln und ihre Prognose dramatisch verbessern können. Diese Partnerschaft trägt dazu bei, die lokale Gesundheitsinfrastruktur zu stärken, um die multidisziplinäre Versorgung zu gewährleisten, die für eine Betreuung von Kindern mit Krebs und Blutkrankheiten erforderlich ist.";

  // Style
  final TextStyle _headlineStyle =
      const TextStyle(fontWeight: FontWeight.bold, fontSize: 18);
  final TextStyle _textStyle = const TextStyle(fontSize: 16);

  void _handleDonation() {
    // TODO implement
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_title),
        ),
        body: Scrollbar(
            thickness: 5.0,
            thumbVisibility: false,
            radius: const Radius.circular(360),
            child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Image.asset(_imgUri,
                      width: double.infinity, height: 250, fit: BoxFit.cover),
                  Container(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Hintergrund", style: _headlineStyle),
                          const SizedBox(height: 4),
                          Text(_background, style: _textStyle),
                          const SizedBox(height: 16),
                          Text("Unsere Unterstützung", style: _headlineStyle),
                          const SizedBox(height: 4),
                          Text(_support, style: _textStyle),
                          const SizedBox(height: 32),
                          Center(
                              child: ElevatedButton(
                            onPressed: _handleDonation,
                            child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 6.0, horizontal: 4.0),
                                child: Text("Spenden",
                                    style: TextStyle(fontSize: 22))),
                          )),
                          const SizedBox(height: 32),
                        ],
                      ))
                ]))));
  }
}*/
