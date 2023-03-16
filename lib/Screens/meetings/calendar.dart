//Licensed under the EUPL v.1.2 or later
import 'package:calendar_view/calendar_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lionsapp/Screens/meetings/meeting.dart';
import 'package:lionsapp/Screens/meetings/meeting_editor.dart';
import 'package:lionsapp/Widgets/burgermenu.dart';
import 'package:lionsapp/Widgets/bottomNavigationView.dart';
import '../../Widgets/appbar.dart';
import '../../util/textSize.dart';
import '../../util/color.dart';
import '../events/event_details_page.dart';
import 'package:lionsapp/Widgets/privileges.dart';

class Calendar extends StatefulWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  void _handleAddEvent() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MeetingEditor()),
    );
  }

  // FAB with Priviledge
  //Copy that
  Widget? _getFAB() {
    if (Privileges.privilege == Privilege.admin ||
        Privileges.privilege == Privilege.member) {
      return FloatingActionButton(
        mini: true,
        onPressed: () => _handleAddEvent(),
        backgroundColor: ColorUtils.secondaryColor,
        child: const Icon(Icons.add),
      );
    } else {
      return null;
    }
  }

  final List<String> views = ["Monat", "Woche", "Tag"];
  late String currentView = views[0];

  void _handleViewChange(String? view) {
    setState(() {
      currentView = view ?? currentView;
    });
  }

  void _handleEventClicked(CalendarEventData<Object?> event) {
    final String id = event.event as String;
    final MaterialPageRoute route;
    if (id.startsWith("E_")) {
      route = MaterialPageRoute(
        builder: (context) =>
            EventDetailsPage(eventId: id.replaceAll("E_", "")),
      );
    } else {
      route = MaterialPageRoute(
        builder: (context) =>
            MeetingDetailsPage(meetingId: id.replaceAll("M_", "")),
      );
    }
    Navigator.push(context, route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const BurgerMenu(),
        appBar: const MyAppBar(title: "Kalender"),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomNavigation(),
        body: Privileges.privilege == Privilege.admin ||
                Privileges.privilege == Privilege.member
            ? StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection('events').snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> events) {
                  return StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('meetings')
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> meetings) {
                        final EventController eventController =
                            EventController();

                        if (events.hasData && events.data != null) {
                          eventController.addAll(events.data!.docs
                              .where((event) =>
                                  event.get("startDate") != null &&
                                  event.get("endDate") != null)
                              .map((event) => CalendarEventData(
                                  event: "E_${event.id}",
                                  title: event.get("eventName"),
                                  description: event.get("eventInfo"),
                                  startTime:
                                      (event.get("startDate") as Timestamp)
                                          .toDate(),
                                  endTime: (event.get("endDate") as Timestamp)
                                      .toDate(),
                                  date: (event.get("startDate") as Timestamp)
                                      .toDate(),
                                  color: const Color(0xFF407CCA),
                                  endDate: (event.get("endDate") as Timestamp)
                                      .toDate()))
                              .toList());
                        }

                        if (meetings.hasData && meetings.data != null) {
                          eventController.addAll(meetings.data!.docs
                              .where((meeting) =>
                                  meeting.get("startDate") != null &&
                                  meeting.get("endDate") != null)
                              .map((meeting) => CalendarEventData(
                                  event: "M_${meeting.id}",
                                  title: meeting.get("name"),
                                  description: meeting.get("description"),
                                  startTime:
                                      (meeting.get("startDate") as Timestamp)
                                          .toDate(),
                                  endTime: (meeting.get("endDate") as Timestamp)
                                      .toDate(),
                                  date: (meeting.get("startDate") as Timestamp)
                                      .toDate(),
                                  color: const Color(0xFFB3B2B1),
                                  endDate: (meeting.get("endDate") as Timestamp)
                                      .toDate()))
                              .toList());
                        }

                        return Column(children: [
                          DropdownButtonFormField(
                            value: currentView,
                            items: views
                                .map<DropdownMenuItem<String>>(((c) =>
                                    DropdownMenuItem(
                                        value: c,
                                        child: Text(c,
                                            style: CustomTextSize.small))))
                                .toList(),
                            onChanged: _handleViewChange,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder()),
                          ),
                          if (currentView == "Monat")
                            Expanded(
                                child: MonthView(
                                    headerStringBuilder: (dateTime,
                                        {secondaryDate}) {
                                      return DateFormat("LLLL yyyy")
                                          .format(dateTime);
                                    },
                                    controller: eventController,
                                    onEventTap: (e, d) =>
                                        _handleEventClicked(e))),
                          if (currentView == "Woche")
                            Expanded(
                                child: WeekView(
                                    controller: eventController,
                                    onEventTap: (e, d) =>
                                        _handleEventClicked(e.first))),
                          if (currentView == "Tag")
                            Expanded(
                                child: DayView(
                                    controller: eventController,
                                    onEventTap: (e, d) =>
                                        _handleEventClicked(e.first)))
                        ]);
                      });
                })
            : Container(child: Text('You shall not pass!')),
        floatingActionButton: _getFAB());
  }
}
