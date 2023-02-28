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

class roomDetails extends StatefulWidget {
  final String? roomId;
  roomDetails({super.key, this.roomId});
  @override
  _roomDetailsState createState() => _roomDetailsState();
}

class _roomDetailsState extends State<roomDetails> {
  List<UserInList> _users = [];

  final TextEditingController roomNameController = TextEditingController();
  final TextEditingController roomDescriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.roomId == null) return;
    FirebaseFirestore.instance.collection("rooms").doc(widget.roomId).get().then(
          (room) => {
            roomNameController.text = room.get("name"),
            roomDescriptionController.text = room.get("metadata.Beschreibung"),
            setState(
              () {},
            )
          },
        );
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
        title: Text("${roomNameController.text} bearbeiten"),
      ),
      body: Column(
        children: [
          const SizedBox(height: 50),
          Container(
            child: buildImageFromFirebase(),
          ),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: const TextStyle(fontSize: 10),
            ),
            onPressed: () async {
              String? roomID = widget.roomId;
              final XFile? file = await ImageUpload.selectImage();
              if (file != null) {
                final String uniqueFilename = DateTime.now().millisecondsSinceEpoch.toString();
                final String? imageUrl = await ImageUpload.uploadImage(file, "room_images", roomID!, uniqueFilename);
                if (imageUrl != null) {
                  await FirebaseFirestore.instance.collection('rooms').doc(roomID).update({"imageUrl": imageUrl});
                }
              }
            },
            child: const Text('Profilbild ändern'),
          ),
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
                    : const Column(
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
            controller: roomDescriptionController,
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
                        const Icon(Icons.person),
                        const SizedBox(width: 10),
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
              .map((user) => User(
                    id: user.documentId,
                    firstName: user.firstName,
                    lastName: user.lastName,
                  ))
              .toList();
          updateRoom(roomNameController.text, roomDescriptionController.text);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const RoomsPage(),
            ),
          );
        },
        child: const Icon(Icons.check),
      ),
    );
  }

  Widget? buildImageFromFirebase() {
    try {
      final String? roomID = widget.roomId;
      return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection('rooms').doc(roomID).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            print('Error: ${snapshot.error}');
            return Icon(Icons.person, size: 50);
          } else {
            final data = snapshot.data?.data() as Map<String, dynamic>?;
            if (data != null && data.containsKey('imageUrl')) {
              String? imageUrl = data['imageUrl'] as String?;
              if (imageUrl != null) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    width: 100,
                    height: 100,
                  ),
                );
              }
            }
            return Icon(Icons.person, size: 50);
          }
        },
      );
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateRoom(
    String? newRoomName,
    String? newRoomDescription,
  ) async {
    final docRef = FirebaseFirestore.instance.collection('rooms').doc(widget.roomId);

    Map<String, dynamic> dataToUpdate = {};

    dataToUpdate['name'] = newRoomName;
    dataToUpdate['metadata.Beschreibung'] = newRoomDescription;

    if (dataToUpdate.isNotEmpty) {
      await docRef.update(dataToUpdate);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          content: Text('Chatgruppe erfolgreich aktualisiert!'),
        ),
      );
      Navigator.pushNamed(context, '/Chat');
    } else {
      print('No updates to perform');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text('Versuche es erneut'),
        ),
      );
    }
  }
}
