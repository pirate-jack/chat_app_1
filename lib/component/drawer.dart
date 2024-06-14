
import 'package:chat_app/firebase_services/authServices/firebase_service.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  void logout() {
    final _auth = AuthService();
    _auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey.shade300,
      child: Column(
        children: [
          DrawerHeader(
            child: Center(
              child: Icon(
                Icons.chat_outlined,
                color: Colors.grey,
                size: 50,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: ListTile(
              title: Text('H O M E'),
              leading: Icon(Icons.home_outlined),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: ListTile(
              title: Text('S E T T I N G S'),
              leading: Icon(Icons.settings),
              onTap: () {},
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: ListTile(
              title: Text('L O G O U T'),
              leading: Icon(Icons.logout_rounded),
              onTap: logout
            ),
          ),
         ],
      ),
    );
  }
}
