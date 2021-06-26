import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

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
                      final user = _auth.currentUser;
                      _fireStore.collection('chat_rooms').add(
                        {
                          'text': textEditingController.text,
                          'sender': user.email
                        },
                      ).then((value) {
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: Text('Message sended!'),
                            content: Text(
                                'The text message \'${textEditingController.text}\''),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () => Navigator.pop(context, 'OK'),
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        );
                      }).catchError(
                        (onError) {
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: Text('An error has ocurred!'),
                              content: Text('Error: ${onError.toString()}'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () => Navigator.pop(context, 'OK'),
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
            FlatButton(
              onPressed: () {
                DocumentReference<Map<String, dynamic>> doc = _fireStore
                    .collection('chat_rooms')
                    .doc('mateus96mt@gmail.com-angela@gmail.com');

                doc.collection('messages').add({'teste': 'test'}).then((value) {
                  print("FINISH");
                });
                // getMessages();
              },
              child: Text('TESTING'),
            ),
          ],
        ),
      ),
    );
  }
}
