enum NotificationType { prescription, order, sale, reminder }

class NotificationModel {
  final String id;
  final String title;
  final String description;
  final String time;
  final bool isRead;
  final NotificationType type;
  final String? actionText;
  final String? secondaryActionText;

  NotificationModel({
    required this.id,
    required this.title,
    required this.description,
    required this.time,
    required this.isRead,
    required this.type,
    this.actionText,
    this.secondaryActionText,
  });
}
