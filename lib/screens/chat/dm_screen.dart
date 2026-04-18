import 'package:flutter/material.dart';
import '../../app_config.dart';
import '../../core/supabase_client.dart';
import '../../models/message_model.dart';
import '../../models/profile_model.dart';
import '../../widgets/chat_bubble.dart';

class DMScreen extends StatefulWidget {
  final ProfileModel otherUser; // Mtumiaji unayechat naye

  const DMScreen({super.key, required this.otherUser});

  @override
  State<DMScreen> createState() => _DMScreenState();
}

class _DMScreenState extends State<DMScreen> {
  final TextEditingController _messageController = TextEditingController();
  final VexDatabase _db = VexDatabase();

  void _sendMessage() async {
    if (_messageController.text.trim().isEmpty) return;

    final newMessage = MessageModel(
      senderId: _db.currentUserId!,
      receiverId: widget.otherUser.id,
      content: _messageController.text.trim(),
      messageType: 'text',
      createdAt: DateTime.now(),
    );

    _messageController.clear();
    await _db.sendMessage(newMessage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConfig.backgroundDark,
      appBar: AppBar(
        backgroundColor: AppConfig.surfaceDark,
        titleSpacing: 0,
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: AppConfig.backgroundDark,
              child: Text(widget.otherUser.avatarContent ?? widget.otherUser.pushName![0],
                  style: const TextStyle(color: AppConfig.primaryPink)),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.otherUser.pushName ?? "User", 
                     style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const Text("Online", style: TextStyle(fontSize: 12, color: AppConfig.primaryPink)),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(icon: const Icon(Icons.videocam, color: AppConfig.primaryPink), onPressed: () {}),
          IconButton(icon: const Icon(Icons.call, color: AppConfig.primaryPink), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          // Sehemu ya Meseji (Real-time Stream)
          Expanded(
            child: StreamBuilder<List<MessageModel>>(
              stream: _db.getMessagesStream(widget.otherUser.id, null),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
                
                final messages = snapshot.data!;
                return ListView.builder(
                  reverse: true, // Meseji mpya zianzie chini
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final msg = messages[index];
                    return ChatBubble(
                      message: msg.content,
                      time: "${msg.createdAt.hour}:${msg.createdAt.minute}",
                      isMe: msg.senderId == _db.currentUserId,
                      isSent: msg.isSent,
                      isDelivered: msg.isDelivered,
                      isSeen: msg.isSeen,
                    );
                  },
                );
              },
            ),
          ),

          // Sehemu ya Kuandika (Input Field)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppConfig.surfaceDark,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: TextField(
                      controller: _messageController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        hintText: "VEX message...",
                        hintStyle: TextStyle(color: Colors.white24),
                        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                GestureDetector(
                  onTap: _sendMessage,
                  child: const CircleAvatar(
                    backgroundColor: AppConfig.primaryPink,
                    child: Icon(Icons.send, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}