import 'package:flutter/material.dart';
import 'package:lionsapp/Screens/user_configs.dart';

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final String privilege;

  const MyAppBar({Key? key, required this.title, required this.privilege})
      : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  _MyAppBarState createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(widget.title),
      actions: <Widget>[
        if (widget.privilege == "Member" ||
            widget.privilege == "Friend" ||
            widget.privilege == "Admin")
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const User()),
              );
            },
          ),
      ],
    );
  }
}
