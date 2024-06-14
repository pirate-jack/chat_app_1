import 'package:chat_app/model/meassageModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatService{


  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<List<Map<String,dynamic>>> getUserStream(){
    return _firestore.collection('User').snapshots().map((snapshot){
      return snapshot.docs.map((doc){
        final user = doc.data();
        return user;
      }).toList();
    });
  }

  Future<void> sendMessage(String reciverID, message) async {
    final currentUserId = _auth.currentUser!.uid;
    final currentUserEmail = _auth.currentUser!.email;
    final Timestamp timestamp = Timestamp.now();

    Message newMessage = Message(
        senderID: currentUserId,
        senderEmail: currentUserEmail.toString(),
        reciverID: reciverID,
        message: message,
        timestamp: timestamp);

    List<String> ids = [currentUserId, reciverID];
    ids.sort();
    String chatRoomID = ids.join('_');

    await _firestore
        .collection('chat_rooms')
        .doc(chatRoomID)
        .collection('message')
        .add(newMessage.toMap());
  }

  Stream<QuerySnapshot> getMessages(String userID, otherUserID) {
    List<String> ids = [userID, otherUserID];
    ids.sort();
    String chatRoomID = ids.join('_');
    return _firestore
        .collection('chat_rooms')
        .doc(chatRoomID)
        .collection('message')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}