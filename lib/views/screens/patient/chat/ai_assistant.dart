import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

class GeminiChat extends StatefulWidget {
  const GeminiChat({super.key});

  @override
  State<GeminiChat> createState() => _GeminiChatState();
}

class _GeminiChatState extends State<GeminiChat> {
  final generationConfig = GenerationConfig(
    maxOutputTokens: 200, // Maximum response length (words)
  );

  final Gemini gemini = Gemini.instance;

  List<ChatMessage> messages = [];

  ChatUser currentUser = ChatUser(id: "0", firstName: "User");
  ChatUser geminiUser = ChatUser(
    id: "1",
    firstName: "Gemini",
    profileImage:
        "https://seeklogo.com/images/G/google-gemini-logo-A5787B2669-seeklogo.com.png",
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.shade200,
        elevation: 10,
        title: const Padding(
          padding: EdgeInsets.only(left: 50.0),
          child: Text(
            "Chat with Gemini",
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    return DashChat(
      currentUser: currentUser,
      onSend: _sendMessage,
      messages: messages,
    );
  }

  void sendChatMessage(
      ChatMessage chatMessage, GenerationConfig generationConfig) async {
    try {
      final question = chatMessage.text;

      // Update UI with user message
      setState(() {
        messages = [chatMessage, ...messages];
      });

      // Generate response from Gemini
      final responseStream = gemini.streamGenerateContent(question,
          generationConfig: generationConfig);

      await for (final event in responseStream) {
        final response = event.content?.parts?.fold(
                "", (previous, current) => "$previous ${current.text}") ??
            "";

        // Update UI with Gemini response
        setState(() {
          if (messages.isNotEmpty && messages.first.user == geminiUser) {
            // Update existing Gemini message
            final lastMessage = messages.removeAt(0);
            lastMessage.text += response;
            messages.insert(0, lastMessage);
          } else {
            // Add new Gemini message
            messages.insert(
                0,
                ChatMessage(
                    user: geminiUser,
                    createdAt: DateTime.now(),
                    text: response));
          }
        });
      }
    } catch (e) {
      // Handle error
    }
  }

  void _sendMessage(ChatMessage chatMessage) {
    sendChatMessage(chatMessage, generationConfig); // Use default config
  }
}
