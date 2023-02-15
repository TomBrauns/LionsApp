import 'package:flutter/material.dart';
import 'package:lionsapp/Widgets/burgermenu.dart';
import 'friend.dart';
import 'member.dart';
import 'login.dart';

class Member extends StatefulWidget {
  const Member({Key? key}) : super(key: key);

  @override
  State<Member> createState() => _ProjectState();
}

class _ProjectState extends State<Member> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Member"),
      ),
      body: const Text("Hier folgt die MemberSite"),
    );
  }
}
