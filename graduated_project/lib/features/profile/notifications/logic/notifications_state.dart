import 'package:graduated_project/features/profile/notifications/data/notification_model.dart';

abstract class NotificationsState {}

class NotificationsInitial extends NotificationsState {}

class NotificationsLoading extends NotificationsState {}

class NotificationsLoaded extends NotificationsState {
  final List<NotificationModel> today;
  final List<NotificationModel> yesterday;

  NotificationsLoaded({required this.today, required this.yesterday});
}

class NotificationsError extends NotificationsState {
  final String message;
  NotificationsError(this.message);
}
