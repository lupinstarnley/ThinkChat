class ProfileModel {
  final String id;
  final String? username;
  final String? pushName;
  final String? phoneNumber;
  
  // Choice: 'image', 'emoji', au 'letter'
  final String avatarType; 
  final String? avatarContent; // URL, Unicode ya Emoji, au Herufi
  
  final String status;
  final DateTime lastSeen;

  ProfileModel({
    required this.id,
    this.username,
    this.pushName,
    this.phoneNumber,
    this.avatarType = 'letter',
    this.avatarContent,
    this.status = "Hey there! I am using ThinkChat.",
    required this.lastSeen,
  });

  // Inabadilisha JSON kutoka Supabase kwenda ProfileModel
  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'],
      username: json['username'],
      pushName: json['push_name'],
      phoneNumber: json['phone_number'],
      avatarType: json['avatar_type'] ?? 'letter',
      avatarContent: json['avatar_content'],
      status: json['status'] ?? "Hey there! I am using ThinkChat.",
      lastSeen: DateTime.parse(json['last_seen']),
    );
  }

  // Inabadilisha ProfileModel kwenda JSON kwa ajili ya ku-update database
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'push_name': pushName,
      'phone_number': phoneNumber,
      'avatar_type': avatarType,
      'avatar_content': avatarContent,
      'status': status,
      'last_seen': lastSeen.toIso8601String(),
    };
  }
}