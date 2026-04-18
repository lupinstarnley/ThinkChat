import 'package:flutter/material.dart';
import '../../app_config.dart';
import '../../core/supabase_client.dart';
import '../../models/profile_model.dart';
import '../home/home_navigation.dart';

class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final TextEditingController _nameController = TextEditingController();
  final VexDatabase _db = VexDatabase();
  
  String _selectedEmoji = "🚀"; // Emoji ya kuanzia
  bool _isLoading = false;

  final List<String> _emojiOptions = ["🚀", "💎", "🦁", "🔥", "👑", "⚡", "🕶️", "🦾"];

  Future<void> _saveProfile() async {
    if (_nameController.text.trim().isEmpty) return;

    setState(() => _isLoading = true);

    final String? userId = _db.currentUserId;
    if (userId != null) {
      final newProfile = ProfileModel(
        id: userId,
        pushName: _nameController.text.trim(),
        avatarType: 'emoji',
        avatarContent: _selectedEmoji,
        lastSeen: DateTime.now(),
      );

      await _db.updateProfile(newProfile);
      
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeNavigation()),
        );
      }
    }
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConfig.backgroundDark,
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "WHO ARE YOU?",
              style: TextStyle(color: AppConfig.primaryPink, letterSpacing: 4, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            
            // Emoji Selector Circle
            GestureDetector(
              onTap: () {
                // Hapa tunaweza kuongeza emoji picker kamili baadaye
              },
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppConfig.primaryPink, width: 2),
                  boxShadow: [BoxShadow(color: AppConfig.primaryPink.withOpacity(0.2), blurRadius: 20)],
                ),
                child: Text(_selectedEmoji, style: const TextStyle(fontSize: 60)),
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Emoji Grid
            Wrap(
              spacing: 10,
              children: _emojiOptions.map((e) => GestureDetector(
                onTap: () => setState(() => _selectedEmoji = e),
                child: Text(e, style: const TextStyle(fontSize: 30)),
              )).toList(),
            ),

            const SizedBox(height: 40),

            // Name Input
            TextField(
              controller: _nameController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Enter Push Name...",
                hintStyle: const TextStyle(color: Colors.white24),
                filled: true,
                fillColor: AppConfig.surfaceDark,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: const BorderSide(color: AppConfig.primaryPink)),
              ),
            ),

            const SizedBox(height: 30),

            // Save Button
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppConfig.primaryPink,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                ),
                onPressed: _isLoading ? null : _saveProfile,
                child: _isLoading 
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text("ENTER PINK NATION", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}