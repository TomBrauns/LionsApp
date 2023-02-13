//Missing References

import 'package:flutter/material.dart';

class BurgerMenu extends StatelessWidget {
  const BurgerMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text("Drawer Header"),
            ),
            ListTile(
              title: const Text('Item 1'),
              onTap: () {
                // Push to Screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AboutUs()),
                );
                // Update State of App
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Item 2'),
              onTap: () {
                // Update State of App
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
