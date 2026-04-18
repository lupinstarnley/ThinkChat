import 'package:flutter/material.dart';
import '../app_config.dart';
import 'tick_icon.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final String time;
  final bool isMe;
  final bool isSent;
  final bool isDelivered;
  final bool isSeen;

  const ChatBubble({
    super.key,
    required this.message,
    required this.time,
    required this.isMe,
    this.isSent = true,
    this.isDelivered = false,
    this.isSeen = false,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        padding: const EdgeInsets.all(12),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        decoration: BoxDecoration(
          // Logic ya Rangi: Pink kwa Lupin, Grey kwa wengine
          gradient: isMe ? const LinearGradient(
            colors: [AppConfig.primaryPink, Color(0xFFFF80AB)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ) : null,
          color: isMe ? null : AppConfig.surfaceDark,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(15),
            topRight: const Radius.circular(15),
            bottomLeft: Radius.circular(isMe ? 15 : 0),
            bottomRight: Radius.circular(isMe ? 0 : 15),
          ),
          boxShadow: isMe ? [
            BoxShadow(
              color: AppConfig.primaryPink.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            )
          ] : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  time,
                  style: TextStyle(
                    color: isMe ? Colors.white70 : Colors.grey,
                    fontSize: 10,
                  ),
                ),
                if (isMe) const SizedBox(width: 5),
                if (isMe)
                  TickIcon(
                    isSent: isSent,
                    isDelivered: isDelivered,
                    isSeen: isSeen,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}