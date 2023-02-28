import 'package:flutter/material.dart';
import 'package:lionsapp/chat/chat.dart';
import 'package:lionsapp/chat/rooms.dart';
import 'package:lionsapp/login/agb.dart';
import 'package:lionsapp/Screens/calendar.dart';
import 'package:lionsapp/Screens/contact.dart';
import 'package:lionsapp/Screens/donation.dart';
import 'package:lionsapp/Screens/events/event_editor.dart';
import 'package:lionsapp/Screens/home.dart';
import 'package:lionsapp/Screens/imprint.dart';
import 'package:lionsapp/Screens/payment/paymethode.dart';
import 'package:lionsapp/Screens/projects/catalogue.dart';
import 'package:lionsapp/Screens/projects/project_editor.dart';
import 'package:lionsapp/Screens/donation_received.dart';
import 'package:lionsapp/Screens/user/user_configs.dart';
import 'package:lionsapp/Screens/user_type.dart';
import 'package:lionsapp/login/login.dart';
import 'package:lionsapp/login/register.dart';
import 'package:lionsapp/Screens/user/userUpdate.dart';
import 'package:lionsapp/Screens/events/events_liste.dart';

var routes = <String, WidgetBuilder>{
  '/': (context) => HomePage(),
  '/User': (context) => User(),
  '/User/Data': (context) => Update(),
  '/User/Accessibility': (context) => Accessibility(),
  '/User/Subs': (context) => Subs(),
  '/Donations': (context) => Donations(),
  '/Donations/UserType': (context) => UserTypeScreen(),
  '/Donations/UserType/Login': (context) => LoginPage(),
  '/Donations/UserType/PayMethode': (context) => Paymethode(),
  //'//Donations/UserType/PayMethode/Success':(context) => PaySuccess(),
  //'//Donations/UserType/PayMethode/Failure':(context) => PayFailure(),
  '/ThankYou': (context) => DonationReceived(),
  '/ThankYou/ShareDonation': (context) => ShareDonation(),
  '/ThankYou/Receipt': (context) => Receipt(),
  // TODO: Chaträume
  '/Chat': (context) => RoomsPage(),
  //'/Chat/Chatroom' + Chatroom.roomId: (context) => Chatroom(chatroomId: chatroomId),
  //'/Chat/Chatroom' + Chatroom.roomId + "/Settings": (context) => ChatroomSettings(chatroomId: chatroomId)
  '/Calendar': (context) => Calendar(),
  '/Events': (context) => Events(),
  '/Events/EventEditor': (context) => EventEditor(),
  //'/Events/EventDetailsPage' + EventDetailsPage.eventId: (context) => EventDetailsPage(eventId: EventDetailsPage.eventId,),
  //'/Events/EditDocumentPage' + Events.documentId: (context) => EditDocumentPage(documentId: Events.documentId),
  // TODO: Route for Catalogue
  '/Catalogue': (context) => Catalogue(),
  '/Catalogue/ProjectEditor': (context) => ProjectEditor(),
  //'/Catalogue/Project' + Project.documentId: (context) => Project(documentId: documentId),
  '/Imprint': (context) => Imprint(),
  '/Contact': (context) => Contact(),
  '/EULA': (context) => AGB(),
  '/Login': (context) => LoginPage(),
  '/Register': (context) => Register(),
  '/LogOut': (context) => LogOut(),
};
