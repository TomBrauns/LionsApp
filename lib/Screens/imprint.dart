import 'package:flutter/material.dart';

import 'package:lionsapp/Widgets/burgermenu.dart';

class Imprint extends StatefulWidget {
  const Imprint({Key? key}) : super(key: key);

  @override
  State<Imprint> createState() => _ImprintState();
}

class _ImprintState extends State<Imprint> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const BurgerMenu(),
      appBar: AppBar(
        title: const Text("Impressum"),
      ),
      body: Scrollbar(
          thickness: 5.0,
          thumbVisibility: false,
          radius: const Radius.circular(360),
          child: ListView(padding: const EdgeInsets.all(15), children: const <
              Widget>[
            ImprintMainHeadlineTextS("Support"),
            ImprintTextS(
                """Bei Fragen oder Problemem sprechen Sie uns bitte einfach an oder kontaktieren Sie uns unter: """),
            ImprintTextS('online-spende@kaiserlions-hilfe.de', underline: true),
            ImprintMainHeadlineText("Impressum"),
            ImprintHeadlineText("Diensteanbieter"),
            ImprintText("""KaiserLions e.V. 
Am Nabenberg 6 
67705 Trippstadt 
Deutschland"""),
            ImprintHeadlineText("Kontaktmöglichkeiten"),
            ImprintText("""E-Mail-Adresse: vorstand@kaiserlions-hilfe.de
Telefon: 0160-99670846"""),
            ImprintHeadlineText("Vertretungsberechtigte Personen"),
            ImprintText("""Vertretungsberechtigt: Maria Spang"""),
            ImprintHeadlineText("Journalistisch-redaktionelle Angebote"),
            ImprintText("""Inhaltlich verantwortlich: (Adresse wie oben)"""),
            ImprintHeadlineText("Register und Registernummer"),
            ImprintText("""Vereinsregister
Geführt bei: Amtsgericht Kaiserslautern
Nummer: VR 30464
"""),
            ImprintHeadlineText("Haftungs- und Schutzrechtshinweise"),
            ImprintText(
                """Haftungsausschluss: Die Inhalte dieses Onlineangebotes wurden sorgfältig und nach unserem aktuellen Kenntnisstand erstellt, dienen jedoch nur der Information und entfalten keine rechtlich bindende Wirkung, sofern es sich nicht um gesetzlich verpflichtende Informationen (z.B. das Impressum, die Datenschutzerklärung, AGB oder verpflichtende Belehrungen von Verbrauchern) handelt. Wir behalten uns vor, die Inhalte vollständig oder teilweise zu ändern oder zu löschen, soweit vertragliche Verpflichtungen unberührt bleiben. Alle Angebote sind freibleibend und unverbindlich.
"""),
            ImprintText(
                """Urheberrechte und Markenrechte: Alle auf dieser Website dargestellten Inhalte, wie Texte, Fotografien, Grafiken, Marken und Warenzeichen sind durch die jeweiligen Schutzrechte (Urheberrechte, Markenrechte) geschützt. Die Verwendung, Vervielfältigung usw. unterliegen unseren Rechten oder den Rechten der jeweiligen Urheber bzw. Rechteinhaber."""),
            ImprintHeadlineText("Bildnachweise"),
            ImprintText("""Bildquellen und Urheberrechtshinweise:
Animation "Butterfly hearts" von Jacques Mauriac (https://lottiefiles.com/jojolafrite)
"""),
            ImprintMainHeadlineText("Datenschutzerklärung"),
            ImprintHeadlineText("Einleitung"),
            ImprintText(
                """Mit der folgenden Datenschutzerklärung möchten wir Sie darüber aufklären, welche Arten Ihrer personenbezogenen Daten (nachfolgend auch kurz als "Daten“ bezeichnet) wir zu welchen Zwecken und in welchem Umfang im Rahmen der Bereitstellung unserer Applikation verarbeiten.

Die verwendeten Begriffe sind nicht geschlechtsspezifisch.

Stand: 14. Juli 2022
"""),
            ImprintHeadlineText("Verantwortlicher"),
            ImprintText("""KaiserLions e.V.
Am Nabenberg 6
67705 Trippstadt
Deutschland

Vertretungsberechtigte Personen: Maria Spang

E-Mail-Adresse: vorstand@kaiserlions-hilfe.de
Telefon: 0160-99670846

Impressum: spende.kaiserlions-hilfe.de/impressum
"""),
            ImprintHeadlineText("Übersicht der Verarbeitungen"),
            ImprintText(
                """Die nachfolgende Übersicht fasst die Arten der verarbeiteten Daten und die Zwecke ihrer Verarbeitung zusammen und verweist auf die betroffenen Personen.

Arten der verarbeiteten Daten:
- Bestandsdaten
- Zahlungsdaten
- Kontaktdaten
- Nutzungsdaten
- Meta-/Kommunikationsdaten

Kategorien betroffener Personen
- Spender / Unterstützer
- Mitglieder
- Kommunikationspartner
- Nutzer
- Mitglieder

Zwecke der Verarbeitung
- Spendenabwicklung
- Kundenservice, Kontaktanfragen und Kommunikation
- Direktmarketing
- Reichweitenmessung
- Tracking
- Verwaltung und Beantwortung von Anfragen
- Marketing
- Profile mit nutzerbezogenen Informationen
- Anmeldeverfahren
- Bereitstellung unseres Onlineangebotes und Nutzerfreundlichkeit
- Informationstechnische Infrastruktur
"""),
            ImprintHeadlineText("Maßgebliche Rechtsgrundlagen"),
            ImprintText(
                """Im Folgenden erhalten Sie eine Übersicht der Rechtsgrundlagen der DSGVO, auf deren Basis wir personenbezogene Daten verarbeiten. Bitte nehmen Sie zur Kenntnis, dass neben den Regelungen der DSGVO nationale Datenschutzvorgaben in Ihrem bzw. unserem Wohn- oder Sitzland gelten können. Sollten ferner im Einzelfall speziellere Rechtsgrundlagen maßgeblich sein, teilen wir Ihnen diese in der Datenschutzerklärung mit."""),
            ImprintText(
                """Einwilligung (Art. 6 Abs. 1 S. 1 lit. a. DSGVO) - Die betroffene Person hat ihre Einwilligung in die Verarbeitung der sie betreffenden personenbezogenen Daten für einen spezifischen Zweck oder mehrere bestimmte Zwecke gegeben."""),
            ImprintText(
                """Vertragserfüllung und vorvertragliche Anfragen (Art. 6 Abs. 1 S. 1 lit. b. DSGVO) - Die Verarbeitung ist für die Erfüllung eines Vertrags, dessen Vertragspartei die betroffene Person ist, oder zur Durchführung vorvertraglicher Maßnahmen erforderlich, die auf Anfrage der betroffenen Person erfolgen."""),
            ImprintText(
                """Berechtigte Interessen (Art. 6 Abs. 1 S. 1 lit. f. DSGVO) - Die Verarbeitung ist zur Wahrung der berechtigten Interessen des Verantwortlichen oder eines Dritten erforderlich, sofern nicht die Interessen oder Grundrechte und Grundfreiheiten der betroffenen Person, die den Schutz personenbezogener Daten erfordern, überwiegen."""),
            ImprintText(
                """Zusätzlich zu den Datenschutzregelungen der Datenschutz-Grundverordnung gelten nationale Regelungen zum Datenschutz in Deutschland. Hierzu gehört insbesondere das Gesetz zum Schutz vor Missbrauch personenbezogener Daten bei der Datenverarbeitung (Bundesdatenschutzgesetz – BDSG). Das BDSG enthält insbesondere Spezialregelungen zum Recht auf Auskunft, zum Recht auf Löschung, zum Widerspruchsrecht, zur Verarbeitung besonderer Kategorien personenbezogener Daten, zur Verarbeitung für andere Zwecke und zur Übermittlung sowie automatisierten Entscheidungsfindung im Einzelfall einschließlich Profiling. Des Weiteren regelt es die Datenverarbeitung für Zwecke des Beschäftigungsverhältnisses (§ 26 BDSG), insbesondere im Hinblick auf die Begründung, Durchführung oder Beendigung von Beschäftigungsverhältnissen sowie die Einwilligung von Beschäftigten. Ferner können Landesdatenschutzgesetze der einzelnen Bundesländer zur Anwendung gelangen."""),
            ImprintHeadlineText("Sicherheitsmaßnahmen"),
            ImprintText(
                """Wir treffen nach Maßgabe der gesetzlichen Vorgaben unter Berücksichtigung des Stands der Technik, der Implementierungskosten und der Art, des Umfangs, der Umstände und der Zwecke der Verarbeitung sowie der unterschiedlichen Eintrittswahrscheinlichkeiten und des Ausmaßes der Bedrohung der Rechte und Freiheiten natürlicher Personen geeignete technische und organisatorische Maßnahmen, um ein dem Risiko angemessenes Schutzniveau zu gewährleisten.
  
Zu den Maßnahmen gehören insbesondere die Sicherung der Vertraulichkeit, Integrität und Verfügbarkeit von Daten durch Kontrolle des physischen und elektronischen Zugangs zu den Daten als auch des sie betreffenden Zugriffs, der Eingabe, der Weitergabe, der Sicherung der Verfügbarkeit und ihrer Trennung. Des Weiteren haben wir Verfahren eingerichtet, die eine Wahrnehmung von Betroffenenrechten, die Löschung von Daten und Reaktionen auf die Gefährdung der Daten gewährleisten. Ferner berücksichtigen wir den Schutz personenbezogener Daten bereits bei der Entwicklung bzw. Auswahl von Hardware, Software sowie Verfahren entsprechend dem Prinzip des Datenschutzes, durch Technikgestaltung und durch datenschutzfreundliche Voreinstellungen.

SSL-Verschlüsselung (https): Um Ihre via unserem Online-Angebot übermittelten Daten zu schützen, nutzen wir eine SSL-Verschlüsselung. Sie erkennen derart verschlüsselte Verbindungen an dem Präfix https:// in der Adresszeile Ihres Browsers."""),
            ImprintHeadlineText("Übermittlung von personenbezogenen Daten"),
            ImprintText(
                """Im Rahmen unserer Verarbeitung von personenbezogenen Daten kommt es vor, dass die Daten an andere Stellen, Unternehmen, rechtlich selbstständige Organisationseinheiten oder Personen übermittelt oder sie ihnen gegenüber offengelegt werden. Zu den Empfängern dieser Daten können z.B. mit IT-Aufgaben beauftragte Dienstleister oder Anbieter von Diensten und Inhalten, die in eine Webseite eingebunden werden, gehören. In solchen Fall beachten wir die gesetzlichen Vorgaben und schließen insbesondere entsprechende Verträge bzw. Vereinbarungen, die dem Schutz Ihrer Daten dienen, mit den Empfängern Ihrer Daten ab."""),
            ImprintHeadlineText("Datenverarbeitung in Drittländern"),
            ImprintText(
                """Sofern wir Daten in einem Drittland (d.h., außerhalb der Europäischen Union (EU), des Europäischen Wirtschaftsraums (EWR)) verarbeiten oder die Verarbeitung im Rahmen der Inanspruchnahme von Diensten Dritter oder der Offenlegung bzw. Übermittlung von Daten an andere Personen, Stellen oder Unternehmen stattfindet, erfolgt dies nur im Einklang mit den gesetzlichen Vorgaben.

Vorbehaltlich ausdrücklicher Einwilligung oder vertraglich oder gesetzlich erforderlicher Übermittlung verarbeiten oder lassen wir die Daten nur in Drittländern mit einem anerkannten Datenschutzniveau, vertraglichen Verpflichtung durch sogenannte Standardschutzklauseln der EU-Kommission, beim Vorliegen von Zertifizierungen oder verbindlicher internen Datenschutzvorschriften verarbeiten (Art. 44 bis 49 DSGVO, Informationsseite der EU-Kommission: https://ec.europa.eu/info/law/law-topic/data-protection/international-dimension-data -protection_de)."""),
            ImprintHeadlineText("Löschung von Daten"),
            ImprintText(
                """Die von uns verarbeiteten Daten werden nach Maßgabe der gesetzlichen Vorgaben gelöscht, sobald deren zur Verarbeitung erlaubten Einwilligungen widerrufen werden oder sonstige Erlaubnisse entfallen (z.B. wenn der Zweck der Verarbeitung dieser Daten entfallen ist oder sie für den Zweck nicht erforderlich sind). Sofern die Daten nicht gelöscht werden, weil sie für andere und gesetzlich zulässige Zwecke erforderlich sind, wird deren Verarbeitung auf diese Zwecke beschränkt. D.h., die Daten werden gesperrt und nicht für andere Zwecke verarbeitet. Das gilt z.B. für Daten, die aus handels- oder steuerrechtlichen Gründen aufbewahrt werden müssen oder deren Speicherung zur Geltendmachung, Ausübung oder Verteidigung von Rechtsansprüchen oder zum Schutz der Rechte einer anderen natürlichen oder juristischen Person erforderlich ist.

Im Rahmen unserer Datenschutzhinweise können wir den Nutzern weitere Informationen zu der Löschung sowie zu der Aufbewahrung von Daten mitteilen, die speziell für die jeweiligen Verarbeitungsprozesses gelten."""),
            ImprintHeadlineText("Einsatz von Cookies"),
            ImprintText(
                """Cookies sind kleine Textdateien, bzw. sonstige Speichervermerke, die Informationen auf Endgeräten speichern und Informationen aus den Endgeräten auslesen. Z.B. um den Login-Status in einem Nutzerkonto, einen Warenkorbinhalt in einem E-Shop, die aufgerufenen Inhalte oder verwendete Funktionen eines Onlineangebotes speichern. Cookies können ferner zu unterschiedlichen Zwecken eingesetzt werden, z.B. zu Zwecken der Funktionsfähigkeit, Sicherheit und Komfort von Onlineangeboten sowie der Erstellung von Analysen der Besucherströme.

Hinweise zur Einwilligung: Wir setzen Cookies im Einklang mit den gesetzlichen Vorschriften ein. Daher holen wir von den Nutzern eine vorhergehende Einwilligung ein, außer wenn diese gesetzlich nicht gefordert ist. Eine Einwilligung ist insbesondere nicht notwendig, wenn das Speichern und das Auslesen der Informationen, also auch von Cookies, unbedingt erforderlich sind, um dem den Nutzern einen von ihnen ausdrücklich gewünschten Telemediendienst (also unser Onlineangebot) zur Verfügung zu stellen. Die widerrufliche Einwilligung wird gegenüber den Nutzern deutlich kommuniziert und enthält die Informationen zu der jeweiligen Cookie-Nutzung.

Hinweise zu datenschutzrechtlichen Rechtsgrundlagen: Auf welcher datenschutzrechtlichen Rechtsgrundlage wir die personenbezogenen Daten der Nutzer mit Hilfe von Cookies verarbeiten, hängt davon ab, ob wir Nutzer um eine Einwilligung bitten. Falls die Nutzer einwilligen, ist die Rechtsgrundlage der Verarbeitung Ihrer Daten die erklärte Einwilligung. Andernfalls werden die mithilfe von Cookies verarbeiteten Daten auf Grundlage unserer berechtigten Interessen (z.B. an einem betriebswirtschaftlichen Betrieb unseres Onlineangebotes und Verbesserung seiner Nutzbarkeit) verarbeitet oder, wenn dies im Rahmen der Erfüllung unserer vertraglichen Pflichten erfolgt, wenn der Einsatz von Cookies erforderlich ist, um unsere vertraglichen Verpflichtungen zu erfüllen. Zu welchen Zwecken die Cookies von uns verarbeitet werden, darüber klären wir im Laufe dieser Datenschutzerklärung oder im Rahmen von unseren Einwilligungs- und Verarbeitungsprozessen auf.

Speicherdauer: Im Hinblick auf die Speicherdauer werden die folgenden Arten von Cookies unterschieden:

- Temporäre Cookies (auch: Session- oder Sitzungs-Cookies): Temporäre Cookies werden spätestens gelöscht, nachdem ein Nutzer ein Online-Angebot verlassen und sein Endgerät (z.B. Browser oder mobile Applikation) geschlossen hat.

- Permanente Cookies: Permanente Cookies bleiben auch nach dem Schließen des Endgerätes gespeichert. So können beispielsweise der Login- Status gespeichert oder bevorzugte Inhalte direkt angezeigt werden, wenn der Nutzer eine Website erneut besucht. Ebenso können die mit Hilfe von Cookies erhobenen Daten der Nutzer zur Reichweitenmessung verwendet werden. Sofern wir Nutzern keine expliziten Angaben zur Art und Speicherdauer von Cookies mitteilen (z. B. im Rahmen der Einholung der Einwilligung), sollten Nutzer davon ausgehen, dass Cookies permanent sind und die Speicherdauer bis zu zwei Jahre betragen kann.

Allgemeine Hinweise zum Widerruf und Widerspruch (Opt-Out): Nutzer können die von ihnen abgegebenen Einwilligungen jederzeit widerrufen und zudem einen Widerspruch gegen die Verarbeitung entsprechend den gesetzlichen Vorgaben im Art. 21 DSGVO einlegen. Nutzer können ihren Widerspruch auch über die Einstellungen ihres Browsers erklären, z.B. durch Deaktivierung der Verwendung von Cookies (wobei dadurch auch die Funktionalität unserer Online- Dienste eingeschränkt sein kann). Ein Widerspruch gegen die Verwendung von Cookies zu Online-Marketing-Zwecken kann auch über die Websites https://optout.aboutads.info und https://www.youronlinechoices.com/ erklärt werden.

Weitere Hinweise zu Verarbeitungsprozessen, Verfahren und Diensten:

Verarbeitung von Cookie-Daten auf Grundlage einer Einwilligung: Wir setzen ein Verfahren zum Cookie-Einwilligungs-Management ein, in dessen Rahmen die Einwilligungen der Nutzer in den Einsatz von Cookies, bzw. der im Rahmen des Cookie-Einwilligungs-Management-Verfahrens genannten Verarbeitungen und Anbieter eingeholt sowie von den Nutzern verwaltet und widerrufen werden können. Hierbei wird die Einwilligungserklärung gespeichert, um deren Abfrage nicht erneut wiederholen zu müssen und die Einwilligung entsprechend der gesetzlichen Verpflichtung nachweisen zu können. Die Speicherung kann serverseitig und/oder in einem Cookie (sogenanntes Opt-In-Cookie, bzw. mithilfe vergleichbarer Technologien) erfolgen, um die Einwilligung einem Nutzer, bzw. dessen Gerät zuordnen zu können. Vorbehaltlich individueller Angaben zu den Anbietern von Cookie- Management-Diensten, gelten die folgenden Hinweise: Die Dauer der Speicherung der Einwilligung kann bis zu zwei Jahren betragen. Hierbei wird ein pseudonymer Nutzer-Identifikator gebildet und mit dem Zeitpunkt der Einwilligung, Angaben zur Reichweite der Einwilligung (z. B. welche Kategorien von Cookies und/oder Diensteanbieter) sowie dem Browser, System und verwendeten Endgerät gespeichert."""),
            ImprintHeadlineText(
                "Wahrnehmung von Aufgaben nach Satzung oder Geschäftsordnung"),
            ImprintText(
                """Wir verarbeiten die Daten unserer Mitglieder, Unterstützer, Interessenten, Geschäftspartner oder sonstiger Personen (Zusammenfassend "Betroffene"), wenn wir mit ihnen in einem Mitgliedschafts- oder sonstigem geschäftlichen Verhältnis stehen und unsere Aufgaben wahrnehmen sowie Empfänger von Leistungen und Zuwendungen sind. Im Übrigen verarbeiten wir die Daten Betroffener auf Grundlage unserer berechtigten Interessen, z.B. wenn es sich um administrative Aufgaben oder Öffentlichkeitsarbeit handelt.

Die hierbei verarbeiteten Daten, die Art, der Umfang und der Zweck und die Erforderlichkeit ihrer Verarbeitung, bestimmen sich nach dem zugrundeliegenden Mitgliedschafts- oder Vertragsverhältnis, aus dem sich auch die Erforderlichkeit etwaiger Datenangaben ergeben (im Übrigen weisen wir auf erforderliche Daten hin).

Wir löschen Daten, die zur Erbringung unserer satzungs- und geschäftsmäßigen Zwecke nicht mehr erforderlich sind. Dies bestimmt sich entsprechend der jeweiligen Aufgaben und vertraglichen Beziehungen. Wir bewahren die Daten so lange auf, wie sie zur Geschäftsabwicklung, als auch im Hinblick auf etwaige Gewährleistungs- oder Haftungspflichten auf Grundlage unserer berechtigten

Interesse an deren Regelung relevant sein können. Die Erforderlichkeit der Aufbewahrung der Daten wird regelmäßig überprüft; im Übrigen gelten die gesetzlichen Aufbewahrungspflichten.

- Verarbeitete Datenarten: Bestandsdaten (z.B. Namen, Adressen); Zahlungsdaten (z.B. Bankverbindungen, Rechnungen, Zahlungshistorie); Kontaktdaten (z.B. E-Mail, Telefonnummern); Vertragsdaten (z.B. Vertragsgegenstand, Laufzeit, Kundenkategorie).

- Betroffene Personen: Nutzer (z.B. Webseitenbesucher, Nutzer von Onlinediensten); Mitglieder; Geschäfts- und Vertragspartner.

- Zwecke der Verarbeitung: Erbringung vertraglicher Leistungen und Kundenservice; Kontaktanfragen und Kommunikation; Verwaltung und Beantwortung von Anfragen.

- Rechtsgrundlagen: Vertragserfüllung und vorvertragliche Anfragen (Art. 6 Abs. 1 S. 1 lit. b. DSGVO); Berechtigte Interessen (Art. 6 Abs. 1 S. 1 lit. f. DSGVO)."""),
            ImprintHeadlineText("Zahlungsverfahren"),
            ImprintText(
                """Im Rahmen von Vertrags- und sonstigen Rechtsbeziehungen, aufgrund gesetzlicher Pflichten oder sonst auf Grundlage unserer berechtigten Interessen bieten wir den betroffenen Personen effiziente und sichere Zahlungsmöglichkeiten an und setzen hierzu neben Banken und Kreditinstituten weitere Dienstleister ein (zusammenfassend "Zahlungsdienstleister").

Zu den durch die Zahlungsdienstleister verarbeiteten Daten gehören Bestandsdaten, wie z.B. der Name und die Adresse, Bankdaten, wie z.B. Kontonummern oder Kreditkartennummern, Passwörter, TANs und Prüfsummen sowie die Vertrags-, Summen- und empfängerbezogenen Angaben. Die Angaben sind erforderlich, um die Transaktionen durchzuführen. Die eingegebenen Daten werden jedoch nur durch die Zahlungsdienstleister verarbeitet und bei diesen gespeichert. D.h., wir erhalten keine konto- oder kreditkartenbezogenen Informationen, sondern lediglich Informationen mit Bestätigung oder Negativbeauskunftung der Zahlung. Unter Umständen werden die Daten seitens der Zahlungsdienstleister an Wirtschaftsauskunfteien übermittelt. Diese Übermittlung bezweckt die Identitäts- und Bonitätsprüfung. Hierzu verweisen wir auf die AGB und die Datenschutzhinweise der Zahlungsdienstleister.

Für die Zahlungsgeschäfte gelten die Geschäftsbedingungen und die Datenschutzhinweise der jeweiligen Zahlungsdienstleister, welche innerhalb der jeweiligen Webseiten bzw. Transaktionsapplikationen abrufbar sind. Wir verweisen auf diese ebenfalls zwecks weiterer Informationen und Geltendmachung von

Widerrufs-, Auskunfts- und anderen Betroffenenrechten.

- Verarbeitete Datenarten: Bestandsdaten (z.B. Namen, Adressen); Zahlungsdaten (z.B. Bankverbindungen, Rechnungen, Zahlungshistorie); Vertragsdaten (z.B. Vertragsgegenstand, Laufzeit, Kundenkategorie); Nutzungsdaten (z.B. besuchte Webseiten, Interesse an Inhalten, Zugriffszeiten); Meta-/Kommunikationsdaten (z.B. Geräte-Informationen, IP- Adressen).

- Betroffene Personen: Kunden; Interessenten.

- Zwecke der Verarbeitung: Erbringung vertraglicher Leistungen und
Kundenservice.

- Rechtsgrundlagen: Vertragserfüllung und vorvertragliche Anfragen (Art. 6 Abs. 1 S. 1 lit. b. DSGVO).

Weitere Hinweise zu Verarbeitungsprozessen, Verfahren und Diensten:

- Stripe: Zahlungsdienstleistungen (technische Anbindung von Online- Bezahlmethoden); Dienstanbieter: Stripe, Inc., 510 Townsend Street, San Francisco, CA 94103, USA; Rechtsgrundlagen: Vertragserfüllung und vorvertragliche Anfragen (Art. 6 Abs. 1 S. 1 lit. b. DSGVO); Website: https://stripe.com; Datenschutzerklärung: https://stripe.com/de/privacy."""),
            ImprintHeadlineText(
                "Bereitstellung des Onlineangebotes und Webhosting"),
            ImprintText(
                """Um unser Onlineangebot sicher und effizient bereitstellen zu können, nehmen wir die Leistungen von einem oder mehreren Webhosting-Anbietern in Anspruch, von deren Servern (bzw. von ihnen verwalteten Servern) das Onlineangebot abgerufen werden kann. Zu diesen Zwecken können wir Infrastruktur- und Plattformdienstleistungen, Rechenkapazität, Speicherplatz und Datenbankdienste sowie Sicherheitsleistungen und technische Wartungsleistungen in Anspruch nehmen.

Zu den im Rahmen der Bereitstellung des Hostingangebotes verarbeiteten Daten können alle die Nutzer unseres Onlineangebotes betreffenden Angaben gehören, die im Rahmen der Nutzung und der Kommunikation anfallen. Hierzu gehören regelmäßig die IP-Adresse, die notwendig ist, um die Inhalte von Onlineangeboten an Browser ausliefern zu können, und alle innerhalb unseres Onlineangebotes oder von Webseiten getätigten Eingaben.

- Verarbeitete Datenarten: Inhaltsdaten (z.B. Eingaben in Onlineformularen);

- Nutzungsdaten (z.B. besuchte Webseiten, Interesse an Inhalten, Zugriffszeiten); Meta-/Kommunikationsdaten (z.B. Geräte-Informationen, IP- Adressen).

- Betroffene Personen: Nutzer (z.B. Webseitenbesucher, Nutzer von Onlinediensten); Geschäfts- und Vertragspartner.

- Zwecke der Verarbeitung: Bereitstellung unseres Onlineangebotes und Nutzerfreundlichkeit; Informationstechnische Infrastruktur (Betrieb und Bereitstellung von Informationssystemen und technischen Geräten (Computer, Server etc.).).

- Rechtsgrundlagen: Berechtigte Interessen (Art. 6 Abs. 1 S. 1 lit. f. DSGVO); Einwilligung (Art. 6 Abs. 1 S. 1 lit. a. DSGVO).

Weitere Hinweise zu Verarbeitungsprozessen, Verfahren und Diensten:

- E-Mail-Versand und -Hosting: Die von uns in Anspruch genommenen Webhosting-Leistungen umfassen ebenfalls den Versand, den Empfang sowie die Speicherung von E-Mails. Zu diesen Zwecken werden die Adressen der Empfänger sowie Absender als auch weitere Informationen betreffend den E- Mailversand (z.B. die beteiligten Provider) sowie die Inhalte der jeweiligen E- Mails verarbeitet. Die vorgenannten Daten können ferner zu Zwecken der Erkennung von SPAM verarbeitet werden. Wir bitten darum, zu beachten, dass E-Mails im Internet grundsätzlich nicht verschlüsselt versendet werden. Im Regelfall werden E-Mails zwar auf dem Transportweg verschlüsselt, aber (sofern kein sogenanntes Ende-zu-Ende-Verschlüsselungsverfahren eingesetzt wird) nicht auf den Servern, von denen sie abgesendet und empfangen werden. Wir können daher für den Übertragungsweg der E-Mails zwischen dem Absender und dem Empfang auf unserem Server keine Verantwortung übernehmen; Rechtsgrundlagen: Berechtigte Interessen (Art. 6 Abs. 1 S. 1 lit. f. DSGVO).

- Erhebung von Zugriffsdaten und Logfiles: Wir selbst (bzw. unser Webhostinganbieter) erheben Daten zu jedem Zugriff auf den Server (sogenannte Serverlogfiles). Zu den Serverlogfiles können die Adresse und Name der abgerufenen Webseiten und Dateien, Datum und Uhrzeit des Abrufs, übertragene Datenmengen, Meldung über erfolgreichen Abruf, Browsertyp nebst Version, das Betriebssystem des Nutzers, Referrer URL (die zuvor besuchte Seite) und im Regelfall IP-Adressen und der anfragende Provider gehören. Die Serverlogfiles können zum einen zu Zwecken der Sicherheit eingesetzt werden, z.B., um eine Überlastung der Server zu vermeiden (insbesondere im Fall von missbräuchlichen Angriffen, sogenannten DDoS-Attacken) und zum anderen, um die Auslastung der Server und ihre Stabilität sicherzustellen; Rechtsgrundlagen: Berechtigte Interessen (Art. 6 Abs. 1 S. 1 lit. f. DSGVO); Löschung von Daten: Logfile- Informationen werden für die Dauer von maximal 30 Tagen gespeichert und danach gelöscht oder anonymisiert. Daten, deren weitere Aufbewahrung zu Beweiszwecken erforderlich ist, sind bis zur endgültigen Klärung des jeweiligen Vorfalls von der Löschung ausgenommen.

- Content-Delivery-Network: Wir setzen ein "Content-Delivery-Network" (CDN) ein. Ein CDN ist ein Dienst, mit dessen Hilfe Inhalte eines Onlineangebotes, insbesondere große Mediendateien, wie Grafiken oder Programm-Skripte, mit Hilfe regional verteilter und über das Internet verbundener Server schneller und sicherer ausgeliefert werden können; Rechtsgrundlagen: Berechtigte Interessen (Art. 6 Abs. 1 S. 1 lit. f. DSGVO).

- Amazon Web Services (AWS): Leistungen auf dem Gebiet der Bereitstellung von informationstechnischer Infrastruktur und verbundenen Dienstleistungen (z.B. Speicherplatz und/oder Rechenkapazitäten); Dienstanbieter: Amazon Web Services EMEA SARL, 38 avenue John F. Kennedy, L-1855, Luxemburg; Rechtsgrundlagen: Berechtigte Interessen (Art. 6 Abs. 1 S. 1 lit. f. DSGVO); Website: https://aws.amazon.com/de/; Datenschutzerklärung: https://aws.amazon.com/de/privacy/; Auftragsverarbeitungsvertrag: https://aws.amazon.com/de/compliance/gdpr-center/; Standardvertragsklauseln (Gewährleistung Datenschutzniveau bei Verarbeitung in Drittländern): Einbeziehung im Auftragsverarbeitungsvertrag.

- Firebase: Dienstanbieter: Google Ireland Limited, Gordon House, Barrow Street, Dublin 4, Irland, Mutterunternehmen: Google LLC, 1600 Amphitheatre Parkway, Mountain View, CA 94043, USA; Rechtsgrundlagen: Einwilligung (Art. 6 Abs. 1 S. 1 lit. a. DSGVO); Website: https://firebase.google.com; Datenschutzerklärung: https://policies.google.com/privacy; Standardvertragsklauseln (Gewährleistung Datenschutzniveau bei Verarbeitung in Drittländern): https://firebase.google.com/terms/data-processing-terms."""),
            ImprintHeadlineText("Besondere Hinweise zu Applikationen (Apps)"),
            ImprintText(
                """Wir verarbeiten die Daten der Nutzer unserer Applikation, soweit diese erforderlich sind, um den Nutzern die Applikation sowie deren Funktionalitäten bereitstellen, deren Sicherheit überwachen und sie weiterentwickeln zu können. Wir können ferner Nutzer unter Beachtung der gesetzlichen Vorgaben kontaktieren, sofern die Kommunikation zu Zwecken der Administration oder Nutzung der Applikation erforderlich ist. Im Übrigen verweisen wir im Hinblick auf die Verarbeitung der Daten der Nutzer auf die Datenschutzhinweise in dieser Datenschutzerklärung.

Rechtsgrundlagen: Die Verarbeitung von Daten, die für die Bereitstellung der Funktionalitäten der Applikation erforderlich ist, dient der Erfüllung von vertraglichen Pflichten. Dies gilt auch, wenn die Bereitstellung der Funktionen eine Berechtigung der Nutzer (z. B. Freigaben von Gerätefunktionen) voraussetzt. Sofern die Verarbeitung von Daten für die Bereitstellung der Funktionalitäten der Applikation nicht erforderlich ist, aber der Sicherheit der Applikation oder unseren betriebswirtschaftlichen Interessen dient (z. B. Erhebung von Daten zu Zwecken der Optimierung der Applikation oder Sicherheitszwecken), erfolgt sie auf Grundlage unserer berechtigten Interessen. Sofern Nutzer ausdrücklich deren Einwilligung in die Verarbeitung ihrer Daten gebeten werden, erfolgt die Verarbeitung der von der Einwilligung umfassten Daten auf Grundlage der Einwilligung.

- Verarbeitete Datenarten: Bestandsdaten (z.B. Namen, Adressen); Meta- /Kommunikationsdaten (z.B. Geräte-Informationen, IP-Adressen).

- Zwecke der Verarbeitung: Erbringung vertraglicher Leistungen und Kundenservice.

- Rechtsgrundlagen: Einwilligung (Art. 6 Abs. 1 S. 1 lit. a. DSGVO); Vertragserfüllung und vorvertragliche Anfragen (Art. 6 Abs. 1 S. 1 lit. b. DSGVO); Berechtigte Interessen (Art. 6 Abs. 1 S. 1 lit. f. DSGVO)."""),
            ImprintHeadlineText("Bezug von Applikationen über Appstores"),
            ImprintText(
                """Der Bezug unserer Applikation erfolgt über über spezielle Online-Plattformen, die von anderen Dienstanbietern betrieben werden, an (so genannte "Appstores"). In diesem Zusammenhang gelten zusätzlich zu unseren Datenschutzhinweisen die Datenschutzhinweise der jeweiligen Appstores. Dies gilt insbesondere im Hinblick auf die auf den Plattformen eingesetzten Verfahren zur Reichweitemessung und zum interessensbezogenen Marketing sowie etwaige Kostenpflicht.

- Verarbeitete Datenarten: Bestandsdaten (z.B. Namen, Adressen); Zahlungsdaten (z.B. Bankverbindungen, Rechnungen, Zahlungshistorie); Kontaktdaten (z.B. E-Mail, Telefonnummern); Vertragsdaten (z.B. Vertragsgegenstand, Laufzeit, Kundenkategorie); Nutzungsdaten (z.B. besuchte Webseiten, Interesse an Inhalten, Zugriffszeiten); Meta- /Kommunikationsdaten (z.B. Geräte-Informationen, IP-Adressen); Inhaltsdaten (z.B. Eingaben in Onlineformularen).

- Betroffene Personen: Kunden; Nutzer (z.B. Webseitenbesucher, Nutzer von Onlinediensten).

- Zwecke der Verarbeitung: Erbringung vertraglicher Leistungen und Kundenservice; Marketing.

- Rechtsgrundlagen: Berechtigte Interessen (Art. 6 Abs. 1 S. 1 lit. f. DSGVO).

Weitere Hinweise zu Verarbeitungsprozessen, Verfahren und Diensten:

- Apple App Store: App- und Softwareverkaufsplattform; Dienstanbieter: Apple Inc., Infinite Loop, Cupertino, CA 95014, USA; Rechtsgrundlagen: Berechtigte Interessen (Art. 6 Abs. 1 S. 1 lit. f. DSGVO); Website: https://www.apple.com/de/ios/app-store/; Datenschutzerklärung: https://www.apple.com/legal/privacy/de-ww/.

- Google Play: App- und Softwareverkaufsplattform; Dienstanbieter: Google Ireland Limited, Gordon House, Barrow Street, Dublin 4, Irland, Mutterunternehmen: Google LLC, 1600 Amphitheatre Parkway, Mountain View, CA 94043, USA; Rechtsgrundlagen: Berechtigte Interessen (Art. 6 Abs. 1 S. 1 lit. f. DSGVO); Website: https://play.google.com/store/apps?hl=de; Datenschutzerklärung: https://policies.google.com/privacy."""),
            ImprintHeadlineText("Registrierung, Anmeldung und Nutzerkonto"),
            ImprintText(
                """Nutzer können ein Nutzerkonto anlegen. Im Rahmen der Registrierung werden den Nutzern die erforderlichen Pflichtangaben mitgeteilt und zu Zwecken der Bereitstellung des Nutzerkontos auf Grundlage vertraglicher Pflichterfüllung verarbeitet. Zu den verarbeiteten Daten gehören insbesondere die Login- Informationen (Nutzername, Passwort sowie eine E-Mail-Adresse).

Im Rahmen der Inanspruchnahme unserer Registrierungs- und Anmeldefunktionen sowie der Nutzung des Nutzerkontos speichern wir die IP-Adresse und den Zeitpunkt der jeweiligen Nutzerhandlung. Die Speicherung erfolgt auf Grundlage unserer berechtigten Interessen als auch jener der Nutzer an einem Schutz vor Missbrauch und sonstiger unbefugter Nutzung. Eine Weitergabe dieser Daten an Dritte erfolgt grundsätzlich nicht, es sei denn, sie ist zur Verfolgung unserer Ansprüche erforderlich oder es besteht eine gesetzliche Verpflichtung hierzu.

Die Nutzer können über Vorgänge, die für deren Nutzerkonto relevant sind, wie z.B. technische Änderungen, per E-Mail informiert werden.

- Verarbeitete Datenarten: Bestandsdaten (z.B. Namen, Adressen); Kontaktdaten (z.B. E-Mail, Telefonnummern); Inhaltsdaten (z.B. Eingaben in Onlineformularen); Meta-/Kommunikationsdaten (z.B. Geräte-Informationen, IP-Adressen).

- Betroffene Personen: Nutzer (z.B. Webseitenbesucher, Nutzer von Onlinediensten).

- Zwecke der Verarbeitung: Erbringung vertraglicher Leistungen und Kundenservice; Sicherheitsmaßnahmen; Verwaltung und Beantwortung von Anfragen; Bereitstellung unseres Onlineangebotes und Nutzerfreundlichkeit.
     14

- Rechtsgrundlagen: Vertragserfüllung und vorvertragliche Anfragen (Art. 6 Abs. 1 S. 1 lit. b. DSGVO); Berechtigte Interessen (Art. 6 Abs. 1 S. 1 lit. f. DSGVO).

Weitere Hinweise zu Verarbeitungsprozessen, Verfahren und Diensten:

- Registrierung mit Klarnamen: Aufgrund der Natur unserer Community bitten wir die Nutzer unser Angebot nur unter Verwendung von Klarnamen zu nutzen. D.h. die Nutzung von Pseudonymen ist nicht zulässig; Rechtsgrundlagen: Vertragserfüllung und vorvertragliche Anfragen (Art. 6 Abs. 1 S. 1 lit. b. DSGVO).

- Löschung von Daten nach Kündigung: Wenn Nutzer ihr Nutzerkonto gekündigt haben, werden deren Daten im Hinblick auf das Nutzerkonto, vorbehaltlich einer gesetzlichen Erlaubnis, Pflicht oder Einwilligung der Nutzer, gelöscht; Rechtsgrundlagen: Vertragserfüllung und vorvertragliche Anfragen (Art. 6 Abs. 1 S. 1 lit. b. DSGVO).
- Keine Aufbewahrungspflicht für Daten: Es obliegt den Nutzern, ihre Daten bei erfolgter Kündigung vor dem Vertragsende zu sichern. Wir sind berechtigt, sämtliche während der Vertragsdauer gespeicherte Daten des Nutzers unwiederbringlich zu löschen; Rechtsgrundlagen: Vertragserfüllung und vorvertragliche Anfragen (Art. 6 Abs. 1 S. 1 lit. b. DSGVO)."""),
            ImprintHeadlineText("Single-Sign-On-Anmeldung"),
            ImprintText(
                """Als "Single-Sign-On“ oder "Single-Sign-On-Anmeldung bzw. "-Authentifizierung“ werden Verfahren bezeichnet, die es Nutzern erlauben, sich mit Hilfe eines Nutzerkontos bei einem Anbieter von Single-Sign-On-Verfahren (z.B. einem sozialen Netzwerk), auch bei unserem Onlineangebot, anzumelden. Voraussetzung der Single-Sign-On-Authentifizierung ist, dass die Nutzer bei dem jeweiligen Single- Sign-On-Anbieter registriert sind und die erforderlichen Zugangsdaten in dem dafür vorgesehenen Onlineformular eingeben, bzw. schon bei dem Single-Sign-On- Anbieter angemeldet sind und die Single-Sign-On-Anmeldung via Schaltfläche bestätigen.

Die Authentifizierung erfolgt direkt bei dem jeweiligen Single-Sign-On-Anbieter. Im Rahmen einer solchen Authentifizierung erhalten wir eine Nutzer-ID mit der Information, dass der Nutzer unter dieser Nutzer-ID beim jeweiligen Single-Sign- On-Anbieter eingeloggt ist und eine für uns für andere Zwecke nicht weiter nutzbare ID (sog "User Handle“). Ob uns zusätzliche Daten übermittelt werden, hängt allein von dem genutzten Single-Sign-On-Verfahren ab, von den gewählten Datenfreigaben im Rahmen der Authentifizierung und zudem davon, welche Daten Nutzer in den Privatsphäre- oder sonstigen Einstellungen des Nutzerkontos beim

Single-Sign-On-Anbieter freigegeben haben. Es können je nach Single-Sign-On- Anbieter und der Wahl der Nutzer verschiedene Daten sein, in der Regel sind es die E-Mail-Adresse und der Benutzername. Das im Rahmen des Single-Sign-On- Verfahrens eingegebene Passwort bei dem Single-Sign-On-Anbieter ist für uns weder einsehbar, noch wird es von uns gespeichert.

Die Nutzer werden gebeten, zu beachten, dass deren bei uns gespeicherte Angaben automatisch mit ihrem Nutzerkonto beim Single-Sign-On-Anbieter abgeglichen werden können, dies jedoch nicht immer möglich ist oder tatsächlich erfolgt. Ändern sich z.B. die E-Mail-Adressen der Nutzer, müssen sie diese manuell in ihrem Nutzerkonto bei uns ändern.

Die Single-Sign-On-Anmeldung können wir, sofern mit den Nutzern vereinbart, im Rahmen der oder vor der Vertragserfüllung einsetzen, soweit die Nutzer darum gebeten wurden, im Rahmen einer Einwilligung verarbeiten und setzen sie ansonsten auf Grundlage der berechtigten Interessen unsererseits und der Interessen der Nutzer an einem effektiven und sicheren Anmeldesystem ein.

Sollten Nutzer sich einmal entscheiden, die Verknüpfung ihres Nutzerkontos beim Single-Sign-On-Anbieter nicht mehr für das Single-Sign-On-Verfahren nutzen zu wollen, müssen sie diese Verbindung innerhalb ihres Nutzerkontos beim Single- Sign-On-Anbieter aufheben. Möchten Nutzer deren Daten bei uns löschen, müssen sie ihre Registrierung bei uns kündigen.

- Verarbeitete Datenarten: Bestandsdaten (z.B. Namen, Adressen); Kontaktdaten (z.B. E-Mail, Telefonnummern); Nutzungsdaten (z.B. besuchte Webseiten, Interesse an Inhalten, Zugriffszeiten); Meta- /Kommunikationsdaten (z.B. Geräte-Informationen, IP-Adressen); Event-Daten (Facebook) ("Event-Daten" sind Daten, die z. B. via Facebook-Pixel (via Apps oder auf anderen Wegen) von uns an Facebook übermittelt werden können und sich auf Personen oder deren Handlungen beziehen; Zu den Daten gehören z. B. Angaben über Besuche auf Websites, Interaktionen mit Inhalten, Funktionen, Installationen von Apps, Käufe von Produkten, etc.; die Event-Daten werden zwecks Bildung von Zielgruppen für Inhalte und Werbeinformationen (Custom Audiences) verarbeitet; Event Daten beinhalten nicht die eigentlichen Inhalte (wie z. B. verfasste Kommentare), keine Login- Informationen und keine Kontaktinformationen (also keine Namen, E-Mail- Adressen und Telefonnummern). Event Daten werden durch Facebook nach maximal zwei Jahren gelöscht, die aus ihnen gebildeten Zielgruppen mit der Löschung unseres Facebook-Kontos).

- Betroffene Personen: Nutzer (z.B. Webseitenbesucher, Nutzer von Onlinediensten).

- Zwecke der Verarbeitung: Erbringung vertraglicher Leistungen und Kundenservice; Sicherheitsmaßnahmen; Anmeldeverfahren.

Rechtsgrundlagen: Berechtigte Interessen (Art. 6 Abs. 1 S. 1 lit. f. DSGVO).

Weitere Hinweise zu Verarbeitungsprozessen, - Verfahren und Diensten:

- Apple Single-Sign-On: Authentifizierungsdienst; Dienstanbieter: Apple Inc., Infinite Loop, Cupertino, CA 95014, USA; Rechtsgrundlagen: Berechtigte Interessen (Art. 6 Abs. 1 S. 1 lit. f. DSGVO); Website: https://www.apple.com/de/; Datenschutzerklärung: https://www.apple.com/legal/privacy/de-ww/.

- Facebook Single-Sign-On: Authentifizierungsdienst der Plattform Facebook; Dienstanbieter: Meta Platforms Irland Limited, 4 Grand Canal Square, Grand Canal Harbour, Dublin 2, Irland; Rechtsgrundlagen: Berechtigte Interessen (Art. 6 Abs. 1 S. 1 lit. f. DSGVO); Website: https://www.facebook.com; Datenschutzerklärung: https://www.facebook.com/about/privacy; Auftragsverarbeitungsvertrag: https://www.facebook.com/legal/terms/dataprocessing; Standardvertragsklauseln (Gewährleistung Datenschutzniveau bei Verarbeitung in Drittländern): https://www.facebook.com/legal/EU_data_transfer_addendum.

- Google Single-Sign-On: Authentifizierungsdienst; Dienstanbieter: Google Ireland Limited, Gordon House, Barrow Street, Dublin 4, Irland, Mutterunternehmen: Google LLC, 1600 Amphitheatre Parkway, Mountain View, CA 94043, USA; Rechtsgrundlagen: Berechtigte Interessen (Art. 6 Abs. 1 S. 1 lit. f. DSGVO); Website: https://www.google.de; Datenschutzerklärung: https://policies.google.com/privacy; Widerspruchsmöglichkeit (Opt-Out): Einstellungen für die Darstellung von Werbeeinblendungen: https://adssettings.google.com/authenticated."""),
            ImprintHeadlineText("Chatbots und Chatfunktionen"),
            ImprintText(
                """Wir bieten als Kommunikationsmöglichkeit Online-Chats und Chatbot-Funktionen an (zusammen als "Chat-Dienste" bezeichnet). Bei einem Chat handelt es sich um eine mit gewisser Zeitnähe geführte Online-Unterhaltung. Bei einem Chatbot handelt es sich um eine Software, die Fragen der Nutzer beantwortet oder sie über Nachrichten informiert. Wenn Sie unsere Chat-Funktionen nutzen, können wir Ihre personenbezogenen Daten verarbeiten.

Falls Sie unsere Chat-Dienste innerhalb einer Online-Plattform nutzen, wird zusätzlich Ihre Identifikationsnummer innerhalb der jeweiligen Plattform gespeichert. Wir können zudem Informationen darüber erheben, welche Nutzer wann mit unseren Chat-Diensten interagieren. Ferner speichern wir den Inhalt Ihrer Konversationen über die Chat-Dienste und protokollieren Registrierungs- und Einwilligungsvorgänge, um diese nach gesetzlichen Vorgaben nachweisen zu können.

Wir weisen Nutzer darauf hin, dass der jeweilige Plattformanbieter in Erfahrung bringen kann, dass und wann Nutzer mit unseren Chat-Diensten kommunizieren sowie technische Informationen zum verwendeten Gerät der Nutzer und je nach Einstellungen ihres Gerätes auch Standortinformationen (sogenannte Metadaten) zu Zwecken der Optimierung der jeweiligen Dienste und Zwecken der Sicherheit erheben kann. Ebenfalls könnten die Metadaten der Kommunikation via Chat- Diensten (d.h. z.B., die Information, wer mit wem kommuniziert hat) durch die jeweiligen Plattformanbieter nach Maßgabe ihrer Bestimmungen, auf die wir zwecks weiterer Information verweisen, für Zwecke des Marketings oder zur Anzeige auf Nutzer zugeschnittener Werbung verwendet werden.

Sofern Nutzer sich gegenüber einem Chatbot bereiterklären, Informationen mit regelmäßigen Nachrichten zu aktivieren, steht ihnen jederzeit die Möglichkeit zur Verfügung, die Informationen für die Zukunft abzubestellen. Der Chatbot weist Nutzer darauf hin, wie und mit welchen Begriffen sie die Nachrichten abbestellen können. Mit dem Abbestellen der Chatbotnachrichten werden Daten der Nutzer aus dem Verzeichnis der Nachrichtenempfänger gelöscht.

Die vorgenannten Angaben nutzen wir, um unsere Chat-Dienste zu betreiben, z.B., um Nutzer persönlich anzusprechen, um ihre Anfragen zu beantworten, etwaige angeforderte Inhalte zu übermitteln und auch, um unsere Chat-Dienste zu verbessern (z.B., um Chatbots Antworten auf häufig gestellte Fragen "beizubringen“ oder unbeantwortete Anfragen zu erkennen).

Hinweise zu Rechtsgrundlagen: Wir setzen die Chat-Dienste auf Grundlage einer Einwilligung ein, wenn wir zuvor eine Erlaubnis der Nutzer in die Verarbeitung ihrer Daten im Rahmen unserer Chat-Dienste eingeholt haben (dies gilt für die Fälle, in denen Nutzer um eine Einwilligung gebeten werden, z.B., damit ein Chatbot ihnen regelmäßig Nachrichten zusendet). Sofern wir Chat-Dienste einsetzen, um Anfragen der Nutzer zu unseren Leistungen oder unserem Unternehmen zu beantworten, erfolgt dies zur vertraglichen und vorvertraglichen Kommunikation. Im Übrigen setzen wir Chat-Dienste auf Grundlage unserer berechtigten Interessen an einer Optimierung der Chat-Dienste, ihrer Betriebswirtschaftlichkeit sowie einer Steigerung der positiven Nutzererfahrung ein.

Widerruf, Widerspruch und Löschung: Sie können jederzeit eine erteilte Einwilligung widerrufen oder der Verarbeitung Ihrer Daten im Rahmen unserer Chat-Dienste widersprechen.

- Verarbeitete Datenarten: Kontaktdaten (z.B. E-Mail, Telefonnummern); Inhaltsdaten (z.B. Eingaben in Onlineformularen); Nutzungsdaten (z.B. besuchte Webseiten, Interesse an Inhalten, Zugriffszeiten); Meta- /Kommunikationsdaten (z.B. Geräte-Informationen, IP-Adressen).

- Betroffene Personen: Kommunikationspartner.

- Zwecke der Verarbeitung: Kontaktanfragen und Kommunikation; Direktmarketing (z.B. per E-Mail oder postalisch).

- Rechtsgrundlagen: Einwilligung (Art. 6 Abs. 1 S. 1 lit. a. DSGVO); Vertragserfüllung und vorvertragliche Anfragen (Art. 6 Abs. 1 S. 1 lit. b. DSGVO); Berechtigte Interessen (Art. 6 Abs. 1 S. 1 lit. f. DSGVO)."""),
            ImprintHeadlineText("Push-Nachrichten"),
            ImprintText(
                """Mit der Zustimmung der Nutzer, können wir den Nutzern so genannte "Push- Benachrichtigungen" zusenden. Dabei handelt es sich um Nachrichten, die auf den Bildschirmen, Endgeräten oder in Browsern der Nutzer angezeigt werden, auch wenn unser Onlinedienst gerade nicht aktiv genutzt wird.

Um sich für die Push-Nachrichten anzumelden, müssen Nutzer die Abfrage ihres Browsers bzw. Endgerätes zum Erhalt der Push-Nachrichten bestätigen. Dieser Zustimmungsprozess wird dokumentiert und gespeichert. Die Speicherung ist erforderlich, um zu erkennen, ob Nutzer dem Empfang der Push-Nachrichten zugestimmt haben sowie um die Zustimmung nachweisen zu können. Zu diesen Zwecken wird ein pseudonymer Identifikator des Browsers (sog. "Push-Token") oder die Geräte-ID eines Endgerätes gespeichert.

Die Push-Nachrichten können zum einen für die Erfüllung von vertraglichen Pflichten erforderlich sein (z. B. für die Nutzung unseres Onlineangebotes relevante technische und organisatorische Informationen) und werden ansonsten, sofern nicht nachfolgend speziell genannt, auf Grundlage einer Einwilligung der Nutzer versendet. Nutzer können den Empfang der Push-Nachrichten jederzeit mit Hilfe der Benachrichtigungseinstellungen ihrer jeweiligen Browser, bzw. Endgeräte ändern.

- Verarbeitete Datenarten: Nutzungsdaten (z.B. besuchte Webseiten, Interesse an Inhalten, Zugriffszeiten); Meta-/Kommunikationsdaten (z.B. Geräte-Informationen, IP-Adressen); Inhaltsdaten (z.B. Eingaben in Onlineformularen).

- Betroffene Personen: Kommunikationspartner; Nutzer (z.B. Webseitenbesucher, Nutzer von Onlinediensten); Geschäfts- und Vertragspartner.

- Zwecke der Verarbeitung: Bereitstellung unseres Onlineangebotes und Nutzerfreundlichkeit; Reichweitenmessung (z.B. Zugriffsstatistiken, Erkennung wiederkehrender Besucher); Direktmarketing (z.B. per E-Mail oder postalisch); Informationstechnische Infrastruktur (Betrieb und Bereitstellung von Informationssystemen und technischen Geräten (Computer, Server etc.).).

- Rechtsgrundlagen: Einwilligung (Art. 6 Abs. 1 S. 1 lit. a. DSGVO); Vertragserfüllung und vorvertragliche Anfragen (Art. 6 Abs. 1 S. 1 lit. b. DSGVO); Berechtigte Interessen (Art. 6 Abs. 1 S. 1 lit. f. DSGVO).

Weitere Hinweise zu Verarbeitungsprozessen, Verfahren und Diensten:

- Push-Nachrichten mit werblichem Inhalt: Die von uns gesendeten Push- Benachrichtigungen können werbliche Informationen beinhalten. Die werblichen Push-Nachrichten werden auf Grundlage einer Einwilligung der Nutzer verarbeitet. Sofern im Rahmen einer Zustimmung zum Empfang der werblichen Push-Nachrichten deren Inhalte konkret beschrieben werden, sind die Beschreibungen für die Einwilligung der Nutzer maßgeblich. Im Übrigen enthalten unsere Newsletter Informationen zu unseren Leistungen und uns; Rechtsgrundlagen: Einwilligung (Art. 6 Abs. 1 S. 1 lit. a. DSGVO).

- Analyse und Erfolgsmessung: Wir werten Push-Nachrichten statistisch aus und können so erkennen, ob und wann Push-Nachrichten angezeigt und angeklickt wurden. Diese Informationen werden zur technischen Verbesserung unserer Push-Nachrichten anhand der technischen Daten oder der Zielgruppen und ihres Abrufverhalten oder der Abrufzeiten genutzt. Diese Analyse beinhaltet ebenfalls die Feststellung, ob die Push-Nachrichten geöffnet werden, wann sie geöffnet werden und ob Nutzer mit deren Inhalten oder Schaltflächen interagieren. Diese Informationen können aus technischen Gründen zwar den einzelnen Push-Nachrichtenempfängern zugeordnet werden. Es ist jedoch weder unser Bestreben noch, sofern eingesetzt, das des Push-Nachrichten-Dienstleisters, einzelne Nutzer zu beobachten. Die Auswertungen dienen uns vielmehr dazu, die Nutzungsgewohnheiten unserer Nutzer zu erkennen und unsere Push-Nachrichten an sie anzupassen oder unterschiedliche Push-Nachrichten entsprechend den Interessen unserer Nutzer zu versenden. Die Auswertung der Push-Nachrichten und die Erfolgsmessung erfolgen, auf Grundlage einer ausdrücklichen Einwilligung der Nutzer, die mit der Zustimmung zum Empfang der Push-Nachrichten erfolgt. Nutzer können der Analyse und Erfolgsmessung widersprechen, in dem Sie die Push-Nachrichten abbestellen. Ein getrennter Widerruf der Analyse und Erfolgsmessung ist leider nicht möglich; Rechtsgrundlagen: Einwilligung (Art. 6 Abs. 1 S. 1 lit. a. DSGVO).

- Firebase: Dienstanbieter: Google Ireland Limited, Gordon House, Barrow Street, Dublin 4, Irland, Mutterunternehmen: Google LLC, 1600 Amphitheatre Parkway, Mountain View, CA 94043, USA; Rechtsgrundlagen: Einwilligung (Art. 6 Abs. 1 S. 1 lit. a. DSGVO); Website: https://firebase.google.com; Datenschutzerklärung: https://policies.google.com/privacy; Standardvertragsklauseln (Gewährleistung Datenschutzniveau bei Verarbeitung in Drittländern): https://firebase.google.com/terms/data-processing-terms.

- Amazon Web Services (AWS): Leistungen auf dem Gebiet der Bereitstellung von informationstechnischer Infrastruktur und verbundenen Dienstleistungen (z.B. Speicherplatz und/oder Rechenkapazitäten); Dienstanbieter: Amazon Web Services EMEA SARL, 38 avenue John F. Kennedy, L-1855, Luxemburg; Rechtsgrundlagen: Berechtigte Interessen (Art. 6 Abs. 1 S. 1 lit. f. DSGVO); Website: https://aws.amazon.com/de/; Datenschutzerklärung: https://aws.amazon.com/de/privacy/; Auftragsverarbeitungsvertrag: https://aws.amazon.com/de/compliance/gdpr-center/; Standardvertragsklauseln (Gewährleistung Datenschutzniveau bei Verarbeitung in Drittländern): Einbeziehung im Auftragsverarbeitungsvertrag."""),
            ImprintHeadlineText("Webanalyse, Monitoring und Optimierung"),
            ImprintText(
                """Die Webanalyse (auch als "Reichweitenmessung" bezeichnet) dient der Auswertung der Besucherströme unseres Onlineangebotes und kann Verhalten, Interessen oder demographische Informationen zu den Besuchern, wie z.B. das Alter oder das Geschlecht, als pseudonyme Werte umfassen. Mit Hilfe der Reichweitenanalyse können wir z.B. erkennen, zu welcher Zeit unser Onlineangebot oder dessen Funktionen oder Inhalte am häufigsten genutzt werden oder zur Wiederverwendung einladen. Ebenso können wir nachvollziehen, welche Bereiche der Optimierung bedürfen.

Neben der Webanalyse können wir auch Testverfahren einsetzen, um z.B. unterschiedliche Versionen unseres Onlineangebotes oder seiner Bestandteile zu testen und optimieren.

Sofern nachfolgend nicht anders angegeben, können zu diesen Zwecken Profile, d.h. zu einem Nutzungsvorgang zusammengefasste Daten angelegt und Informationen in einem Browser, bzw. in einem Endgerät gespeichert und aus diesem ausgelesen werden. Zu den erhobenen Angaben gehören insbesondere besuchte Webseiten und dort genutzte Elemente sowie technische Angaben, wie der verwendete Browser, das verwendete Computersystem sowie Angaben zu Nutzungszeiten. Sofern Nutzer in die Erhebung ihrer Standortdaten uns gegenüber oder gegenüber den Anbietern der von uns eingesetzten Dienste einverstanden erklärt haben, können auch Standortdaten verarbeitet werden.

Es werden ebenfalls die IP-Adressen der Nutzer gespeichert. Jedoch nutzen wir ein IP-Masking-Verfahren (d.h., Pseudonymisierung durch Kürzung der IP-Adresse) zum Schutz der Nutzer. Generell werden die im Rahmen von Webanalyse, A/B- Testings und Optimierung keine Klardaten der Nutzer (wie z.B. E-Mail-Adressen oder Namen) gespeichert, sondern Pseudonyme. D.h., wir als auch die Anbieter der eingesetzten Software kennen nicht die tatsächliche Identität der Nutzer, sondern nur den für Zwecke der jeweiligen Verfahren in deren Profilen gespeicherten Angaben.

- Verarbeitete Datenarten: Nutzungsdaten (z.B. besuchte Webseiten, Interesse an Inhalten, Zugriffszeiten); Meta-/Kommunikationsdaten (z.B. Geräte-Informationen, IP-Adressen).

- Betroffene Personen: Nutzer (z.B. Webseitenbesucher, Nutzer von Onlinediensten).

- Zwecke der Verarbeitung: Reichweitenmessung (z.B. Zugriffsstatistiken, Erkennung wiederkehrender Besucher); Profile mit nutzerbezogenen Informationen (Erstellen von Nutzerprofilen); Tracking (z.B. interessens- /verhaltensbezogenes Profiling, Nutzung von Cookies); Bereitstellung unseres Onlineangebotes und Nutzerfreundlichkeit.

- Sicherheitsmaßnahmen: IP-Masking (Pseudonymisierung der IP-Adresse). Rechtsgrundlagen: Einwilligung (Art. 6 Abs. 1 S. 1 lit. a. DSGVO).

Weitere Hinweise zu Verarbeitungsprozessen, Verfahren und Diensten:

- Firebase: Bei Google Firebase handelt es sich um eine Plattform für Entwickler von Applikationen (kurz "Apps“) für mobile Geräte und Webseiten. Google Firebase bietet eine Vielzahl von Funktionen für das Testen von Apps, die Überwachung ihrer Funktionsfähigkeit und ihre Optimierung (die auf der folgenden Übersichtsseite dargestellt werden: https://firebase.google.com/products). Die Funktionen umfassen unter anderem die Speicherung von Apps inklusive personenbezogener Daten der Applikationsnutzer, wie z.B. von ihnen erstellter Inhalte oder Informationen betreffend ihre Interaktion mit den Apps (sogenannte "Cloud Computing“). Google Firebase bietet daneben Schnittstellen, die eine Interaktion zwischen den Nutzern der App und anderen Diensten erlauben, z.B. die Authentifizierung mittels Diensten wie Facebook, Twitter oder mittels einer E-Mail-Passwort-Kombination. ; Dienstanbieter: Google Ireland Limited, Gordon House, Barrow Street, Dublin 4, Irland, Mutterunternehmen: Google LLC, 1600 Amphitheatre Parkway, Mountain View, CA 94043, USA; Rechtsgrundlagen: Einwilligung (Art. 6 Abs. 1 S. 1 lit. a. DSGVO); Website: https://firebase.google.com; Datenschutzerklärung: https://policies.google.com/privacy.

- Google Analytics: Webanalyse, Reichweitenmessung sowie Messung von Nutzerströmen; Dienstanbieter: Google Ireland Limited, Gordon House, Barrow Street, Dublin 4, Irland, Mutterunternehmen: Google LLC, 1600 Amphitheatre Parkway, Mountain View, CA 94043, USA; Rechtsgrundlagen: Einwilligung (Art. 6 Abs. 1 S. 1 lit. a. DSGVO); Website: https://marketingplatform.google.com/intl/de/about/analytics/;

Datenschutzerklärung: https://policies.google.com/privacy;
Auftragsverarbeitungsvertrag: https://business.safety.google/adsprocessorterms;
Standardvertragsklauseln (Gewährleistung Datenschutzniveau bei Verarbeitung in Drittländern): https://business.safety.google/adsprocessorterms;
Widerspruchsmöglichkeit (Opt-Out): Opt-Out-Plugin: https://tools.google.com/dlpage/gaoptout?hl=de,
Einstellungen für die Darstellung von Werbeeinblendungen: https://adssettings.google.com/authenticated;
Weitere Informationen: https://privacy.google.com/businesses/adsservices (Arten der Verarbeitung sowie der verarbeiteten Daten)."""),
            ImprintHeadlineText("Onlinemarketing"),
            ImprintText(
                """Wir verarbeiten personenbezogene Daten zu Zwecken des Onlinemarketings, worunter insbesondere die Vermarktung von Werbeflächen oder Darstellung von werbenden und sonstigen Inhalten (zusammenfassend als "Inhalte" bezeichnet) anhand potentieller Interessen der Nutzer sowie die Messung ihrer Effektivität fallen kann.

Zu diesen Zwecken werden sogenannte Nutzerprofile angelegt und in einer Datei (sogenannte "Cookie") gespeichert oder ähnliche Verfahren genutzt, mittels derer die für die Darstellung der vorgenannten Inhalte relevante Angaben zum Nutzer gespeichert werden. Zu diesen Angaben können z.B. betrachtete Inhalte, besuchte Webseiten, genutzte Onlinenetzwerke, aber auch Kommunikationspartner und technische Angaben, wie der verwendete Browser, das verwendete Computersystem sowie Angaben zu Nutzungszeiten und genutzten Funktionen gehören. Sofern Nutzer in die Erhebung ihrer Standortdaten eingewilligt haben, können auch diese verarbeitet werden.

Es werden ebenfalls die IP-Adressen der Nutzer gespeichert. Jedoch nutzen wir zur Verfügung stehende IP-Masking-Verfahren (d.h., Pseudonymisierung durch Kürzung der IP-Adresse) zum Schutz der Nutzer. Generell werden im Rahmen des Onlinemarketingverfahren keine Klardaten der Nutzer (wie z.B. E-Mail-Adressen oder Namen) gespeichert, sondern Pseudonyme. D.h., wir als auch die Anbieter der Onlinemarketingverfahren kennen nicht die tatsächliche Identität der Nutzer, sondern nur die in deren Profilen gespeicherten Angaben.

Die Angaben in den Profilen werden im Regelfall in den Cookies oder mittels ähnlicher Verfahren gespeichert. Diese Cookies können später generell auch auf anderen Webseiten die dasselbe Onlinemarketingverfahren einsetzen, ausgelesen und zu Zwecken der Darstellung von Inhalten analysiert als auch mit weiteren Daten ergänzt und auf dem Server des Onlinemarketingverfahrensanbieters gespeichert werden.

Ausnahmsweise können Klardaten den Profilen zugeordnet werden. Das ist der Fall, wenn die Nutzer z.B. Mitglieder eines sozialen Netzwerks sind, dessen Onlinemarketingverfahren wir einsetzen und das Netzwerk die Profile der Nutzer mit den vorgenannten Angaben verbindet. Wir bitten darum, zu beachten, dass Nutzer mit den Anbietern zusätzliche Abreden, z.B. durch Einwilligung im Rahmen der Registrierung, treffen können.

Wir erhalten grundsätzlich nur Zugang zu zusammengefassten Informationen über den Erfolg unserer Werbeanzeigen. Jedoch können wir im Rahmen sogenannter Konversionsmessungen prüfen, welche unserer Onlinemarketingverfahren zu einer sogenannten Konversion geführt haben, d.h. z.B., zu einem Vertragsschluss mit uns. Die Konversionsmessung wird alleine zur Analyse des Erfolgs unserer Marketingmaßnahmen verwendet.

Solange nicht anders angegeben, bitten wir Sie davon auszugehen, dass verwendete Cookies für einen Zeitraum von zwei Jahren gespeichert werden.

- Verarbeitete Datenarten: Nutzungsdaten (z.B. besuchte Webseiten, Interesse an Inhalten, Zugriffszeiten); Meta-/Kommunikationsdaten (z.B. Geräte-Informationen, IP-Adressen).

- Betroffene Personen: Nutzer (z.B. Webseitenbesucher, Nutzer von Onlinediensten).

- Zwecke der Verarbeitung: Reichweitenmessung (z.B. Zugriffsstatistiken, Erkennung wiederkehrender Besucher); Tracking (z.B. interessens- /verhaltensbezogenes Profiling, Nutzung von Cookies); Marketing; Profile mit nutzerbezogenen Informationen (Erstellen von Nutzerprofilen).

- Sicherheitsmaßnahmen: IP-Masking (Pseudonymisierung der IP-Adresse).

- Widerspruchsmöglichkeit (Opt-Out): Wir verweisen auf die Datenschutzhinweise der jeweiligen Anbieter und die zu den Anbietern angegebenen Widerspruchsmöglichkeiten (sog. "Opt-Out"). Sofern keine explizite Opt-Out-Möglichkeit angegeben wurde, besteht zum einen die Möglichkeit, dass Sie Cookies in den Einstellungen Ihres Browsers abschalten. Hierdurch können jedoch Funktionen unseres Onlineangebotes eingeschränkt werden. Wir empfehlen daher zusätzlich die folgenden Opt- Out-Möglichkeiten, die zusammenfassend auf jeweilige Gebiete gerichtet angeboten werden: a) Europa: https://www.youronlinechoices.eu. b) Kanada: https://www.youradchoices.ca/choices. c) USA: https://www.aboutads.info/choices. d) Gebietsübergreifend: https://optout.aboutads.info."""),
            ImprintHeadlineText(
                "Änderung und Aktualisierung der Datenschutzerklärung"),
            ImprintText(
                """Wir bitten Sie, sich regelmäßig über den Inhalt unserer Datenschutzerklärung zu informieren. Wir passen die Datenschutzerklärung an, sobald die Änderungen der von uns durchgeführten Datenverarbeitungen dies erforderlich machen. Wir informieren Sie, sobald durch die Änderungen eine Mitwirkungshandlung Ihrerseits (z.B. Einwilligung) oder eine sonstige individuelle Benachrichtigung erforderlich wird.

Sofern wir in dieser Datenschutzerklärung Adressen und Kontaktinformationen von Unternehmen und Organisationen angeben, bitten wir zu beachten, dass die Adressen sich über die Zeit ändern können und bitten die Angaben vor Kontaktaufnahme zu prüfen."""),
            ImprintHeadlineText("Rechte der betroffenen Personen"),
            ImprintText(
                """Ihnen stehen als Betroffene nach der DSGVO verschiedene Rechte zu, die sich insbesondere aus Art. 15 bis 21 DSGVO ergeben:

- Widerspruchsrecht: Sie haben das Recht, aus Gründen, die sich aus Ihrer besonderen Situation ergeben, jederzeit gegen die Verarbeitung der Sie betreffenden personenbezogenen Daten, die aufgrund von Art. 6 Abs. 1 lit. e oder f DSGVO erfolgt, Widerspruch einzulegen; dies gilt auch für ein auf diese Bestimmungen gestütztes Profiling. Werden die Sie betreffenden personenbezogenen Daten verarbeitet, um Direktwerbung zu betreiben, haben Sie das Recht, jederzeit Widerspruch gegen die Verarbeitung der Sie betreffenden personenbezogenen Daten zum Zwecke derartiger Werbung einzulegen; dies gilt auch für das Profiling, soweit es mit solcher Direktwerbung in Verbindung steht.

- Widerrufsrecht bei Einwilligungen: Sie haben das Recht, erteilte Einwilligungen jederzeit zu widerrufen.

- Auskunftsrecht: Sie haben das Recht, eine Bestätigung darüber zu verlangen, ob betreffende Daten verarbeitet werden und auf Auskunft über diese Daten sowie auf weitere Informationen und Kopie der Daten entsprechend den gesetzlichen Vorgaben.

- Recht auf Berichtigung: Sie haben entsprechend den gesetzlichen Vorgaben das Recht, die Vervollständigung der Sie betreffenden Daten oder die Berichtigung der Sie betreffenden unrichtigen Daten zu verlangen.

- Recht auf Löschung und Einschränkung der Verarbeitung: Sie haben nach Maßgabe der gesetzlichen Vorgaben das Recht, zu verlangen, dass Sie betreffende Daten unverzüglich gelöscht werden, bzw. alternativ nach Maßgabe der gesetzlichen Vorgaben eine Einschränkung der Verarbeitung der Daten zu verlangen.

- Recht auf Datenübertragbarkeit: Sie haben das Recht, Sie betreffende Daten, die Sie uns bereitgestellt haben, nach Maßgabe der gesetzlichen Vorgaben in einem strukturierten, gängigen und maschinenlesbaren Format zu erhalten oder deren Übermittlung an einen anderen Verantwortlichen zu fordern.

- Beschwerde bei Aufsichtsbehörde: Entsprechend den gesetzlichen Vorgaben und unbeschadet eines anderweitigen verwaltungsrechtlichen oder gerichtlichen Rechtsbehelfs, haben Sie ferner das Recht, bei einer Datenschutzaufsichtsbehörde, insbesondere einer Aufsichtsbehörde im Mitgliedstaat, in dem Sie sich gewöhnlich aufhalten, der Aufsichtsbehörde Ihres Arbeitsplatzes oder des Ortes des mutmaßlichen Verstoßes, eine Beschwerde einzulegen, wenn Sie der Ansicht sei sollten, dass die Verarbeitung der Ihre Person betreffenden personenbezogenen Daten gegen die DSGVO verstößt."""),
            ImprintHeadlineText("Begriffsdefinitionen"),
            ImprintText(
                """In diesem Abschnitt erhalten Sie eine Übersicht über die in dieser Datenschutzerklärung verwendeten Begrifflichkeiten. Viele der Begriffe sind dem Gesetz entnommen und vor allem im Art. 4 DSGVO definiert. Die gesetzlichen Definitionen sind verbindlich. Die nachfolgenden Erläuterungen sollen dagegen vor allem dem Verständnis dienen. Die Begriffe sind alphabetisch sortiert.

- Personenbezogene Daten: "Personenbezogene Daten“ sind alle Informationen, die sich auf eine identifizierte oder identifizierbare natürliche Person (im Folgenden "betroffene Person“) beziehen; als identifizierbar wird eine natürliche Person angesehen, die direkt oder indirekt, insbesondere mittels Zuordnung zu einer Kennung wie einem Namen, zu einer Kennnummer, zu Standortdaten, zu einer Online-Kennung (z.B. Cookie) oder zu einem oder mehreren besonderen Merkmalen identifiziert werden kann, die Ausdruck der physischen, physiologischen, genetischen, psychischen, wirtschaftlichen, kulturellen oder sozialen Identität dieser natürlichen Person sind.

- Profile mit nutzerbezogenen Informationen: Die Verarbeitung von "Profilen mit nutzerbezogenen Informationen", bzw. kurz "Profilen" umfasst jede Art der automatisierten Verarbeitung personenbezogener Daten, die darin besteht, dass diese personenbezogenen Daten verwendet werden, um bestimmte persönliche Aspekte, die sich auf eine natürliche Person beziehen (je nach Art der Profilbildung können dazu unterschiedliche Informationen betreffend die Demographie, Verhalten und Interessen, wie z.B. die Interaktion mit Webseiten und deren Inhalten, etc.) zu analysieren, zu bewerten oder, um sie vorherzusagen (z.B. die Interessen an bestimmten Inhalten oder Produkten, das Klickverhalten auf einer Webseite oder den Aufenthaltsort). Zu Zwecken des Profilings werden häufig Cookies und Web- Beacons eingesetzt.

- Reichweitenmessung: Die Reichweitenmessung (auch als Web Analytics bezeichnet) dient der Auswertung der Besucherströme eines Onlineangebotes und kann das Verhalten oder Interessen der Besucher an bestimmten Informationen, wie z.B. Inhalten von Webseiten, umfassen. Mit Hilfe der Reichweitenanalyse können Webseiteninhaber z.B. erkennen, zu welcher Zeit Besucher ihre Webseite besuchen und für welche Inhalte sie sich interessieren. Dadurch können sie z.B. die Inhalte der Webseite besser an die Bedürfnisse ihrer Besucher anpassen. Zu Zwecken der Reichweitenanalyse werden häufig pseudonyme Cookies und Web-Beacons eingesetzt, um wiederkehrende Besucher zu erkennen und so genauere Analysen zur Nutzung eines Onlineangebotes zu erhalten.

- Tracking: Vom "Tracking“ spricht man, wenn das Verhalten von Nutzern über mehrere Onlineangebote hinweg nachvollzogen werden kann. Im Regelfall werden im Hinblick auf die genutzten Onlineangebote Verhaltens- und Interessensinformationen in Cookies oder auf Servern der Anbieter der Trackingtechnologien gespeichert (sogenanntes Profiling). Diese Informationen können anschließend z.B. eingesetzt werden, um den Nutzern Werbeanzeigen anzuzeigen, die voraussichtlich deren Interessen entsprechen.

- Verantwortlicher: Als "Verantwortlicher“ wird die natürliche oder juristische Person, Behörde, Einrichtung oder andere Stelle, die allein oder gemeinsam mit anderen über die Zwecke und Mittel der Verarbeitung von personenbezogenen Daten entscheidet, bezeichnet.

- Verarbeitung: "Verarbeitung" ist jeder mit oder ohne Hilfe automatisierter Verfahren ausgeführte Vorgang oder jede solche Vorgangsreihe im Zusammenhang mit personenbezogenen Daten. Der Begriff reicht weit und umfasst praktisch jeden Umgang mit Daten, sei es das Erheben, das Auswerten, das Speichern, das Übermitteln oder das Löschen."""),
          ])),
    );
  }
}

