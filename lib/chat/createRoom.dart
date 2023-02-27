import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:lionsapp/chat/rooms.dart';

class UserInList {
  final String firstName;
  final String lastName;
  final String documentId;
  bool isSelected;

  UserInList({required this.firstName, required this.lastName, required this.documentId, this.isSelected = false});
}

class RoomCreator extends StatefulWidget {
  @override
  _RoomCreatorState createState() => _RoomCreatorState();
}

class _RoomCreatorState extends State<RoomCreator> {
  List<UserInList> _users = [];

  final TextEditingController roomNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getUsers();
  }

  void getUsers() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('users_chat').get();
    setState(
      () {
        _users = snapshot.docs.map(
          (DocumentSnapshot document) {
            return UserInList(
              firstName: document.get('firstName'),
              lastName: document.get('lastName'),
              documentId: document.id,
            );
          },
        ).toList();
      },
    );
  }

  List<UserInList> getSelectedUsers() {
    return _users.where((user) => user.isSelected).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chatgruppe erstellen'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 50),
          const Icon(Icons.upload, size: 48),
          const Text("Gruppenbild auswählen"),
          const SizedBox(height: 80),
          TextFormField(
            controller: roomNameController,
            decoration: const InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: 'Name des Gruppe',
              enabled: true,
              contentPadding: EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
            ),
            onChanged: (value) {},
            keyboardType: TextInputType.text,
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: _users.length,
              itemBuilder: (context, index) {
                return CheckboxListTile(
                  title: Text('${_users[index].firstName} ${_users[index].lastName}'),
                  value: _users[index].isSelected,
                  onChanged: (bool? value) {
                    setState(() {
                      _users[index].isSelected = value!;
                    });
                  },
                );
              },
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          List<UserInList> selectedUsers = getSelectedUsers();
          List<User> userList = selectedUsers
              .map((user) => User(
                    id: user.documentId,
                    firstName: user.firstName,
                    lastName: user.lastName,
                  ))
              .toList();
          final name = roomNameController.text.trim();
          if (name.isNotEmpty && userList.isNotEmpty) {
            await FirebaseChatCore.instance.createGroupRoom(
              name: name,
              users: userList,
            );
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => RoomsPage(),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                backgroundColor: Colors.red,
                content: Text('Gruppename angeben'),
              ),
            );
          }
        },
        child: const Icon(Icons.check),
      ),
    );
  }
}
