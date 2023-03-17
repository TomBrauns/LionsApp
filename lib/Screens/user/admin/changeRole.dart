//Licensed under the EUPL v.1.2 or later
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lionsapp/Widgets/burgermenu.dart';
import 'package:lionsapp/Widgets/bottomNavigationView.dart';
import 'package:lionsapp/Widgets/appbar.dart';
import 'package:lionsapp/Widgets/privileges.dart';
import 'package:lionsapp/util/textSize.dart';

class CallAdmin extends StatefulWidget {
  CallAdmin({Key? key}) : super(key: key);

  @override
  State<CallAdmin> createState() => _CallAdminState();
}

class _CallAdminState extends State<CallAdmin> {
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
  final _userStream = FirebaseFirestore.instance
      .collection('users')
      .snapshots()
      .map((snapshot) => snapshot.docs);
  final currentUserUid = FirebaseAuth.instance.currentUser!.uid;

  String _searchQuery = "";

  @override
  Widget build(BuildContext context) {
    return Privileges.privilege == Privilege.admin
        ? Column(
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
                child: StreamBuilder<
                    List<QueryDocumentSnapshot<Map<String, dynamic>>>>(
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

                    final users = snapshot.data!.where((user) =>
                        user.id != currentUserUid &&
                        ((user.get("email") as String)
                                .toLowerCase()
                                .contains(_searchQuery.toLowerCase()) ||
                            (user.get("firstname") as String)
                                .toLowerCase()
                                .contains(_searchQuery.toLowerCase()) ||
                            (user.get("lastname") as String)
                                .toLowerCase()
                                .contains(_searchQuery.toLowerCase())));

                    return ListView.builder(
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        final user = users.elementAt(index);
                        return ListTile(
                          title:
                              Text("${user["firstname"]} ${user["lastname"]}"),
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
          )
        : Center(
            child: Column(children: [
            Padding(padding: EdgeInsets.fromLTRB(0, 250, 0, 0)),
            Text('ERROR: 500', style: CustomTextSize.large),
            Padding(padding: EdgeInsets.fromLTRB(0, 50, 0, 0)),
            Text('nicht die benötigten Berechtigungen vorhanden',
                style: CustomTextSize.medium),
            Padding(padding: EdgeInsets.fromLTRB(0, 50, 0, 0)),
            Image.asset(
              "assets/images/gandalf.gif",
            ),
            Padding(padding: EdgeInsets.fromLTRB(0, 50, 0, 0)),
            Text('You shall not pass!', style: CustomTextSize.large),
          ]));
  }
}
