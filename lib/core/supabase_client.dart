import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/profile_model.dart';
import '../models/message_model.dart';

class VexDatabase {
  final SupabaseClient _client = Supabase.instance.client;

  // --- AUTHENTICATION LOGIC ---
  
  // Kupata ID ya mtumiaji aliyepo sasa hivi
  String? get currentUserId => _client.auth.currentUser?.id;

  // --- PROFILE LOGIC ---

  // Kusoma profile ya mtumiaji mmoja
  Future<ProfileModel?> getProfile(String userId) async {
    final data = await _client
        .from('profiles')
        .select()
        .eq('id', userId)
        .single();
    return data != null ? ProfileModel.fromJson(data) : null;
  }

  // Ku-update profile (Username, Emoji PP, nk)
  Future<void> updateProfile(ProfileModel profile) async {
    await _client.from('profiles').upsert(profile.toJson());
  }

  // --- MESSAGING LOGIC ---

  // Kutuma meseji (DM au Group)
  Future<void> sendMessage(MessageModel message) async {
    await _client.from('messages').insert(message.toJson());
  }

  // Kusikiliza meseji mpya (Real-time Stream)
  Stream<List<MessageModel>> getMessagesStream(String? receiverId, String? groupId) {
    var query = _client.from('messages').stream(primaryKey: ['id']);
    
    if (groupId != null) {
      query = query.eq('group_id', groupId);
    } else if (receiverId != null) {
      // Hapa tunasoma meseji za DM (Tumezituma sisi au tumetumiwa sisi)
      // Logic hii itaboreshwa zaidi tukiingia kwenye DM Screen kitalamu
    }

    return query.map((data) => data.map((json) => MessageModel.fromJson(json)).toList());
  }

  // --- STORAGE LOGIC ---

  // Ku-upload picha ya Profile (Avatar)
  Future<String?> uploadAvatar(String fileName, dynamic fileBytes) async {
    final String path = await _client.storage.from('avatars').uploadBinary(
          fileName,
          fileBytes,
          fileOptions: const FileOptions(cacheControl: '3600', upsert: true),
        );
    return _client.storage.from('avatars').getPublicUrl(fileName);
  }
}