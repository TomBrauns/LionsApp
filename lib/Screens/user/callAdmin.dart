import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lionsapp/Widgets/burgermenu.dart';
import 'package:lionsapp/Widgets/bottomNavigationView.dart';
import 'package:lionsapp/Widgets/appbar.dart';

class callAdmin extends StatefulWidget {
  callAdmin({Key? key}) : super(key: key);

  @override
  State<callAdmin> createState() => _callAdminState();
}

class _callAdminState extends State<callAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const BurgerMenu(),
        appBar: const MyAppBar(title: "Rollen Verwalten"),
        bottomNavigationBar: BottomNavigation(),
        body: Center(
          child: Column(
            children: [
              SizedBox(height: 50),
              Text("Alle Nutzer: "),
              listAllUsersWidget(),
            ],
          ),
        ));
  }
}

// Function to list all users stored in Firestore
Future<List> listUsers() async {
  try {
    final usersRef = FirebaseFirestore.instance.collection('users');
    final usersSnapshot = await usersRef.get();
    final users = [];
    usersSnapshot.docs.forEach((doc) {
      final userData = doc.data();
      users.add(userData);
    });
    return users;
  } catch (error) {
    print('Error listing users: $error');
    return [];
  }
}

class listAllUsersWidget extends StatefulWidget {
  const listAllUsersWidget({super.key});
  @override
  State<listAllUsersWidget> createState() => _listAllUsersWidgetState();
}

class _listAllUsersWidgetState extends State<listAllUsersWidget> {
  final List<String> _roleOptions = ['friend', 'member', 'Admin'];
  Map<String, String?> _selectedRoles = {};
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
      future: FirebaseFirestore.instance.collection('users').get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
          final users = snapshot.data!.docs;

          return DataTable(
            columns: const [
              DataColumn(label: Text('Email')),
              DataColumn(
                label: Text('Rolle'),
                numeric: false,
                tooltip: 'Rolle auswählen',
              ),
            ],
            rows: [
              for (var user in users)
                DataRow(
                  cells: [
                    DataCell(
                      Text('${user['email']}'),
                    ),
                    DataCell(
                      DropdownButton<String>(
                        value: _selectedRoles[user.id] ?? user['rool'],
                        onChanged: (String? newValue) {
                          // Update the user's role in Firestore
                          user.reference.update({'rool': newValue});
                          setState(() {
                            _selectedRoles[user.id] = newValue;
                          });
                        },
                        items: _roleOptions.map(
                          (String option) {
                            return DropdownMenuItem<String>(
                              value: option,
                              child: Text(option),
                            );
                          },
                        ).toList(),
                      ),
                    ),
                  ],
                ),
            ],
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
