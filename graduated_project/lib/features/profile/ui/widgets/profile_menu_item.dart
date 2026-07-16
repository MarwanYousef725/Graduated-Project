import 'package:flutter/material.dart';
import 'package:graduated_project/core/theme/app_colors.dart';

class ProfileMenuItemWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final String? badge;
  final bool isLogout;

  const ProfileMenuItemWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.badge,
    this.isLogout = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isLogout ? AppColors.logoutBg : AppColors.iconBg,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          icon,
          color: isLogout ? AppColors.primaryRed : AppColors.primaryTeal,
          size: 24,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isLogout ? AppColors.primaryRed : AppColors.textDark,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: badge != null
          ? Container(
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(
                color: AppColors.primaryRed,
                shape: BoxShape.circle,
              ),
              child: Text(
                badge!,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : !isLogout
          ? const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey)
          : null,
    );
  }
}
