import 'package:flutter/material.dart';
import 'package:rehand/model/services/firebase_auth_services.dart';
import 'package:rehand/model/services/chat_service.dart';
import 'package:rehand/views/screens/doctor/chat/chat_room_doc.dart';
import 'package:rehand/views/widgets/user_tile.dart';

class DisplayPatient extends StatelessWidget {
  DisplayPatient({super.key});

  //chat & auth service
  final ChatService _chatService = ChatService();
  final FirebaseAuthService _authService = FirebaseAuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.shade200,
        title: const Padding(
          padding: EdgeInsets.only(left: 55.0),
          child: Text(
            'Available Patients ',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Color(0xFF724AB4),
            ),
          ),
        ),
      ),
      body: _buildUserList(),
    );
  }

  //list of uders except for the loggedIn user
  Widget _buildUserList() {
    return StreamBuilder(
      stream: _chatService.getPatientStream(),
      builder: (context, snapshot) {
        //error
        if (snapshot.hasError) {
          return const Text("Error");
        }
        //Loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading ..");
        }
        //return list view
        return ListView(
          children: snapshot.data!
              .map<Widget>((userData) => _buildUserListItem(userData, context))
              .toList(),
        );
      },
    );
  }

  //Buikd individual list tile for eacch user role = doctor
  Widget _buildUserListItem(
      Map<String, dynamic> userData, BuildContext context) {
    // display the selected users type doctor
    //and as prevention of displaying current user even though it's a type patient
    if (userData["email"] != _authService.getCurrentUser()!.email) {
      return UserTile(
        text: " ${userData["username"]} ",
        onTap: () {
          //when we tap on user we go to chatr page
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatRoomDoc(
                receiverUsername: userData["username"],
                receiverID: userData["uid"],
              ),
            ),
          );
        },
      );
    } else {
      return Container();
    }
  }
}