class ImprintMainHeadlineText extends StatelessWidget {
  const ImprintMainHeadlineText(this.text, {Key? key}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 80, 0, 20),
      child: Text(
        this.text,
        style: const TextStyle(
          fontSize: 30.0,
          color: Color(0xFF00338D),
          fontFamily: 'Inter',
          fontWeight: FontWeight.w900,
        ),
        textAlign: TextAlign.start,
      ),
    );
  }
}

class ImprintMainHeadlineTextS extends StatelessWidget {
  const ImprintMainHeadlineTextS(this.text, {Key? key}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 80, 0, 30),
      child: Text(
        this.text,
        style: const TextStyle(
          fontSize: 35.0,
          color: Color(0xFF00338D),
          fontFamily: 'Inter',
          fontWeight: FontWeight.w900,
        ),
        textAlign: TextAlign.start,
      ),
    );
  }
}

class ImprintHeadlineText extends StatelessWidget {
  const ImprintHeadlineText(this.text, {Key? key}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 30, 0, 10),
      child: Text(
        this.text,
        style: const TextStyle(
          fontSize: 20.0,
          color: Color(0xFF00338D),
          fontFamily: 'Inter',
          fontWeight: FontWeight.w700,
        ),
        textAlign: TextAlign.start,
      ),
    );
  }
}

