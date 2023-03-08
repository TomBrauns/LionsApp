import 'package:flutter/material.dart';
import 'package:lionsapp/Widgets/privileges.dart';

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
        IconButton(
          padding: const EdgeInsets.only(right: 20),
          icon: const Icon(Icons.person),
          onPressed: () {
            Navigator.pop(context);
            if (Privileges.privilege == "Member" ||
                Privileges.privilege == "Friend" ||
                Privileges.privilege == "Admin") {
              /*Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const User()),
              );*/
              Navigator.pushNamed(context, '/User');
            } else {
              Navigator.pushNamed(context, '/Login');
            }
          },
        ),
      ],
    );
  }
}
