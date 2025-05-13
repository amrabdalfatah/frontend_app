import 'package:fashion_app/providers/stylist_provider.dart';
import 'package:fashion_app/widgets/chat_bubble.dart';
import 'package:fashion_app/widgets/message_input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fashion Stylist'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => context.read<StylistProvider>().clearChat(),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildChatList(context),
          const Divider(height: 1),
          MessageInput(
            onSend: (text) {
              context.read<StylistProvider>().sendMessage(text);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildChatList(BuildContext context) {
    final stylist = context.watch<StylistProvider>();

    if (stylist.messages.isEmpty) {
      return const Expanded(
        child: Center(child: Text('Ask me for fashion advice!')),
      );
    }

    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.all(8),
        reverse: true,
        itemCount: stylist.messages.length,
        itemBuilder: (context, index) {
          final message = stylist.messages.reversed.toList()[index];
          return ChatBubble(
            text: message.text,
            isMe: message.isUser,
            time: DateFormat('HH:mm').format(message.timestamp),
          );
        },
      ),
    );
  }
}
