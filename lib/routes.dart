import 'package:flutter/material.dart';
import 'package:lionsapp/Screens/user/admin/admin_history.dart';
import 'package:lionsapp/Screens/user/admin/changeRole.dart';
import 'package:lionsapp/Screens/user/admin/deleteChat.dart';
import 'package:lionsapp/Screens/user/admin/deleteUser.dart';
import 'package:lionsapp/Screens/user/changePassword.dart';
import 'package:lionsapp/Screens/user/history.dart';
import 'package:lionsapp/chat/chat.dart';
import 'package:lionsapp/chat/rooms.dart';
import 'package:lionsapp/login/agb.dart';
import 'package:lionsapp/Screens/meetings/calendar.dart';
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
  '/': (context) => const HomePage(),
  '/User': (context) => const User(),
  '/User/Data': (context) => Update(),
  '/User/Accessibility': (context) => const Accessibility(),
  '/User/Subs': (context) => const Subs(),
  '/User/ChangePW': (context) => changePw(),
  '/ChangeRole': (context) => CallAdmin(),
  '/deleteChat': (context) => DeleteChat(),
  '/deleteUser': (context) => DeleteUser(),
  '/History': (context) => History(),
  '/AdminHistory': (context) => AdminHistory(),
  '/Donations': (context) => const Donations(),
  '/Donations/UserType': (context) => UserTypeScreen(),
  '/Donations/UserType/Login': (context) => const LoginPage(),
  '/Donations/UserType/PayMethode': (context) => const Paymethode(
        amount: 0,
        Id: "",
        sub: "",
        Idtype: "",
      ),
  '/Donations/UserType/PayMethode/success': (context) =>
      const Paymethodesuccess(
        amount: 0,
        Id: "",
        sub: "",
        Idtype: "",
      ),
  '/Donations/UserType/PayMethode/cancel': (context) => const Paymethodecancel(
        amount: 0,
        Id: "",
        sub: "",
        Idtype: "",
      ),
  //'//Donations/UserType/PayMethode/Success':(context) => PaySuccess(),
  //'//Donations/UserType/PayMethode/Failure':(context) => PayFailure(),
  '/ThankYou': (context) => DonationReceived(
        amount: 0,
        Id: "",
        sub: "",
        Idtype: "",
      ),
  '/ThankYou/ShareDonation': (context) => const ShareDonation(),
  '/ThankYou/Receipt': (context) => const Receipt(),
  // TODO: Chaträume
  '/Chat': (context) => const RoomsPage(),
  //'/Chat/Chatroom' + Chatroom.roomId: (context) => Chatroom(chatroomId: chatroomId),
  //'/Chat/Chatroom' + Chatroom.roomId + "/Settings": (context) => ChatroomSettings(chatroomId: chatroomId)
  '/Calendar': (context) => const Calendar(),
  '/Events': (context) => const Events(),
  '/Events/EventEditor': (context) => const EventEditor(),
  //'/Events/EventDetailsPage' + EventDetailsPage.eventId: (context) => EventDetailsPage(eventId: EventDetailsPage.eventId,),
  //'/Events/EditDocumentPage' + Events.documentId: (context) => EditDocumentPage(documentId: Events.documentId),
  // TODO: Route for Catalogue
  '/Catalogue': (context) => const Catalogue(),
  '/Catalogue/ProjectEditor': (context) => const ProjectEditor(),
  //'/Catalogue/Project' + Project.documentId: (context) => Project(documentId: documentId),
  '/Imprint': (context) => const Imprint(),
  '/Contact': (context) => const Contact(),
  '/AGB': (context) => AGB(onRegister: false),
  '/Login': (context) => const LoginPage(),
  '/Register': (context) => Register(),
};
