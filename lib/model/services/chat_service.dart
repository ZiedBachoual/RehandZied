import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rehand/model/message.dart';

class ChatService {
  //get instance of firestore and auth
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //get user stream meaning available doctors
  Stream<List<Map<String, dynamic>>> getDoctorStream() {
    // go through users and return the user based on role = Doctor
    return _firestore
        .collection("users")
        .where("role", isEqualTo: "doctor")
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        final user = doc.data();
        return user;
      }).toList();
    });
  }

  //get user stream meaning available Patients
  Stream<List<Map<String, dynamic>>> getPatientStream() {
    // go through users and return the user based on role = Doctor
    return _firestore
        .collection("users")
        .where("role", isEqualTo: "patient")
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        final user = doc.data();
        return user;
      }).toList();
    });
  }

  //send message
  Future<void> sendMessage(String receiverID, message) async {
    //get current user info
    final String currentUserID = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    //create a new message
    Message newMessage = Message(
        senderID: currentUserID,
        senderEmail: currentUserEmail,
        receiverID: receiverID,
        message: message,
        timestamp: timestamp);

    //contruct a chat room ID for both users (the ID has to be unique for  securityreasons)
    List<String> ids = [currentUserID, receiverID];
    ids.sort(); //sort the ids to ensure thechatroom ID is the same for any 2 people
    String chatRoomID = ids.join('_');

    //add new message to the Database
    await _firestore
        .collection("chat_rooms")
        .doc(chatRoomID)
        .collection("messages")
        .add(newMessage.toMap());
  }

  //get message
  Stream<QuerySnapshot> getMessages(String userID, otherUserID) {
    //contruct a chatroom ID for the 2 users
    List<String> ids = [userID, otherUserID];
    ids.sort();
    String chatRoomID = ids.join('_');

    return _firestore
        .collection("chat_rooms")
        .doc(chatRoomID)
        .collection("messages")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }
}
