import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduated_project/core/theme/app_colors.dart';
import 'package:graduated_project/features/profile/addresses/ui/screens/saved_addresses_screen.dart';
import 'package:graduated_project/features/profile/logic/profile_cubit.dart';
import 'package:graduated_project/features/profile/notifications/ui/screens/notifications_screen.dart';
import 'package:graduated_project/features/profile/orders/ui/screens/order_history_screen.dart';
import 'package:graduated_project/features/profile/ui/screens/personal_info_screen.dart';
import 'package:graduated_project/features/profile/ui/widgets/profile_menu_item.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F9FF),
      body: BlocProvider(
        create: (context) => ProfileCubit()..loadProfile(),
        child: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProfileLoaded) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    _buildHeader(context, state),
                    const SizedBox(height: 20),
                    _buildMenuCard(context, state),
                    const SizedBox(height: 20),
                    _buildFooter(),
                    const SizedBox(height: 20),
                  ],
                ),
              );
            } else if (state is ProfileError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, ProfileLoaded state) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 60, bottom: 30),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFE1F5FE), Colors.white],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFFB3E5FC), width: 2),
                ),
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.white,
                  backgroundImage: state.profileImage != null
                      ? FileImage(File(state.profileImage!))
                      : null,
                  child: state.profileImage == null
                      ? const Icon(Icons.person, size: 60, color: Colors.grey)
                      : null,
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: InkWell(
                  onTap: () =>
                      context.read<ProfileCubit>().updateProfileImage(),
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: AppColors.primaryTeal,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: const Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            "${FirebaseAuth.instance.currentUser!.displayName}",
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "${FirebaseAuth.instance.currentUser!.email}",
            style: const TextStyle(fontSize: 14, color: AppColors.textGrey),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuCard(BuildContext context, ProfileLoaded state) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          ProfileMenuItemWidget(
            icon: Icons.person_outline,
            title: 'Personal Information',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BlocProvider.value(
                    value: context.read<ProfileCubit>(),
                    child: const PersonalInfoScreen(),
                  ),
                ),
              );
            },
          ),
          _buildDivider(),
          ProfileMenuItemWidget(
            icon: Icons.location_on_outlined,
            title: 'Saved Addresses',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SavedAddressesScreen()),
              );
            },
          ),
          _buildDivider(),
          ProfileMenuItemWidget(
            icon: Icons.description_outlined,
            title: 'Saved Prescriptions',
            onTap: () {},
          ),
          _buildDivider(),
          ProfileMenuItemWidget(
            icon: Icons.history,
            title: 'Order History',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const OrderHistoryScreen(),
                ),
              );
            },
          ),
          _buildDivider(),
          ProfileMenuItemWidget(
            icon: Icons.notifications_none,
            title: 'Notifications',
            badge: state.notificationCount.toString(),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationsScreen()),
              );
            },
          ),
          _buildDivider(),
          ProfileMenuItemWidget(
            icon: Icons.help_outline,
            title: 'Help & Support',
            onTap: () {},
          ),
          _buildDivider(),
          ProfileMenuItemWidget(
            icon: Icons.logout,
            title: 'Logout',
            isLogout: true,
            onTap: () => context.read<ProfileCubit>().logout(),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Divider(height: 1, color: AppColors.dividerColor),
    );
  }

  Widget _buildFooter() {
    return const Text(
      'SMART PHARMACY V2.4.0',
      style: TextStyle(
        color: AppColors.textGrey,
        fontSize: 12,
        fontWeight: FontWeight.w500,
        letterSpacing: 1.2,
      ),
    );
  }
}
