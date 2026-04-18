class MessageModel {
  final int? id;
  final String senderId;
  final String? receiverId;
  final String? groupId;
  final String content;
  final String? mediaUrl;
  final String messageType; // 'text', 'image', 'video', 'voice', 'sticker'
  
  // Ticks Logic
  final bool isSent;
  final bool isDelivered;
  final bool isSeen;
  
  // Status Logic
  final bool isEdited;
  final bool isDeleted;
  final DateTime createdAt;

  MessageModel({
    this.id,
    required this.senderId,
    this.receiverId,
    this.groupId,
    required this.content,
    this.mediaUrl,
    this.messageType = 'text',
    this.isSent = true,
    this.isDelivered = false,
    this.isSeen = false,
    this.isEdited = false,
    this.isDeleted = false,
    required this.createdAt,
  });

  // Hii inabadilisha JSON kutoka Supabase kwenda kwenye MessageModel yetu
  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'],
      senderId: json['sender_id'],
      receiverId: json['receiver_id'],
      groupId: json['group_id'],
      content: json['content'] ?? '',
      mediaUrl: json['media_url'],
      messageType: json['message_type'] ?? 'text',
      isSent: json['is_sent'] ?? true,
      isDelivered: json['is_delivered'] ?? false,
      isSeen: json['is_seen'] ?? false,
      isEdited: json['is_edited'] ?? false,
      isDeleted: json['is_deleted'] ?? false,
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  // Hii inabadilisha MessageModel kwenda JSON ili kuituma Supabase
  Map<String, dynamic> toJson() {
    return {
      'sender_id': senderId,
      'receiver_id': receiverId,
      'group_id': groupId,
      'content': content,
      'media_url': mediaUrl,
      'message_type': messageType,
      'is_sent': isSent,
      'is_delivered': isDelivered,
      'is_seen': isSeen,
      'is_edited': isEdited,
      'is_deleted': isDeleted,
      // 'created_at' mara nyingi inatengenezwa na database yenyewe (NOW())
    };
  }
}