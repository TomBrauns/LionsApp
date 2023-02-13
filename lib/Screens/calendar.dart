import 'package:flutter/material.dart';

class Calendar extends StatefulWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
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
              title: const Text('Calendar'),
              onTap: () {
                // Push to Screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Calendar()),
                );
                // Push to Screen
                //Navigator.push(
                //  context,
                //  MaterialPageRoute(builder: (context) => AboutUs()),
                //);
                // Update State of App
                //Navigator.pop(context);
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
      appBar: AppBar(
        title: const Text("Calendar"),
      ),
    );
  }
}
