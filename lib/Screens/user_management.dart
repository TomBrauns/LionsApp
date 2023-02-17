import 'package:flutter/material.dart';
import 'package:lionsapp/Widgets/burgermenu.dart';

class UserManagement extends StatefulWidget {
  const UserManagement({Key? key}) : super(key: key);

  @override
  State<UserManagement> createState() => _UserManagementState();
}
// Admins can Manage the Roles of Users with this Screen
class _UserManagementState extends State<UserManagement> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const BurgerMenu(),
      appBar: AppBar(
        title: const Text(
            "Nutzerverwaltung"),
      ),
    );
  }
}