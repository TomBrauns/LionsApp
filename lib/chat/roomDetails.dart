//Licensed under the EUPL v.1.2 or later
import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lionsapp/chat/rooms.dart';

import '../util/textSize.dart';
import '../util/image_upload.dart';

class UserInList {
  final String firstName;
  final String lastName;
  final String documentId;
  bool isSelected;
/*   List<bool> isSSelected = [true, false, false, false];
 */
  UserInList(
      {required this.firstName,
      required this.lastName,
      required this.documentId,
      this.isSelected = false});
}

class roomDetails extends StatefulWidget {
  final String? roomId;
  roomDetails({super.key, this.roomId});
  @override
  _roomDetailsState createState() => _roomDetailsState();
}

class _roomDetailsState extends State<roomDetails> {
  List<UserInList> _users = [];

  Room currentRoom = const Room(id: '', type: null, users: []);
  final TextEditingController roomNameController = TextEditingController();
  final TextEditingController roomDescriptionController =
      TextEditingController();
  String imgURL = '';

  @override
  void initState() {
    super.initState();
    if (widget.roomId == null) return;
    FirebaseChatCore.instance.room(widget.roomId!).first.then(
      (room) {
        roomNameController.text = room.name!;
        roomDescriptionController.text = room.metadata!["Beschreibung"];

        currentRoom = room;
        // Get the current user ID
        String currentUserId = firebase.FirebaseAuth.instance.currentUser!.uid;
        // Get the list of users from Firestore
        FirebaseFirestore.instance
            .collection('user_chat')
            .get()
            .then((snapshot) {
          // Filter the list to remove the current user
          List<UserInList> filteredUsers = snapshot.docs
              .where((document) => document.id != currentUserId)
              .map(
            (DocumentSnapshot document) {
              return UserInList(
                firstName: document.get('firstName'),
                lastName: document.get('lastName'),
                documentId: document.id,
                isSelected: currentRoom.users
                    .map((user) => user.id)
                    .contains(document.id),
              );
            },
          ).toList();
          setState(() {
            imgURL = currentRoom.imageUrl!;
            _users = filteredUsers;
          });
        });
      },
    );
  }

  void getUsers() async {}

  List<UserInList> getSelectedUsers() {
    return _users.where((user) => user.isSelected).toList();
  }

  List<UserInList> _filteredUsers() {
    return _users
        .where((user) =>
            user.firstName.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            user.lastName.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
  }

  String roomImg = "";
  String _searchQuery = "";

  void _handleEventImageUpload() async {
    final XFile? file = await ImageUpload.selectImage();
    if (file != null) {
      final String uniqueFilename =
          DateTime.now().millisecondsSinceEpoch.toString();
      final String? imgUrl = await ImageUpload.uploadImage(
          file, "room_images", "", uniqueFilename);
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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("${roomNameController.text} bearbeiten"),
        actions: [
          IconButton(
            onPressed: () {
              showMyDialog();
            },
            icon: const Icon(Icons.delete_forever),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: SizedBox(
              height: 60,
              width: double.infinity,
              child: GestureDetector(
                onTap: _handleEventImageUpload,
                child: Container(
                  child: roomImg.isNotEmpty
                      ? Image.network(roomImg)
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.upload, size: 40),
                            Text("Bild auswählen", style: CustomTextSize.small),
                          ],
                        ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextFormField(
              controller: roomNameController,
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Name der Gruppe',
                enabled: true,
                contentPadding:
                    EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
              ),
              onChanged: (value) {},
              keyboardType: TextInputType.text,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextFormField(
              controller: roomDescriptionController,
              minLines: 2,
              maxLines: 2,
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Beschreibung der Gruppe',
                enabled: true,
                contentPadding:
                    EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
              ),
              onChanged: (value) {},
              keyboardType: TextInputType.text,
            ),
          ),
          Container(
            height: 70,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                onChanged: (value) {
                  setState(
                    () {
                      _searchQuery = value;
                    },
                  );
                },
                decoration: const InputDecoration(
                  hintText: 'Lions suchen',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.only(top: 3),
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              child: ListView.builder(
                itemCount: _filteredUsers().length,
                itemBuilder: (context, index) {
                  final user = _filteredUsers()[index];

                  /* _users[index].isSelected = currentRoom.users.map((user) => user.id).contains(_users[index].documentId);*/
                  return CheckboxListTile(
                    value: user.isSelected,
                    title: Row(
                      children: [
                        const Icon(Icons.person),
                        const SizedBox(width: 10),
                        Text('${user.firstName} ${user.lastName}',
                            style: CustomTextSize.small),
                      ],
                    ),
                    onChanged: (newValue) {
                      setState(
                        () {
                          _users[index].isSelected = newValue!;
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 77),
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
          userList.add(
            User(
              id: firebase.FirebaseAuth.instance.currentUser!.uid,
            ),
          );
          currentRoom.users.clear();
          currentRoom.users.addAll(userList);
          final name = roomNameController.text.trim();
          FirebaseChatCore.instance.updateRoom(currentRoom);
          updateRoomName(
              imgURL, roomNameController.text, roomDescriptionController.text);
        },
        child: const Icon(Icons.check),
      ),
    );
  }

  Widget? buildImageFromFirebase() {
    try {
      return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('rooms')
            .doc(currentRoom.id)
            .snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            print('Error: ${snapshot.error}');
            return const Icon(Icons.person, size: 50);
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
            return const Icon(Icons.person, size: 50);
          }
        },
      );
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateRoomName(
    String? newImgUrl,
    String? newRoomName,
    String? newRoomDescription,
  ) async {
    final docRef =
        FirebaseFirestore.instance.collection('rooms').doc(widget.roomId);

    Map<String, dynamic> dataToUpdate = {};

    dataToUpdate['name'] = newRoomName;
    dataToUpdate['metadata.Beschreibung'] = newRoomDescription;
    dataToUpdate['imageUrl'] = newImgUrl;

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

  Future<void> showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Wollen Sie den Chatraum wirklich löschen?'),
                Text('Die Vorgang kann nicht rückgängig gemacht werden'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Abbrechen'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: const Text('Bestätigen'),
              onPressed: () {
                FirebaseChatCore.instance.deleteRoom(widget.roomId!);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Ihr Chatraum wurde gelöscht',
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.green,
                  ),
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RoomsPage()),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
