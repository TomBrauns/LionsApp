import 'package:flutter/material.dart';
import 'package:lionsapp/Screens/user/user_configs.dart';
import 'package:lionsapp/Widgets/privileges.dart';
import 'package:lionsapp/routes.dart';

import 'burgermenu.dart';

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;

  const MyAppBar({Key? key, required this.title}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  _MyAppBarState createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(widget.title),
      actions: <Widget>[
        if (Privileges.privilege == "Member" ||
            Privileges.privilege == "Friend" ||
            Privileges.privilege == "Admin")
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.pop(context);
              /*Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const User()),
              );*/
              Navigator.pushNamed(context, '/User');
            },
          ),
      ],
    );
  }
}
