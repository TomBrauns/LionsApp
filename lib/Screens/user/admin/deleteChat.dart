import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lionsapp/Widgets/burgermenu.dart';
import 'package:lionsapp/Widgets/bottomNavigationView.dart';
import 'package:lionsapp/Widgets/appbar.dart';

class deleteChat extends StatefulWidget {
  deleteChat({Key? key}) : super(key: key);

  @override
  State<deleteChat> createState() => _deleteChatState();
}

class _deleteChatState extends State<deleteChat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(drawer: const BurgerMenu(), appBar: const MyAppBar(title: "Chats löschen"), bottomNavigationBar: BottomNavigation(), body: const ChatRoomList());
  }
}

class ChatRoomList extends StatefulWidget {
  const ChatRoomList({Key? key}) : super(key: key);

  @override
  State<ChatRoomList> createState() => _ChatRoomListState();
}

class _ChatRoomListState extends State<ChatRoomList> {
  final _chatRoomStream = FirebaseFirestore.instance.collection('rooms').where("type", isEqualTo: 'group').snapshots().map((snapshot) => snapshot.docs);
  String _searchQuery = "";

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          onChanged: (value) {
            setState(() {
              _searchQuery = value;
            });
          },
          decoration: const InputDecoration(hintText: 'Suchen', border: OutlineInputBorder(), prefixIcon: Icon(Icons.search)),
        ),
      ),
      Expanded(
          child: StreamBuilder<List<QueryDocumentSnapshot<Map<String, dynamic>>>>(
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

                final groupChats = rooms.where((room) => (room.get("name") as String).toLowerCase().contains(_searchQuery.toLowerCase()));

                return ListView.builder(
                  itemCount: groupChats.length,
                  itemBuilder: (context, index) {
                    final room = groupChats.elementAt(index);
                    return ListTile(
                      title: Text("${room["name"]}"),
                    );
                  },
                );
              }))
    ]);
  }
}