class ImprintHeadlineTextS extends StatelessWidget {
  const ImprintHeadlineTextS(this.text, {Key? key}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 50, 0, 10),
      child: Text(
        this.text,
        style: const TextStyle(
          fontSize: 25.0,
          color: Color(0xFF00338D),
          fontFamily: 'Inter',
          fontWeight: FontWeight.w700,
        ),
        textAlign: TextAlign.start,
      ),
    );
  }
}

class ImprintText extends StatelessWidget {
  const ImprintText(this.text, {bool this.underline = false, Key? key})
      : super(key: key);

  final String text;
  final bool underline;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
      child: Text(
        this.text,
        textAlign: TextAlign.start,
        style: TextStyle(
          decoration: (underline == true)
              ? TextDecoration.underline
              : TextDecoration.none,
          fontSize: 14.0,
          color: const Color(0xFF00338D),
          fontFamily: 'Inter',
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }
}

class ImprintTextS extends StatelessWidget {
  const ImprintTextS(this.text, {bool this.underline = false, Key? key})
      : super(key: key);

  final String text;
  final bool underline;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
      child: Text(
        this.text,
        textAlign: TextAlign.start,
        style: TextStyle(
          decoration:
              (underline) ? TextDecoration.underline : TextDecoration.none,
          fontSize: 18.0,
          color: const Color(0xFF00338D),
          fontFamily: 'Inter',
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }
}
