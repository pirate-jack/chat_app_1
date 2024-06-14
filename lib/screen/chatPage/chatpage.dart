import 'package:chat_app/component/chat_bubble.dart';
import 'package:chat_app/firebase_services/authServices/firebase_service.dart';
import 'package:chat_app/firebase_services/chatServices/chatServices.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  final String reciverEmail;
  final String reciverID;
      ChatPage({super.key, required this.reciverEmail, required this.reciverID});

  @override
  final TextEditingController _messageController = TextEditingController();

  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(reciverID, _messageController.text);
      _messageController.clear();
    }
  }
 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade300 ,
        title: Text(reciverEmail) ,
      ),
      body: Column(
        children: [Expanded(child: _messageList()), _buildUserInput(),SizedBox(height: 10,)],
      ),
    );
  }
  Widget _messageList() {
    String senderID = _authService.getCurrentUser()!.uid;
    return StreamBuilder(
      stream: _chatService.getMessages(reciverID, senderID),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text('Loading..');
        }
        return ListView(
            children: snapshot.data!.docs
                .map((doc) => _buildMeassageItem(doc))
                .toList());
      },
    );
  }

  Widget _buildMeassageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    bool isCurrentUser = data['senderID'] == _authService.getCurrentUser()!.uid;
    var alignment =
    isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
        alignment: alignment,
        child: Column(
          crossAxisAlignment:
          isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            ChatBubble(message: data['message'], isCurrentUser: isCurrentUser,)
          ],
        ));
  }

  Widget _buildUserInput() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          SizedBox(
            width: 5,
          ),
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                  hintText: 'Type message',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30))),
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Container(
              decoration:
              BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
              margin: EdgeInsets.only(right: 5),
              child: IconButton(
                  onPressed: sendMessage, icon: Icon(Icons.arrow_upward,color: Colors.white,)))
        ],
      ),
    );
  }
}
