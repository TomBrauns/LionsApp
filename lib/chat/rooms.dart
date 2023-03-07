import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fbAuth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:lionsapp/Widgets/burgermenu.dart';
import 'package:lionsapp/chat/createRoom.dart';

import '../Widgets/bottomNavigationView.dart';
import '../Widgets/privileges.dart';
import '../firebase_options.dart';
import 'chat.dart';
import '../login/login.dart';
import 'users.dart';
import 'util.dart';

class RoomsPage extends StatefulWidget {
  const RoomsPage({super.key});

  @override
  State<RoomsPage> createState() => _RoomsPageState();
}

class _RoomsPageState extends State<RoomsPage> {
  bool _error = false;
  bool _initialized = false;
  fbAuth.User? _user;
  void signUpForChatUser() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final collectionRef = FirebaseFirestore.instance.collection('user_chat');
    final docRef = collectionRef.doc(userId);
    final docSnapshot = await docRef.get();
    final docExists = docSnapshot.exists;
    final user = FirebaseAuth.instance.currentUser!;
    final documentSnapshot = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
    final imageUrl = documentSnapshot.data()?['image_url'];
    final firstname = documentSnapshot.data()?['firstname'];
    final lastname = documentSnapshot.data()?['lastname'];
    try {
      if (!docExists) {
        await FirebaseChatCore.instance.createUserInFirestore(
          types.User(
            id: FirebaseAuth.instance.currentUser!.uid, // UID from Firebase Authentication
            imageUrl: imageUrl,
            firstName: firstname,
            lastName: lastname,
          ),
        );
      } else {
        updateUserWhenJoiningChat(firstname, lastname);
      }
    } catch (e) {}
  }

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
    signUpForChatUser();
  }
  Widget? _getBAB() {
    if (Privileges.privilege == "Admin" || Privileges.privilege == "Member") {
      return BottomNavigation();
    } else {
      return null;
    }
  }
  @override
  Widget build(BuildContext context) {
    if (_error) {
      return Container();
    }

    if (!_initialized) {
      return Container();
    }

    return Scaffold(
      bottomNavigationBar: _getBAB(),
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.group_add),
            onPressed: _user == null
                ? null
                : () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        fullscreenDialog: true,
                        builder: (context) => RoomCreator(),
                      ),
                    );
                  },
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _user == null
                ? null
                : () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        fullscreenDialog: true,
                        builder: (context) => const UsersPage(),
                      ),
                    );
                  },
          ),
        ],
        systemOverlayStyle: SystemUiOverlayStyle.light,
        title: const Text('Chats'),
      ),
      drawer: const BurgerMenu(),
      body: _user == null
          ? Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(
                bottom: 200,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Nicht angemeldet!'),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          fullscreenDialog: true,
                          builder: (context) => LoginPage(),
                        ),
                      );
                    },
                    child: const Text('Login'),
                  ),
                ],
              ),
            )
          : StreamBuilder<List<types.Room>>(
              stream: FirebaseChatCore.instance.rooms(),
              initialData: const [],
              builder: (context, snapshot) {
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(
                      bottom: 200,
                    ),
                    child: const Text('Keine Chats vorhanden'),
                  );
                }

                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final room = snapshot.data![index];
                    return StreamBuilder<List<types.Message>>(
                      initialData: const [],
                      stream: FirebaseChatCore.instance.messages(room, limit: 1),
                      builder: (context, msg) => InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ChatPage(
                                room: room,
                                name: room.name,
                              ),
                            ),
                          );
                        },
                        child: ListTile(
                          title: Text(room.name ?? ''),
                          subtitle: Text(getLastMessageText(msg)),
                          leading: _buildAvatar(room),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }

  String getLastMessageText(AsyncSnapshot<List<Message>> msg) {
    if (msg.hasData && msg.data!.length == 1 && msg.data!.first != null) {
      if (msg.data!.first.type == types.MessageType.text) {
        String text = (msg.data!.first as types.TextMessage).text;
        String truncatedText = text.length > 50 ? '${text.substring(0, 50)}...' : text;
        return ('${msg.data!.first.author.firstName} ${msg.data!.first.author.lastName}: $truncatedText');
      } else if (msg.data!.first.type == types.MessageType.image) {
        return ('${msg.data!.first.author.firstName} ${msg.data!.first.author.lastName} hat ein Bild geschickt');
      } else {
        return ('${msg.data!.first.author.firstName} ${msg.data!.first.author.lastName} hat eine Datei geschickt');
      }
    }
    return '';
  }

  Future<void> updateUserWhenJoiningChat(
    String? newFirstName,
    String? newLastName,
  ) async {
    final user = FirebaseAuth.instance.currentUser;

    await FirebaseFirestore.instance.collection('user_chat').doc(user!.uid).update({"firstName": newFirstName});
    await FirebaseFirestore.instance.collection('user_chat').doc(user.uid).update({"lastName": newLastName});
  }

  void initializeFlutterFire() async {
    try {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      FirebaseAuth.instance.authStateChanges().listen((user) {
        setState(() {
          _user = user;
        });
      });
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      setState(() {
        _error = true;
      });
    }
  }

  Widget _buildAvatar(types.Room room) {
    var color = Colors.transparent;

    if (room.type == types.RoomType.direct) {
      try {
        final otherUser = room.users.firstWhere(
          (u) => u.id != _user!.uid,
        );

        color = getUserAvatarNameColor(otherUser);
      } catch (e) {
        // Do nothing if other user is not found.
      }
    }

    final hasImage = room.imageUrl != null;
    final name = room.name ?? '';

    return CircleAvatar(
      backgroundColor: hasImage ? Colors.transparent : color,
      backgroundImage: hasImage ? NetworkImage(room.imageUrl!) : null,
      radius: 20,
      child: !hasImage
          ? Text(
              name.isEmpty ? '' : name[0].toUpperCase(),
              style: const TextStyle(color: Colors.white),
            )
          : null,
    );
  }
}

class ScrollToUnreadOptions {
  const ScrollToUnreadOptions({this.lastReadMessageId, this.scrollDelay = const Duration(milliseconds: 150), this.scrollDuration = ScrollDragController.momentumRetainStationaryDurationThreshold, this.scrollOnOpen = false, this.customBanner});

  /// Will show an unread messages header after this message if there are more
  /// messages to come and will scroll to this header on
  /// [ChatState.scrollToUnreadHeader].
  final String? lastReadMessageId;

  /// Duration to wait after open until the scrolling starts.
  final Duration scrollDelay;

  /// Duration for the animation of the scrolling.
  final Duration scrollDuration;

  /// Whether to scroll to the first unread message on open.
  final bool scrollOnOpen;

  /// Returns an optional custom override for presenting the unread banner.
  final Widget? customBanner;
}
