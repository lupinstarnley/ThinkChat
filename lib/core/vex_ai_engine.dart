import 'dart:convert';
import 'package:http/http.dart' as http;
import '../app_config.dart';

class VexAIEngine {
  // Tunatumia Google Gemini API URL
  final String _baseUrl = "https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent";

  // Mchakato wa kuomba jibu kutoka kwa VEX AI
  Future<String> askVex(String prompt, {String? userNickname}) async {
    try {
      final response = await http.post(
        Uri.parse("$_baseUrl?key=${AppConfig.geminiApiKey}"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "contents": [
            {
              "parts": [
                {
                  "text": "Your name is VEX AI, created by VEX Company (Owner: Lupin Starnley). "
                          "You are integrated into ThinkChat app. User's name is ${userNickname ?? 'User'}. "
                          "Be smart, helpful, and speak any language the user speaks. "
                          "Current query: $prompt"
                }
              ]
            }
          ]
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        // Tunavuta jibu la kwanza kutoka kwenye list ya Gemini
        return data['candidates'][0]['content']['parts'][0]['text'];
      } else {
        return "VEX AI is currently overthinking. Please try again in a bit, Lupin.";
      }
    } catch (e) {
      return "Connection error. VEX AI couldn't reach the brain.";
    }
  }

  // Logic ya kutengeneza picha (Hapa tutatumia Gemini Vision au DALL-E baadaye)
  Future<String> generateVexImage(String description) async {
    // Kwa sasa tunaweka placeholder, tutaiunganisha na Image API hatua inayofuata
    return "Image generation feature is being calibrated for VEX icon style...";
  }
}