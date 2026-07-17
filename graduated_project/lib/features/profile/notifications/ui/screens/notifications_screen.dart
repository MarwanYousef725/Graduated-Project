import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduated_project/core/theme/app_colors.dart';
import 'package:graduated_project/features/profile/notifications/logic/notifications_cubit.dart';
import 'package:graduated_project/features/profile/notifications/logic/notifications_state.dart';
import 'package:graduated_project/features/profile/notifications/ui/widgets/notification_card.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotificationsCubit()..loadNotifications(),
      child: Builder(
        builder: (innerContext) {
          return Scaffold(
            backgroundColor: const Color(0xFFF5F9FF),
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: AppColors.textDark,
                  size: 20,
                ),
                onPressed: () => Navigator.pop(context),
              ),
              title: const Text(
                'Notifications',
                style: TextStyle(
                  color: AppColors.textDark,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () =>
                      innerContext.read<NotificationsCubit>().markAllAsRead(),
                  child: const Text(
                    'Mark all read',
                    style: TextStyle(
                      color: AppColors.primaryTeal,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
              ],
            ),
            body: BlocBuilder<NotificationsCubit, NotificationsState>(
              builder: (context, state) {
                if (state is NotificationsLoading) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Color.fromRGBO(5, 150, 105, 1),
                    ),
                  );
                } else if (state is NotificationsLoaded) {
                  return ListView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 20,
                    ),
                    children: [
                      _buildSectionHeader('TODAY'),
                      ...state.today.map(
                        (n) => NotificationCard(notification: n),
                      ),
                      const SizedBox(height: 20),
                      _buildSectionHeader('YESTERDAY'),
                      ...state.yesterday.map(
                        (n) => NotificationCard(notification: n),
                      ),
                      const SizedBox(height: 40),
                    ],
                  );
                } else if (state is NotificationsError) {
                  return Center(child: Text(state.message));
                }
                return const SizedBox.shrink();
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16, left: 4),
      child: Text(
        title,
        style: const TextStyle(
          color: AppColors.textGrey,
          fontSize: 14,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.1,
        ),
      ),
    );
  }
}
