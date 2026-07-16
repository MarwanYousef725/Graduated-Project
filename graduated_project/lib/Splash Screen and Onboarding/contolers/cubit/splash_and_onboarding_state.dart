import 'package:equatable/equatable.dart';

sealed class SplashState extends Equatable {
  const SplashState();

  @override
  List<Object> get props => [];
}

final class SplashInitial extends SplashState {}

final class SplashLoaded extends SplashState {}

final class SplashError extends SplashState {}

final class SplashLoading extends SplashState {
  final double progress;
  const SplashLoading({required this.progress});
  @override
  List<Object> get props => [progress];
}

final class OnboardingPageChanged extends SplashState {
  final int currentPage;
  const OnboardingPageChanged({required this.currentPage});

  @override
  List<Object> get props => [currentPage];
}
