import 'package:flutter/material.dart';
import 'package:lionsapp/Screens/agb.dart';
import 'package:lionsapp/Screens/calendar.dart';
import 'package:lionsapp/Screens/chat.dart';
import 'package:lionsapp/Screens/contact.dart';
import 'package:lionsapp/Screens/donation.dart';
import 'package:lionsapp/Screens/home.dart';
import 'package:lionsapp/Screens/imprint.dart';
import 'package:lionsapp/Screens/projects/catalogue.dart';
import 'package:lionsapp/Screens/projects/project.dart';
import 'package:lionsapp/Screens/projects/project_editor.dart';
import 'package:lionsapp/Screens/user/user_configs.dart';
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
  // TODO: Chaträume
  '/Chat': (context) =>
      Chat(), // '/Chat/Chatroom' + Chatroom.roomId: (context) => Chatroom(chatroomId: chatroomId),
  '/Calendar': (context) => Calendar(),
  '/Events': (context) => Events(),
  // TODO: Route for Catalogue
  '/Catalogue': (context) => Catalogue(),
  '/Catalogue/ProjectEditor': (context) =>
      ProjectEditor(), // '/Catalogue/Project' + Project.documentId: (context) => Project(documentId: documentId,),
  '/Imprint': (context) => Imprint(),
  '/Contact': (context) => Contact(),
  '/EULA': (context) => AGB(),
  '/Login': (context) => LoginPage(),
  '/Register': (context) => Register(),
};
