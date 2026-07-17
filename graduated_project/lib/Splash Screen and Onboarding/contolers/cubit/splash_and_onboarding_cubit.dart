import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduated_project/Splash%20Screen%20and%20Onboarding/contolers/cubit/splash_and_onboarding_state.dart';

class SplashCubit extends Cubit<SplashState> {
  double progress = 0;
  int currentIndex = 0;
  SplashCubit() : super(SplashInitial());
  Future<void> startTimer() async {
    progress = 0;
    emit(SplashLoading(progress: progress));
    await Future.delayed(const Duration(seconds: 1));
    progress = 0.2;
    emit(SplashLoading(progress: progress));
    await Future.delayed(const Duration(seconds: 1));
    progress = 0.4;
    emit(SplashLoading(progress: progress));
    await Future.delayed(const Duration(seconds: 1));
    progress = 0.6;
    emit(SplashLoading(progress: progress));
    await Future.delayed(const Duration(seconds: 1));
    progress = 0.8;
    emit(SplashLoading(progress: progress));
    await Future.delayed(const Duration(seconds: 1));
    progress = 1.0;
    emit(SplashLoading(progress: progress));

    await Future.delayed(const Duration(seconds: 1));
  }

  void nextPage(int value) {
    currentIndex = value;
    emit(OnboardingPageChanged(currentPage: currentIndex));
  }
}
