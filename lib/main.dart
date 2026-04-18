import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'app_config.dart'; // Hapa tunasoma siri zetu
import 'screens/home/home_navigation.dart'; // Hapa ni baada ya kubonyeza Join

void main() async {
  // 1. Hakikisha Flutter imeamka kikamilifu
  WidgetsFlutterBinding.ensureInitialized();

  // 2. Washa Injini ya Supabase kwa kutumia Siri kutoka AppConfig
  await Supabase.initialize(
    url: AppConfig.supabaseUrl,
    anonKey: AppConfig.supabaseAnonKey,
  );

  runApp(const ThinkChat());
}

class ThinkChat extends StatelessWidget {
  const ThinkChat({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppConfig.appName,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: AppConfig.backgroundDark,
        primaryColor: AppConfig.primaryPink,
        colorScheme: const ColorScheme.dark(
          primary: AppConfig.primaryPink,
          secondary: AppConfig.primaryPink,
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
            // ThinkChat Logo with Neon Glow (VEX Style)
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppConfig.primaryPink.withOpacity(0.5),
                    blurRadius: 40,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: const Icon(
                Icons.chat_bubble_rounded,
                size: 100,
                color: AppConfig.primaryPink,
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
                color: AppConfig.primaryPink,
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
            
            // Start Button (Joining Pink Nation)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppConfig.primaryPink,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 15,
                    shadowColor: AppConfig.primaryPink.withOpacity(0.4),
                  ),
                  onPressed: () {
                    // Baadaye hapa itapeleka kwenye Auth/Login
                    // Kwa sasa tunaipeleka moja kwa moja kuona Tabs
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HomeNavigation()),
                    );
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