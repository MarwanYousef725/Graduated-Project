import 'package:flutter/material.dart';
import 'package:graduated_project/core/theme/app_colors.dart';

import '../../data/notification_model.dart';

class NotificationCard extends StatelessWidget {
  final NotificationModel notification;

  const NotificationCard({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildIcon(),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          notification.title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textDark,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              notification.time,
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppColors.textGrey,
                              ),
                            ),
                            if (!notification.isRead) ...[
                              const SizedBox(width: 4),
                              Container(
                                width: 8,
                                height: 8,
                                decoration: const BoxDecoration(
                                  color: AppColors.primaryTeal,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      notification.description,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.textGrey,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (notification.actionText != null) ...[
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (notification.secondaryActionText != null)
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      notification.secondaryActionText!,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                if (notification.secondaryActionText != null)
                  const SizedBox(width: 8),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    notification.actionText!,
                    style: const TextStyle(
                      color: AppColors.primaryTeal,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildIcon() {
    Color bgColor;
    Color iconColor;
    IconData icon;

    switch (notification.type) {
      case NotificationType.prescription:
        bgColor = const Color(0xFFE8F5E9);
        iconColor = const Color(0xFF4CAF50);
        icon = Icons.sync;
        break;
      case NotificationType.order:
        bgColor = const Color(0xFFE3F2FD);
        iconColor = const Color(0xFF2196F3);
        icon = Icons.inventory_2_outlined;
        break;
      case NotificationType.sale:
        bgColor = const Color(0xFFFFF3E0);
        iconColor = const Color(0xFFFF9800);
        icon = Icons.card_giftcard;
        break;
      case NotificationType.reminder:
        bgColor = const Color(0xFFF3E5F5);
        iconColor = const Color(0xFF9C27B0);
        icon = Icons.access_time;
        break;
    }

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
      child: Icon(icon, color: iconColor, size: 24),
    );
  }
}
