import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lionsapp/Widgets/burgermenu.dart';
import 'package:lionsapp/Widgets/bottomNavigationView.dart';
import 'package:lionsapp/Widgets/appbar.dart';

import '../../../Widgets/privileges.dart';
import '../../../Widgets/textSize.dart';

class deleteUser extends StatefulWidget {
  deleteUser({Key? key}) : super(key: key);

  @override
  State<deleteUser> createState() => _deleteUserState();
}

class _deleteUserState extends State<deleteUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const BurgerMenu(),
      appBar: const MyAppBar(title: "Nutzer löschen"),
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
  final _userStream = FirebaseFirestore.instance.collection('users').snapshots().map((snapshot) => snapshot.docs);
  final currentUserUid = FirebaseAuth.instance.currentUser!.uid;

  String _searchQuery = "";

  Future<void> deleteAcc(String? uid) async {
    await FirebaseFirestore.instance.collection('users').doc(uid).delete();
    await FirebaseAuth.instance.currentUser!.delete();
  }

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

              final users = snapshot.data!.where(
                (user) =>
                    user.id != currentUserUid &&
                    ((user.get("email") as String).toLowerCase().contains(_searchQuery.toLowerCase()) ||
                        (user.get("firstname") as String).toLowerCase().contains(_searchQuery.toLowerCase()) ||
                        (user.get("lastname") as String).toLowerCase().contains(
                              _searchQuery.toLowerCase(),
                            )),
              );

              return ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users.elementAt(index);
                  return InkWell(
                    child: ListTile(
                      title: Text("${user["firstname"]} ${user["lastname"]}"),
                      subtitle: Text(user["email"]),
                      onTap: () => showMyDialog(user.id, user['firstname'], user['lastname']),
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

  Future<void> showMyDialog(String id, String firstName, String lastName) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Wollen Sie den Account von $firstName $lastName wirklich löschen?', style: CustomTextSize.small),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Abbrechen', style: CustomTextSize.small),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: Text('Bestätigen', style: CustomTextSize.small),
              onPressed: () {
                deleteAcc(id);
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Der Account von wurde gelöscht',
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.green,
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
