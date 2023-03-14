//Licensed under the EUPL v.1.2 or later
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

//Rollen: Admin, Guest, Member, Friend

enum Privilege {
  admin,
  guest,
  member,
  friend,
}

class Privileges extends StatefulWidget {
  const Privileges({super.key});
  static Privilege privilege = Privilege.guest;
  @override
  State<Privileges> createState() => _PrivilegesState();
}

class _PrivilegesState extends State<Privileges> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
