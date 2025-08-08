import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:simple_chat_app/models/messages_model.dart';

class ChatService {
  // Firestore database instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //get user stream
  Stream<List<Map<String, dynamic>>> getUserStream() {
    return _firestore.collection('Users').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final user = doc.data();
        return user;
      }).toList();
    });
  }

  //* send message
  Future<void> sendMessage(String receiverId, message) async {
    //* get user info
    final String currentUserId = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    //* create  a new message
    MessageModel newMessage = MessageModel(
      message: message,
      senderEmail: currentUserEmail,
      senderId: currentUserId,
      receiverId: receiverId,
      timestamp: timestamp,
    );

    //* build the chat by sort users id

    List<String> ids = [currentUserId, receiverId];
    ids.sort();
    String chatId = ids.join('_');

    //* add the new message to database

    await _firestore
        .collection("chat_rooms")
        .doc(chatId)
        .collection("messages")
        .add(newMessage.toMap());
  }

  //* get messages
  Stream<QuerySnapshot> getMessages(String userId, String otherId) {
    List<String> ids = [userId, otherId];
    ids.sort();
    String chatId = ids.join('_');

    return _firestore
        .collection("chat_rooms")
        .doc(chatId)
        .collection("messages")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }
}
