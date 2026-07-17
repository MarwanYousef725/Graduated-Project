import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduated_project/Search%20&%20Discovery/view/home.dart';
import 'package:graduated_project/Splash%20Screen%20and%20Onboarding/contolers/cubit/splash_and_onboarding_cubit.dart';
import 'package:graduated_project/Splash%20Screen%20and%20Onboarding/contolers/cubit/splash_and_onboarding_state.dart';
import 'package:graduated_project/Splash%20Screen%20and%20Onboarding/view/onboarding.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 6), () {
      if (FirebaseAuth.instance.currentUser != null) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Home(index: 0)),
          (route) => false,
        );
      } else {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Onboarding()),
          (route) => false,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashCubit()..startTimer(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          padding: const EdgeInsets.only(
            top: 337,
            left: 24,
            right: 24,
            bottom: 64,
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(240, 249, 246, 1),
                Color.fromRGBO(225, 242, 236, 1),
              ],
            ),
          ),
          child: Column(
            children: [
              Image.asset(
                "assets/images/Logo Container.png",
                width: 128.dg,
                height: 128.dg,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Smart",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 30.dg,
                      color: Color.fromRGBO(31, 41, 55, 1),
                      letterSpacing: -.75.dg,
                    ),
                  ),
                  Text(
                    "Pharmacy",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 30.dg,
                      color: Color.fromRGBO(45, 159, 117, 1),
                      letterSpacing: 0.dg,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.dg),
              Text(
                "YOUR HEALTH, SIMPLEFIED",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 12.dg,
                  color: Color.fromRGBO(107, 114, 128, 1),
                  letterSpacing: 0.3.dg,
                ),
              ),
              Spacer(),
              SizedBox(
                width: 272.dg,
                child: BlocBuilder<SplashCubit, SplashState>(
                  builder: (context, state) {
                    if (state is SplashLoading) {
                      return TweenAnimationBuilder<double>(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                        tween: Tween<double>(begin: 0, end: state.progress),
                        builder: (context, animatedValue, child) {
                          return LinearProgressIndicator(
                            value: animatedValue,
                            backgroundColor: Color.fromRGBO(243, 244, 246, 1),
                            color: Color.fromRGBO(45, 159, 117, 1),
                            minHeight: 6.dg,
                            borderRadius: BorderRadius.horizontal(
                              left: Radius.circular(100.dg),
                              right: Radius.circular(100.dg),
                            ),
                          );
                        },
                      );
                    }
                    return Container();
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/icon.png",
                      width: 16.dg,
                      height: 16.dg,
                    ),
                    Text(
                      "  ENCRYPTED & SECURED",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 10.dg,
                        color: Color.fromRGBO(156, 163, 175, 1),
                        letterSpacing: 1.dg,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
