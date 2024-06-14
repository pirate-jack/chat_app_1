import 'package:chat_app/constans/app_constant.dart';
import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {

  final String text;
  VoidCallback onTap;

  UserTile({required this.text, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue.shade100,
          borderRadius: BorderRadius.circular(12),
        ),
        margin: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
        padding: EdgeInsets.only(top: 5,bottom: 5,left: 5),
        child: Row(
          children: [
            Icon(Icons.person),
            SizedBox(
              width: 10,
            ),
            Text(text,style: TextStyle(fontSize: 20,color: AppConstant.textColor),),
          ],
        ),
      ),
    );
  }
}