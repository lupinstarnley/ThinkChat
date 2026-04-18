import 'package:flutter/material.dart';
import '../../app_config.dart';
import '../chat/vex_ai_chat.dart';

class HomeNavigation extends StatefulWidget {
  const HomeNavigation({super.key});

  @override
  State<HomeNavigation> createState() => _HomeNavigationState();
}

class _HomeNavigationState extends State<HomeNavigation> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('ThinkChat', style: TextStyle(color: AppConfig.primaryPink, fontWeight: FontWeight.bold)),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppConfig.primaryPink,
          tabs: const [Tab(text: 'CHATS'), Tab(text: 'STATUS'), Tab(text: 'CALLS')],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildChatList(),
          const Center(child: Text("Status Coming Soon...")),
          const Center(child: Text("Calls Coming Soon...")),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppConfig.primaryPink,
        child: const Icon(Icons.bolt, color: Colors.white),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const VexAIChatScreen()));
        },
      ),
    );
  }

  Widget _buildChatList() {
    return ListView(
      children: [
        ListTile(
          leading: const CircleAvatar(backgroundColor: AppConfig.surfaceDark, child: Text("🚀")),
          title: const Text("Pink Nation", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          subtitle: const Text("Welcome to VEX HQ", style: TextStyle(color: Colors.grey)),
          onTap: () {},
        ),
        ListTile(
          leading: const CircleAvatar(backgroundColor: AppConfig.surfaceDark, child: Icon(Icons.auto_awesome, color: AppConfig.primaryPink)),
          title: const Text("VEX AI", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          subtitle: const Text("Ask me anything...", style: TextStyle(color: Colors.grey)),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const VexAIChatScreen()));
          },
        ),
      ],
    );
  }
}