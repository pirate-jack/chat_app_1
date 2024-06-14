import 'package:chat_app/component/UserTile.dart';
import 'package:chat_app/component/drawer.dart';
import 'package:chat_app/firebase_services/authServices/firebase_service.dart';
import 'package:chat_app/firebase_services/chatServices/chatServices.dart';
import 'package:chat_app/screen/chatPage/chatpage.dart';

import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final AuthService _authService = AuthService();
  final ChatService _chatService = ChatService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade300,
        title: Text('HomePage'),
        centerTitle: true,
      ),
      drawer: MyDrawer(),
      body: _buildUserList(),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder(
        stream: _chatService.getUserStream(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('error');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text('Loading...');
          }
          return ListView(
            children: snapshot.data!
                .map<Widget>(
                    (userData) => _buildUserlistItem(userData, context))
                .toList(),
          );
        });
  }

  _buildUserlistItem(Map<String, dynamic> userData, BuildContext context) {
    if (userData['email'] != _authService.getCurrentUser()! .email) {
      return UserTile(
        text: userData['email'],
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatPage(reciverEmail: userData['email'], reciverID: userData['uid'],),
            ),
          );
        },
      );
    } else {
      return Container();
    }
  }
}
