//Licensed under the EUPL v.1.2 or later
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lionsapp/Widgets/burgermenu.dart';
import 'package:lionsapp/Widgets/bottomNavigationView.dart';
import 'package:lionsapp/Widgets/appbar.dart';

import '../../../util/textSize.dart';

class DeleteChat extends StatefulWidget {
  DeleteChat({Key? key}) : super(key: key);

  @override
  State<DeleteChat> createState() => _DeleteChatState();
}

class _DeleteChatState extends State<DeleteChat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const BurgerMenu(),
        appBar: const MyAppBar(title: "Chats löschen"),
        bottomNavigationBar: BottomNavigation(),
        body: const ChatRoomList());
  }
}

class ChatRoomList extends StatefulWidget {
  const ChatRoomList({Key? key}) : super(key: key);

  @override
  State<ChatRoomList> createState() => _ChatRoomListState();
}

class _ChatRoomListState extends State<ChatRoomList> {
  final _chatRoomStream = FirebaseFirestore.instance
      .collection('rooms')
      .where("type", isEqualTo: 'group')
      .snapshots()
      .map((snapshot) => snapshot.docs);
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
                prefixIcon: Icon(Icons.search)),
          ),
        ),
        Expanded(
          child:
              StreamBuilder<List<QueryDocumentSnapshot<Map<String, dynamic>>>>(
            stream: _chatRoomStream,
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

              final rooms = snapshot.data;
              if (rooms == null || rooms.isEmpty) {
                return const Center(
                  child: Text('No Chats found.'),
                );
              }

              final groupChats = rooms.where((room) =>
                  (room.get("name") as String)
                      .toLowerCase()
                      .contains(_searchQuery.toLowerCase()));

              return ListView.builder(
                itemCount: groupChats.length,
                itemBuilder: (context, index) {
                  final room = groupChats.elementAt(index);
                  return InkWell(
                    child: ListTile(
                      title: Text("${room["name"]}"),
                      onTap: () => showMyDialog(room.id, room['name']),
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

  Future<void> deleteRoom(String? roomID) async {
    await FirebaseFirestore.instance.collection('rooms').doc(roomID).delete();
    await FirebaseAuth.instance.currentUser!.delete();
  }

  Future<void> showMyDialog(String roomID, String roomName) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Wollen Sie den Chat $roomName wirklich löschen?',
                    style: CustomTextSize.small),
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
                deleteRoom(roomID);
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Chat wurde gelöscht',
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
