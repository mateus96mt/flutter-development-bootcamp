import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class Message {
  String text;
  String sender;
  DateTime timestamp;

  Message(this.text, this.sender, this.timestamp);
}

class ChatScreen extends StatefulWidget {
  static const String id = 'chat_screen';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController textEditingController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  final _fireStore = FirebaseFirestore.instance;

  void getCurrentChatUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        print("Logged user: ${user.email}");
      } else {
        print("user null");
      }
    } catch (e) {
      print(e);
    }
  }

  void getMessages() async {
    final messages = await _fireStore.collection('chat_rooms').get();
    for (var message in messages.docs) {
      print('${message.id}: ${message.data()}');
    }
  }

  void deleteMessages() async {
    final messages = await _fireStore.collection('messages').get();
    for (var message in messages.docs) {
      _fireStore.collection('messages').doc(message.id).delete();
    }
  }

  void messagesStream() async {
    await for (var snap in _fireStore.collection('chat_rooms').snapshots()) {
      for (var message in snap.docChanges) {
        print(message.doc.data());
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _auth.signOut();
  }

  @override
  void initState() {
    super.initState();
    getCurrentChatUser();
    // getMessages();
    messagesStream();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                //Implement logout functionality
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: textEditingController,
                      onChanged: (value) {
                        //Do something with the user input.
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      String textToSend = textEditingController.text;
                      this.textEditingController.clear();
                      setState(() {});
                      final user = _auth.currentUser;
                      _fireStore
                          .collection('messages')
                          .add(
                            {
                              'text': textToSend,
                              'sender': user.email,
                              'timestamp': DateTime.now().toIso8601String()
                            },
                          )
                          .then((value) {})
                          .catchError(
                            (onError) {
                              showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: Text('An error has ocurred!'),
                                  content: Text('Error: ${onError.toString()}'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, 'OK'),
                                      child: const Text('OK'),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
            StreamBuilder<QuerySnapshot>(
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final messages = snapshot.data.docs;
                  List<Message> messagesObjects = [];
                  for (var message in messages) {
                    final messageJson = message.data() as Map<String, dynamic>;
                    final messageText = messageJson['text'];
                    final messageSender = messageJson['sender'];
                    final messageTimeStamp = messageJson['timestamp'];

                    final messageObject = Message(
                      messageText,
                      messageSender,
                      DateTime.tryParse(messageTimeStamp) ?? DateTime.now(),
                    );
                    messagesObjects.add(messageObject);
                  }

                  messagesObjects.sort((Message a, Message b) {
                    return a.timestamp.difference(b.timestamp).inMilliseconds;
                  });

                  return Expanded(
                    child: ListView(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      children: [
                        for (Message messageObj in messagesObjects)
                          Text(
                            // '${messageObj.timestamp.microsecondsSinceEpoch}',
                            '${messageObj.sender}: ${messageObj.text}\n',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          )
                      ],
                    ),
                  );
                  return Container();
                } else {
                  return Container();
                }
              },
              stream: _fireStore.collection('messages').snapshots(),
            ),
            FlatButton(
              color: Colors.redAccent,
              onPressed: () {
                deleteMessages();

                // DocumentReference<Map<String, dynamic>> doc = _fireStore
                //     .collection('chat_rooms')
                //     .doc('mateus96mt@gmail.com-angela@gmail.com');
                //
                // doc
                //     .collection('messages')
                //     .add({'teste': 'test'}).then((value) {
                //   print("FINISH");
                // });
                // // getMessages();
              },
              child: Text('DELETE ALL'),
            ),
          ],
        ),
      ),
    );
  }
}
