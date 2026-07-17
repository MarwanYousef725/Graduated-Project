import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduated_project/features/profile/notifications/data/notification_model.dart';
import 'package:graduated_project/features/profile/notifications/logic/notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit() : super(NotificationsInitial());

  void loadNotifications() async {
    emit(NotificationsLoading());
    await Future.delayed(const Duration(milliseconds: 500));

    final today = [
      NotificationModel(
        id: '1',
        title: 'Prescription Approved',
        description:
            'Your prescription for Amoxicillin has been verified and is ready for checkout.',
        time: '2m ago',
        isRead: false,
        type: NotificationType.prescription,
        actionText: 'Checkout Now',
      ),
      NotificationModel(
        id: '2',
        title: 'Order Out for Delivery',
        description:
            'Order #ORD-8829 is on the way! Our courier is expected to arrive within 30 mins.',
        time: '1h ago',
        isRead: false,
        type: NotificationType.order,
      ),
    ];

    final yesterday = [
      NotificationModel(
        id: '3',
        title: 'Weekend Flash Sale!',
        description:
            'Get 20% off on all wellness supplements this weekend. Use code: HEALTH20',
        time: '1d ago',
        isRead: true,
        type: NotificationType.sale,
      ),
      NotificationModel(
        id: '4',
        title: 'Refill Reminder',
        description:
            'Your Vitamin D3 supplies are running low. Would you like to re-order now?',
        time: '1d ago',
        isRead: true,
        type: NotificationType.reminder,
        actionText: 'Re-order',
        secondaryActionText: 'Not now',
      ),
    ];

    emit(NotificationsLoaded(today: today, yesterday: yesterday));
  }

  void markAllAsRead() {
  }
}
