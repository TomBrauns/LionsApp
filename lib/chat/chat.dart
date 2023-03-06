import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:lionsapp/Screens/user/user_configs.dart';
import 'package:lionsapp/chat/roomDetails.dart';
import 'package:mime/mime.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({
    super.key,
    required this.room,
    this.name,
  });

  final types.Room room;
  final String? name;
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  bool _isAttachmentUploading = false;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle.light,
          title: Text(widget.room.type == types.RoomType.direct ? widget.name! : widget.room.name!),
          actions: [
            if (widget.room.type == types.RoomType.group)
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => roomDetails(
                        roomId: widget.room.id,
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.edit),
              ),
          ],
        ),
        body: StreamBuilder<types.Room>(
          initialData: widget.room,
          stream: FirebaseChatCore.instance.room(widget.room.id),
          builder: (context, snapshot) => StreamBuilder<List<types.Message>>(
            initialData: const [],
            stream: FirebaseChatCore.instance.messages(snapshot.data!),
            builder: (context, snapshot) => Chat(
              showUserNames: true,
              showUserAvatars: true,
              isAttachmentUploading: _isAttachmentUploading,
              messages: snapshot.data ?? [],
              onAttachmentPressed: _handleAttachmentPressed,
              onMessageTap: _handleMessageTap,
              onPreviewDataFetched: _handlePreviewDataFetched,
              onSendPressed: _handleSendPressed,
              user: types.User(
                id: FirebaseChatCore.instance.firebaseUser?.uid ?? '',
              ),
            ),
          ),
        ),
      );

  void _handleAttachmentPressed() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) => SafeArea(
        child: SizedBox(
          height: 144,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _handleImageSelection();
                },
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Foto'),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _handleFileSelection();
                },
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Datei'),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Abbrechen'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleFileSelection() async {
    final XFile? file = await ImagePicker().pickImage(source: ImageSource.gallery);
    final name = file!.name;
    final reference = FirebaseStorage.instance.ref('files_sent_in_rooms').child(widget.room.id).child(name);
    //Web
    final bytes = await file!.readAsBytes();
    await reference.putData(bytes);

    final uri = await reference.getDownloadURL();
    /* Size */
    final size = await file.length();
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final author = types.User(id: userId);
    //MSG SENDING
    final message = types.PartialFile(
      name: name,
      size: size,
      uri: uri,
    );

    FirebaseChatCore.instance.sendMessage(
      message,
      widget.room.id,
    );
  }

  bool _permissionGranted = false;
  final ImagePicker _picker = ImagePicker();

  Future<void> _checkPermission() async {
    final status = await Permission.photos.request();
    setState(() {
      _permissionGranted = status == PermissionStatus.granted;
    });
  }

  Future<void> _handleImageSelection() async {
    if (kIsWeb) {
      final XFile? file = await ImagePicker().pickImage(source: ImageSource.gallery);
      final name = file!.name;
      final reference = FirebaseStorage.instance.ref('images_sent_in_rooms').child(widget.room.id).child(name);
      //Web
      final bytes = await file!.readAsBytes();
      await reference.putData(bytes);

      final uri = await reference.getDownloadURL();
      /* Size */
      final size = await file.length();

      //MSG SENDING
      final message = types.PartialImage(
        name: name,
        size: size,
        uri: uri,
      );

      FirebaseChatCore.instance.sendMessage(
        message,
        widget.room.id,
      );
    } else {
      //HANDY
      if (defaultTargetPlatform == TargetPlatform.iOS) {
        await _checkPermission();
      }
      //final result = await _picker.getImage(source: ImageSource.gallery),;

      final result = await _picker.getImage(source: ImageSource.gallery);

      /*var result = await ImagePicker().pickImage(
            imageQuality: 70,
            maxWidth: 1440,
            source: ImageSource.camera
        );*/

      if (result != null) {
        _setAttachmentUploading(true);
        final file = File(result.path);
        final size = file.lengthSync();
        final bytes = await result.readAsBytes();
        final image = await decodeImageFromList(bytes);
        final name = "Test";
        //final name = result.name;

        try {
          final reference = FirebaseStorage.instance.ref('images_sent_in_rooms').child(widget.room.id).child(name);
          await reference.putFile(file);
          final uri = await reference.getDownloadURL();

          final message = types.PartialImage(
            height: image.height.toDouble(),
            name: name,
            size: size,
            uri: uri,
            width: image.width.toDouble(),
          );

          FirebaseChatCore.instance.sendMessage(
            message,
            widget.room.id,
          );
          _setAttachmentUploading(false);
        } finally {
          _setAttachmentUploading(false);
        }
      } else {
        print("Kein Bild ausgewählt");
      }
    }

    _setAttachmentUploading(false);
  }

  void _handleMessageTap(BuildContext _, types.Message message) async {
    if (message is types.FileMessage) {
      var localPath = message.uri;

      if (message.uri.startsWith('http')) {
        try {
          final updatedMessage = message.copyWith(isLoading: true);
          FirebaseChatCore.instance.updateMessage(
            updatedMessage,
            widget.room.id,
          );

          final client = http.Client();
          final request = await client.get(Uri.parse(message.uri));
          final bytes = request.bodyBytes;
          final documentsDir = (await getApplicationDocumentsDirectory()).path;
          localPath = '$documentsDir/${message.name}';

          if (!File(localPath).existsSync()) {
            final file = File(localPath);
            await file.writeAsBytes(bytes);
          }
        } finally {
          final updatedMessage = message.copyWith(isLoading: false);
          FirebaseChatCore.instance.updateMessage(
            updatedMessage,
            widget.room.id,
          );
        }
      }

      await OpenFilex.open(localPath);
    }
  }

  void _handlePreviewDataFetched(
    types.TextMessage message,
    types.PreviewData previewData,
  ) {
    final updatedMessage = message.copyWith(previewData: previewData);

    FirebaseChatCore.instance.updateMessage(updatedMessage, widget.room.id);
  }

  void _handleSendPressed(types.PartialText message) {
    FirebaseChatCore.instance.sendMessage(
      message,
      widget.room.id,
    );
  }

  void _setAttachmentUploading(bool uploading) {
    setState(() {
      _isAttachmentUploading = uploading;
    });
  }
}
