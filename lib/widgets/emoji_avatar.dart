import 'package:flutter/material.dart';
import '../app_config.dart';

class EmojiAvatar extends StatelessWidget {
  final String avatarType; // 'emoji', 'image', au 'letter'
  final String? avatarContent;
  final double radius;
  final bool hasGlow;

  const EmojiAvatar({
    super.key,
    required this.avatarType,
    this.avatarContent,
    this.radius = 25,
    this.hasGlow = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: hasGlow ? [
          BoxShadow(
            color: AppConfig.primaryPink.withOpacity(0.3),
            blurRadius: 10,
            spreadRadius: 2,
          )
        ] : null,
      ),
      child: CircleAvatar(
        radius: radius,
        backgroundColor: AppConfig.surfaceDark,
        backgroundImage: (avatarType == 'image' && avatarContent != null)
            ? NetworkImage(avatarContent!)
            : null,
        child: (avatarType != 'image')
            ? Text(
                avatarContent ?? "?",
                style: TextStyle(
                  fontSize: radius * 0.8,
                  color: AppConfig.primaryPink,
                  fontWeight: FontWeight.bold,
                ),
              )
            : null,
      ),
    );
  }
}