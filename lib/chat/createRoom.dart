import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lionsapp/chat/rooms.dart';

import '../util/image_upload.dart';

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
  final TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getUsers();
  }

  void getUsers() async {
    // Get the current user ID
    String currentUserId = firebase.FirebaseAuth.instance.currentUser!.uid;
    // Get the list of users from Firestore
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('user_chat').get();
    // Filter the list to remove the current user
    List<UserInList> filteredUsers = snapshot.docs.where((document) => document.id != currentUserId).map(
      (DocumentSnapshot document) {
        return UserInList(
          firstName: document.get('firstName'),
          lastName: document.get('lastName'),
          documentId: document.id,
        );
      },
    ).toList();
    setState(
      () {
        _users = filteredUsers;
      },
    );
  }

  List<UserInList> getSelectedUsers() {
    return _users.where((user) => user.isSelected).toList();
  }

  String roomImg = "";

  void _handleEventImageUpload() async {
    final XFile? file = await ImageUpload.selectImage();
    if (file != null) {
      final String uniqueFilename = DateTime.now().millisecondsSinceEpoch.toString();
      final String? imgUrl = await ImageUpload.uploadImage(file, "room_images", "", uniqueFilename);
      if (imgUrl != null) {
        setState(
          () {
            roomImg = imgUrl;
          },
        );
      }
    }
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
          SizedBox(
            height: 200,
            width: double.infinity,
            child: GestureDetector(
              onTap: _handleEventImageUpload,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    width: 1,
                    color: Colors.grey,
                    style: BorderStyle.solid,
                  ),
                ),
                child: roomImg.isNotEmpty
                    ? Image.network(roomImg)
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.upload, size: 48),
                          Text("Bild auswählen"),
                        ],
                      ),
              ),
            ),
          ),
          const SizedBox(height: 80),
          TextFormField(
            controller: roomNameController,
            decoration: const InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: 'Name der Gruppe',
              enabled: true,
              contentPadding: EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
            ),
            onChanged: (value) {},
            keyboardType: TextInputType.text,
          ),
          const SizedBox(height: 60),
          TextFormField(
            controller: descriptionController,
            minLines: 7,
            maxLines: 15,
            decoration: const InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: 'Beschreibung der Gruppe',
              enabled: true,
              contentPadding: EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
            ),
            onChanged: (value) {},
            keyboardType: TextInputType.text,
          ),
          const SizedBox(height: 20),
          Expanded(
            child: SizedBox(
              child: ListView.builder(
                itemCount: _users.length,
                itemBuilder: (context, index) {
                  return CheckboxListTile(
                    title: Row(
                      children: [
                        Icon(Icons.person),
                        SizedBox(width: 10),
                        Text('${_users[index].firstName} ${_users[index].lastName}'),
                      ],
                    ),
                    value: _users[index].isSelected,
                    onChanged: (bool? value) {
                      setState(
                        () {
                          _users[index].isSelected = value!;
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          List<UserInList> selectedUsers = getSelectedUsers();
          List<User> userList = selectedUsers
              .map(
                (user) => User(
                  id: user.documentId,
                  firstName: user.firstName,
                  lastName: user.lastName,
                ),
              )
              .toList();
          final name = roomNameController.text.trim();
          if (name.isNotEmpty && userList.isNotEmpty) {
            await FirebaseChatCore.instance.createGroupRoom(
              imageUrl: roomImg,
              name: name,
              users: userList,
              metadata: {"Beschreibung": descriptionController.text},
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
