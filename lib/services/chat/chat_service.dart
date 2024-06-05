import 'package:chat_messenger_app/model/messages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class ChatService extends ChangeNotifier {
  // get instance of the auth and the firestore
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  // send messages
  Future<void> sendMessage(String receiverId, String message) async {
// get current user info
    final String currentUserId = _firebaseAuth.currentUser!.uid;
    final String currentUserEmail = _firebaseAuth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();

// create a new message
    Messages newMessage = Messages(
      senderId: currentUserId,
      senderEmail: currentUserEmail,
      receiverId: receiverId,
      message: message,
      timestamp: timestamp,
    );

// construct chat room id  from current user id and receiver id (sorted to ensure uniqueness)
    List<String> ids = [currentUserId, receiverId];
    print(currentUserId);
    print(receiverId);
    ids.sort(); // to ensure that chat room id is same for any pair of sender and receiver
    String ChatRoomId = ids.join("_"); //combine the ids into  a single string

// add new message to database
    await _fireStore
        .collection('chat_room')
        .doc(ChatRoomId)
        .collection('messages')
        .add(newMessage.toMap());
  }

  // get messages
  Stream<QuerySnapshot> getMessages(String userId, String otherUserId) {
    List<String> ids = [userId, otherUserId];
    ids.sort();
    print(ids);
    // ignore: non_constant_identifier_names
    String ChatRoomId = ids.join("_");
    print("ChatRoom $ChatRoomId");
    print(
        "DATA ${_fireStore.collection('chat_room').doc(ChatRoomId).collection('messages').orderBy('timestamp', descending: false).snapshots()}");
    return _fireStore
        .collection('chat_room')
        .doc(ChatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}
