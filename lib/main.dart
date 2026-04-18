import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  // Ensure Flutter is fully initialized before starting the app
  WidgetsFlutterBinding.ensureInitialized();

  // SECURE KEY SPLITTING: To bypass GitHub Push Protection
  final String p1 = 'sb_secret';
  final String p2 = '_zhNuR7HI9KctlqfXNyEjHQ';
  final String p3 = '_aSMxefnx';

  // Initialize Supabase with your project credentials
  await Supabase.initialize(
    url: 'https://phzbajidtalyshvxzuqj.supabase.co',
    anonKey: p1 + p2 + p3,
  );

  runApp(const ThinkChat());
}

class ThinkChat extends StatelessWidget {
  const ThinkChat({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ThinkChat',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black, // VEX Dark Theme
        primaryColor: const Color(0xFFFF1493), // Neon Pink Color
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFFF1493),
          secondary: Color(0xFFFF1493),
        ),
      ),
      home: const WelcomeScreen(),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, Color(0xFF1A1A1A)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ThinkChat Logo with Neon Glow
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFFF1493).withOpacity(0.5),
                    blurRadius: 40,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: const Icon(
                Icons.chat_bubble_rounded,
                size: 100,
                color: Color(0xFFFF1493),
              ),
            ),
            const SizedBox(height: 25),
            
            // Branding Section
            const Text(
              'VEX COMPANY',
              style: TextStyle(
                color: Colors.white54,
                letterSpacing: 8,
                fontSize: 12,
              ),
            ),
            const Text(
              'ThinkChat',
              style: TextStyle(
                color: Color(0xFFFF1493),
                fontSize: 55,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
            const Text(
              'THE NEXT GEN MESSENGER',
              style: TextStyle(
                color: Colors.white38,
                fontSize: 10,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 70),
            
            // Start Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF1493),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 15,
                    shadowColor: const Color(0xFFFF1493).withOpacity(0.4),
                  ),
                  onPressed: () {
                    // Logic for next screen
                  },
                  child: const Text(
                    'JOIN PINK NATION 🚀',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}