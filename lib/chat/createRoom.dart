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

  List<UserInList> _filteredUsers() {
    return _users.where((user) => user.firstName.toLowerCase().contains(_searchQuery.toLowerCase()) || user.lastName.toLowerCase().contains(_searchQuery.toLowerCase())).toList();
  }

  String roomImg = "";
  final _userStream = FirebaseFirestore.instance.collection('user_chat').snapshots().map((snapshot) => snapshot.docs);
  String _searchQuery = "";

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
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: SizedBox(
              height: 100,
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
          ),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextFormField(
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
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextFormField(
              controller: descriptionController,
              minLines: 5,
              maxLines: 5,
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
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: const InputDecoration(
                hintText: 'Lions suchen',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              child: ListView.builder(
                itemCount: _filteredUsers().length,
                itemBuilder: (context, index) {
                  final user = _filteredUsers()[index];
                  return CheckboxListTile(
                    title: Row(
                      children: [
                        const Icon(Icons.person),
                        const SizedBox(width: 10),
                        Text('${user.firstName} ${user.lastName}'),
                      ],
                    ),
                    value: user.isSelected,
                    onChanged: (bool? value) {
                      setState(() {
                        user.isSelected = value!;
                      });
                    },
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 90),
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
          if (name.isNotEmpty) {
            await FirebaseChatCore.instance.createGroupRoom(
              imageUrl: roomImg,
              name: name,
              users: userList,
              metadata: {"Beschreibung": descriptionController.text},
            );
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const RoomsPage(),
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
