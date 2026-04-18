import 'package:flutter/material.dart';

void main() {
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
        scaffoldBackgroundColor: Colors.black,
        primaryColor: const Color(0xFFFF1493), // Neon Pink
      ),
      home: const Scaffold(
        body: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.black, Color(0xFF1A1A1A)],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.chat_bubble_outline, size: 100, color: Color(0xFFFF1493)),
              SizedBox(height: 20),
              Text(
                'VEX COMPANY',
                style: TextStyle(color: Colors.grey, letterSpacing: 5),
              ),
              Text(
                'ThinkChat',
                style: TextStyle(
                  color: Color(0xFFFF1493), 
                  fontSize: 45, 
                  fontWeight: FontWeight.bold,
                  shadows: [Shadow(color: Color(0xFFFF1493), blurRadius: 20)],
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Pink Nation is Ready! 🚀',
                style: TextStyle(color: Colors.white70, fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}