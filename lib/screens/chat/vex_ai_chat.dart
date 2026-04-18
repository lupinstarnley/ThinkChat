import 'package:flutter/material.dart';
import '../../app_config.dart';
import '../../core/vex_ai_engine.dart';
import '../../widgets/chat_bubble.dart';

class VexAIChatScreen extends StatefulWidget {
  const VexAIChatScreen({super.key});

  @override
  State<VexAIChatScreen> createState() => _VexAIChatScreenState();
}

class _VexAIChatScreenState extends State<VexAIChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final VexAIEngine _aiEngine = VexAIEngine();
  
  // List ya muda ya kuhifadhi mazungumzo ya sasa
  final List<Map<String, dynamic>> _messages = [
    {"isMe": false, "text": AppConfig.aiInitialMessage, "time": "Now"}
  ];

  bool _isTyping = false;

  void _handleSend() async {
    if (_controller.text.trim().isEmpty) return;

    String userQuery = _controller.text.trim();
    setState(() {
      _messages.insert(0, {"isMe": true, "text": userQuery, "time": "Now"});
      _isTyping = true;
    });
    _controller.clear();

    // Inapiga kodi ya Gemini API
    String aiResponse = await _aiEngine.askVex(userQuery);

    setState(() {
      _isTyping = false;
      _messages.insert(0, {"isMe": false, "text": aiResponse, "time": "Now"});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConfig.backgroundDark,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          children: [
            const Icon(Icons.auto_awesome, color: AppConfig.primaryPink),
            const SizedBox(width: 10),
            Text(AppConfig.aiName, style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        actions: [
          IconButton(icon: const Icon(Icons.history, color: Colors.grey), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final m = _messages[index];
                return ChatBubble(
                  message: m["text"],
                  time: m["time"],
                  isMe: m["isMe"],
                );
              },
            ),
          ),
          
          if (_isTyping)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("VEX AI is thinking...", style: TextStyle(color: AppConfig.primaryPink, fontSize: 12)),
            ),

          // AI Input Field
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppConfig.surfaceDark,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: AppConfig.primaryPink.withOpacity(0.3)),
                    ),
                    child: TextField(
                      controller: _controller,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        hintText: "Ask VEX AI anything...",
                        hintStyle: TextStyle(color: Colors.white24),
                        contentPadding: EdgeInsets.symmetric(horizontal: 20),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                FloatingActionButton(
                  mini: true,
                  backgroundColor: AppConfig.primaryPink,
                  onPressed: _handleSend,
                  child: const Icon(Icons.bolt, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}