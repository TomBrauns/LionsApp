import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

//Rollen: Admin, Guest, Member, Friend

class Privileges extends StatefulWidget {
  const Privileges({super.key});
  static String privilege = "Guest";
  @override
  State<Privileges> createState() => _PrivilegesState();
}

class _PrivilegesState extends State<Privileges> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
