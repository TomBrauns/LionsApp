//Licensed under the EUPL v.1.2 or later
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
import 'package:lionsapp/Widgets/textSize.dart';
import 'package:lionsapp/chat/createRoom.dart';

import '../Widgets/bottomNavigationView.dart';
import '../Widgets/privileges.dart';
import '../firebase_options.dart';
import '../util/color.dart';
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
    final documentSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();
    final imageUrl = documentSnapshot.data()?['image_url'] ?? "";
    final firstname = documentSnapshot.data()?['firstname'] ?? "";
    final lastname = documentSnapshot.data()?['lastname'] ?? "";
    try {
      if (!docExists) {
        await FirebaseChatCore.instance.createUserInFirestore(
          types.User(
            id: FirebaseAuth.instance.currentUser!.uid,
            // UID from Firebase Authentication
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

  void _handleCreateChat() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RoomCreator()),
    );
  }

  void _createTwoPersonChat() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UsersPage()),
    );
  }

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
    signUpForChatUser();
  }

  // FAB with Privilege
  //Copy that
  Widget? _getFAB() {
    if (Privileges.privilege == Privilege.admin ||
        Privileges.privilege == Privilege.member) {
      return FloatingActionButton(
        mini: true,
        backgroundColor: ColorUtils.secondaryColor,
        onPressed: () => _handleCreateChat(),
        child: const Icon(Icons.add),
      );
    } else {
      return null;
    }
  }

  // and use Function for Fab in Scaffold
  Widget? _getBAB() {
    if (Privileges.privilege == Privilege.admin ||
        Privileges.privilege == Privilege.member) {
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _getFAB(),
      bottomNavigationBar: _getBAB(),
      appBar: AppBar(
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
          : Stack(
              children: [
                StreamBuilder<List<types.Room>>(
                  stream: FirebaseChatCore.instance.rooms(),
                  initialData: const [],
                  builder: (context, snapshot) {
                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(
                          bottom: 200,
                        ),
                        child: Text('Keine Chats vorhanden',
                            style: CustomTextSize.small),
                      );
                    }

                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final room = snapshot.data![index];
                        return StreamBuilder<List<types.Message>>(
                          initialData: const [],
                          stream: FirebaseChatCore.instance.messages(room, limit: 1),
                          builder: (context, msg) => Dismissible(
                            key: Key(room.id),
                            background: Container(
                              color: Colors.red,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  const Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(width: 16),
                                ],
                              ),
                            ),
                            confirmDismiss: (_) async {
                              if (Privileges.privilege == Privilege.admin) {
                                final confirm = await showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Chat löschen'),
                                      content: Text('Sind Sie sicher, den Chat "${room.name}" zu löschen?'),
                                      actions: [
                                        TextButton(
                                          child: const Text('Abbrechen'),
                                          onPressed: () {
                                            Navigator.of(context).pop(false);
                                          },
                                        ),
                                        TextButton(
                                          child: const Text('Löschen'),
                                          onPressed: () {
                                            Navigator.of(context).pop(true);
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                                if (confirm != null && confirm) {
                                  // Delete chat room
                                  await FirebaseChatCore.instance.deleteRoom(room.id);
                                  return true;
                                }
                                return false;
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Sie haben keine Berechtigungen, den Chat zu löschen.'),
                                  ),
                                );
                                return false;
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                color: Colors.grey[200],
                                border: Border.all(
                                  color: Colors.grey[400]!,
                                  width: 1.0,
                                ),
                              ),
                              margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                              child: InkWell(
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
                                  trailing: const Icon(Icons.arrow_forward_ios),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
                // FAB for the "Two Person Chat"

                Positioned(
                  bottom: 16,
                  right: 16,
                  child: FloatingActionButton(
                    mini: true,
                    backgroundColor: ColorUtils.secondaryColor,
                    onPressed: () {
                      if (Privileges.privilege == Privilege.admin ||
                          Privileges.privilege == Privilege.member) {
                        _createTwoPersonChat();
                      }
                    },
                    child: const Icon(Icons.chat),
                  ),
                ),
              ],
            ),
    );
  }

  String getLastMessageText(AsyncSnapshot<List<Message>> msg) {
    if (msg.hasData && msg.data!.length == 1 && msg.data!.first != null) {
      if (msg.data!.first.type == types.MessageType.text) {
        String text = (msg.data!.first as types.TextMessage).text;
        String truncatedText =
            text.length > 50 ? '${text.substring(0, 50)}...' : text;
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

    await FirebaseFirestore.instance
        .collection('user_chat')
        .doc(user!.uid)
        .update({"firstName": newFirstName});
    await FirebaseFirestore.instance
        .collection('user_chat')
        .doc(user.uid)
        .update({"lastName": newLastName});
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

    bool hasImage = room.imageUrl != null;
    final name = room.name ?? '';
    final defaultImage = Image.asset('assets/images/chat_image/default_image.png', fit: BoxFit.cover);

    return CircleAvatar(
      backgroundColor: hasImage ? Colors.transparent : color,
      backgroundImage: hasImage
          ? Image.network(room.imageUrl!,
        errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
          setState(() {
            hasImage = false;
          });
          return defaultImage;
        },
      ).image
          : defaultImage.image,
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
  const ScrollToUnreadOptions(
      {this.lastReadMessageId,
      this.scrollDelay = const Duration(milliseconds: 150),
      this.scrollDuration =
          ScrollDragController.momentumRetainStationaryDurationThreshold,
      this.scrollOnOpen = false,
      this.customBanner});

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
