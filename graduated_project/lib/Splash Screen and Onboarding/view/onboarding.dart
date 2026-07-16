import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduated_project/Splash%20Screen%20and%20Onboarding/contolers/cubit/splash_and_onboarding_cubit.dart';
import 'package:graduated_project/Splash%20Screen%20and%20Onboarding/contolers/cubit/splash_and_onboarding_state.dart';
import 'package:graduated_project/Splash%20Screen%20and%20Onboarding/widgets/onboarding1.dart';
import 'package:graduated_project/Splash%20Screen%20and%20Onboarding/widgets/onboarding2.dart';
import 'package:graduated_project/User%20Authentication/view/login.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final PageController _pageController = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashCubit(),
      child: Scaffold(
        backgroundColor: Color.fromRGBO(255, 255, 255, 1),
        body: BlocBuilder<SplashCubit, SplashState>(
          builder: (context, state) {
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 40.0,
                        left: 16.0,
                        right: 16.0,
                      ),
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),

                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => Login()),
                          );
                        },
                        child: Text(
                          "Skip",
                          style: GoogleFonts.inter(
                            color: Color.fromRGBO(156, 163, 175, 1),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: PageView(
                    onPageChanged: (value) {
                      context.read<SplashCubit>().nextPage(value);
                    },
                    controller: _pageController,
                    scrollDirection: Axis.horizontal,
                    children: [Onboarding1(), Onboarding2()],
                  ),
                ),

                SizedBox(height: 16.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      width: context.read<SplashCubit>().currentIndex == 0
                          ? 32.w
                          : 8.w,
                      height: 8.h,
                      margin: const EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: context.read<SplashCubit>().currentIndex == 0
                            ? Color.fromRGBO(45, 159, 117, 1)
                            : Color.fromRGBO(229, 231, 235, 1),
                      ),
                    ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      width: context.read<SplashCubit>().currentIndex == 1
                          ? 32.w
                          : 8.w,
                      height: 8.h,
                      margin: const EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: context.read<SplashCubit>().currentIndex == 1
                            ? Color.fromRGBO(45, 159, 117, 1)
                            : Color.fromRGBO(229, 231, 235, 1),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 48.h),
                GestureDetector(
                  onTap: () {
                    if (context.read<SplashCubit>().currentIndex == 1) {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => Login()),
                        (route) => false,
                      );
                    }
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 56),
                    alignment: Alignment.center,
                    width: 342.w,
                    height: 60.h,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(45, 159, 117, 0.2),
                          offset: const Offset(0, 4),
                          blurRadius: 6.dg,
                          spreadRadius: -4.dg,
                        ),
                        BoxShadow(
                          color: Color.fromRGBO(45, 159, 117, 0.2),
                          offset: const Offset(0, 10),
                          blurRadius: 15.dg,
                          spreadRadius: -3.dg,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(12.dg),
                      color: Color.fromRGBO(45, 159, 117, 1),
                    ),
                    child: Text(
                      context.read<SplashCubit>().currentIndex == 0
                          ? "Next"
                          : "Get Started",
                      style: GoogleFonts.inter(
                        color: Color.fromRGBO(255, 255, 255, 1),
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
