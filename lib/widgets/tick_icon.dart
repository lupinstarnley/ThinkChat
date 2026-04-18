import 'package:flutter/material.dart';
import '../app_config.dart';

class TickIcon extends StatelessWidget {
  final bool isSent;
  final bool isDelivered;
  final bool isSeen;

  const TickIcon({
    super.key,
    required this.isSent,
    required this.isDelivered,
    required this.isSeen,
  });

  @override
  Widget build(BuildContext context) {
    // 1. Logic ya 2 Pink Ticks (Seen)
    if (isSeen) {
      return const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.done_all, size: 16, color: AppConfig.primaryPink),
        ],
      );
    }

    // 2. Logic ya 2 Grey Ticks (Delivered)
    if (isDelivered) {
      return const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.done_all, size: 16, color: Colors.grey),
        ],
      );
    }

    // 3. Logic ya 1 Grey Tick (Sent)
    if (isSent) {
      return const Icon(Icons.done, size: 16, color: Colors.grey);
    }

    // 4. Meseji ikiwa bado inapakia (Loading/Clock)
    return const Icon(Icons.access_time, size: 14, color: Colors.grey);
  }
}