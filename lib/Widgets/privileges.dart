import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Privileges extends StatefulWidget {
  const Privileges({super.key});
  static String privilege = "Admin";
  @override
  State<Privileges> createState() => _PrivilegesState();
}

class _PrivilegesState extends State<Privileges> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
