import 'package:flutter/material.dart';
import 'package:menopause_app/features/chat/providers/chatProvider.dart';
import 'package:provider/provider.dart';
import 'package:menopause_app/features/chat/widgets/chat_bubble.dart';

class Chatbot extends StatefulWidget {
  const Chatbot({super.key});
  @override
  State<Chatbot> createState() => _ChatbotState();
}

class _ChatbotState extends State<Chatbot> {
  final TextEditingController _chatController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width - 200,
          height: MediaQuery.of(context).size.height - 200,
          constraints: const BoxConstraints(maxWidth: 700),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(children: [
            Expanded(
                child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: _buildMessages(context),
            )),
            _buildInputField(),
          ]),
        ),
      ),
    );
  }

  Widget _buildMessages(BuildContext context) {
    return Consumer<ChatProvider>(
      builder: (context, chatProvider, child) {
        return ListView.builder(
          itemCount: chatProvider.messages.length,
          itemBuilder: (context, index) {
            final message = chatProvider.messages[index];
            return Align(
              alignment: message['isUser'] == 'true'
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
              child: ChatBubble(
                message: message['message']!,
                isUser: message['isUser'] == 'true',
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildInputField() {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _chatController,
              decoration: const InputDecoration(
                hintText: 'Type a message',
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(50),
            ),
            child: IconButton(
              icon: const Icon(
                Icons.send,
                color: Colors.white,
              ),
              onPressed: () {
                if (_chatController.text.isNotEmpty) {
                  Provider.of<ChatProvider>(context, listen: false)
                      .addMessage(_chatController.text);
                  _chatController.clear();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
