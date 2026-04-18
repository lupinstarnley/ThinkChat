import 'package:flutter/material.dart';

class AppConfig {
  // --- PROJECT IDENTITY ---
  static const String appName = "ThinkChat";
  static const String owner = "Lupin Starnley";
  static const String company = "VEX";

  // --- SUPABASE CONFIGURATION ---
  // These will be pulled from your environment variables in Codespaces/GitHub Secrets
  static const String supabaseUrl = String.fromEnvironment('SUPABASE_URL');
  static const String supabaseAnonKey = String.fromEnvironment('SUPABASE_ANON_KEY');

  // --- VEX AI (GEMINI) CONFIGURATION ---
  static const String geminiApiKey = String.fromEnvironment('GEMINI_API_KEY');

  // --- PINKLLY AESTHETIC THEME (NEON PINK & DARK) ---
  static const Color primaryPink = Color(0xFFFF4081); // Neon Pink Glow
  static const Color backgroundDark = Color(0xFF0A0A0A); // Premium Deep Black
  static const Color surfaceDark = Color(0xFF1E1E1E); // Translucent Grey for bubbles
  static const Color vexAIGlow = Color(0xFFD400FF); // Purple-Pink for VEX AI

  // --- CHAT LOGIC SETTINGS ---
  static const int editTimeLimitMinutes = 15;
  static const int statusExpiryHours = 12;
  static const int viewOnceExpiryHours = 6;
  
  // --- VEX AI DEFAULTS ---
  static const String aiName = "VEX AI";
  static const String aiInitialMessage = "Hello! I am VEX AI. How would you like to start today?";
}