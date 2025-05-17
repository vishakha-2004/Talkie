import 'package:chatflash/screens/StartScreen.dart';
import 'package:flutter/material.dart';
import 'package:chatflash/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  final messageController = TextEditingController();
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  late User loggedInUser;
  String username='';
  String message = '';
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  Future<void> getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        final userData =
        await _firestore.collection('users').doc(user.uid).get();
        setState(() {
          username = userData.data()?['username'] ?? 'Unknown';
        });

      }
    }
      catch(e){
        print(e);
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions:[
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                showDialog(context: context,
                    builder: (context){
                      return AlertDialog(
                        title: Text('Logout Confirm'),
                        content: Text('Are you sure you want to logout?'),
                        actions: [
                          TextButton(
                              onPressed: (){
                                Navigator.of(context).pop();
                              },
                              child: Text('Cancel'),
                          ),
                          TextButton(onPressed: (){
                            _auth.signOut();
                            Navigator.push(context, MaterialPageRoute(builder: (context){
                              return StartScreen();
                            }));
                          }, child: Text('Logout'),
                          )
                        ],
                      );
                    }
                );
              }
              ),
        ],
        title: Row(
          children: [
            Icon(Icons.chat, color: Colors.white,),
            SizedBox(width: 20,),
            Text('Chat'),
          ],
        ),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection('messages').orderBy('timestamp').snapshots(),
                  builder: (context, snapshot){
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (!snapshot.hasData || snapshot.data == null) {
                      return Text('No messages found');
                    } else {
                      final messages = snapshot.data!.docs;

                      List<Widget> msgWidgets = messages.map((msg) {
                        final data = msg.data() as Map<String, dynamic>;
                        final msgText = data['text'] ?? '';
                        final msgSender = data['sender'] ?? '';
                        final username = data['username'] ?? '';

                        return MsgBubble(sender: username, text: msgText, isMe: loggedInUser.email == msgSender);
                      }).toList();

                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        if (_scrollController.hasClients) {
                          _scrollController.animateTo(
                            _scrollController.position.maxScrollExtent,
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeOut,
                          );
                        }
                      });


                      return ListView(
                        controller: _scrollController,
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                        children: msgWidgets,
                      );
                    }

                  },
              ),
            ),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      onChanged: (value) {
                        message = value;
                        //Do something with the user input.
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      messageController.clear();
                      _firestore.collection('messages').add({
                        'text': message,
                        'sender': loggedInUser.email,
                        'username': username,
                      'timestamp': FieldValue.serverTimestamp(),
                      });
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MsgBubble extends StatelessWidget {
  final String sender;
  final String text;
  final bool isMe;

  MsgBubble({required this.sender, required this.text, required this.isMe});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(sender ,style: TextStyle(color: Colors.grey, fontSize: 10),),
          Material(
            borderRadius: isMe
                ? BorderRadius.only(topLeft: Radius.circular(25),bottomLeft: Radius.circular(25), bottomRight: Radius.circular(25))
                :  BorderRadius.only(topRight: Radius.circular(25),bottomLeft: Radius.circular(25), bottomRight: Radius.circular(25)) ,
            elevation: 5,
            color: isMe ? Colors.blue : Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10,horizontal: 15),
              child: Text(text,
                style: TextStyle(fontSize: 15,
                    color: isMe ? Colors.white : Colors.blue),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
