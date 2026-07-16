part of 'profile_cubit.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final String name;
  final String phone;
  final String gender;
  final String dob;
  final String? profileImage;
  final int notificationCount;

  ProfileLoaded({
    required this.name,
    required this.phone,
    required this.gender,
    required this.dob,
    this.profileImage,
    required this.notificationCount,
  });
}

class ProfileError extends ProfileState {
  final String message;
  ProfileError(this.message);
}
