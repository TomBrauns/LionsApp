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
      body: const UserRoleList(),
    );
  }
}

class UserRoleList extends StatefulWidget {
  const UserRoleList({Key? key}) : super(key: key);

  @override
  State<UserRoleList> createState() => _UserRoleListState();
}

class _UserRoleListState extends State<UserRoleList> {
  final List<String> _roleOptions = ['Friend', 'Member', 'Admin'];
  final _userStream = FirebaseFirestore.instance.collection('users').snapshots().map((snapshot) => snapshot.docs);
  String _searchQuery = "";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            onChanged: (value) {
              setState(() {
                _searchQuery = value;
              });
            },
            decoration: const InputDecoration(
              hintText: 'Suchen',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.search),
            ),
          ),
        ),
        Expanded(
          child: StreamBuilder<List<QueryDocumentSnapshot<Map<String, dynamic>>>>(
            stream: _userStream,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              final users = snapshot.data!.where((user) => (user.get("email") as String).toLowerCase().contains(_searchQuery.toLowerCase()) || (user.get("firstname") as String).toLowerCase().contains(_searchQuery.toLowerCase()) || (user.get("lastname") as String).toLowerCase().contains(_searchQuery.toLowerCase()));

              return ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users.elementAt(index);
                  return ListTile(
                    title: Text("${user["firstname"]} ${user["lastname"]}"),
                    subtitle: Text(user["email"]),
                    trailing: DropdownButton<String>(
                      value: user['rool'],
                      onChanged: (String? newValue) {
                        user.reference.update({'rool': newValue});
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
                  );
                },
              );
            },
          ),
        )
      ],
    );
  }
}
