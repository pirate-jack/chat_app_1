import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {

  final String message;
  final bool isCurrentUser;
  const ChatBubble({super.key, required this.message, required this.isCurrentUser});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(message,style: TextStyle(color: Colors.white),),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color:isCurrentUser ?  Colors.green : Colors.blue.shade500,
      ),
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(vertical: 5,horizontal: 25),
    );
  }
}