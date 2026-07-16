import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduated_project/User%20Authentication/contolers/cubit/forget_password_cubit.dart';
import 'package:graduated_project/User%20Authentication/contolers/cubit/forget_password_state.dart';
import 'package:graduated_project/User%20Authentication/view/login.dart'
    show Login;

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgetPasswordCubit(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            "Forget Password",
            style: GoogleFonts.inter(
              fontSize: 18.dg,
              fontWeight: FontWeight.w700,
              letterSpacing: -.27,
              color: Color.fromRGBO(15, 23, 42, 1),
            ),
          ),
        ),
        body: BlocBuilder<ForgetPasswordCubit, ForgetPasswordState>(
          builder: (context, state) {
            var cubit = context.read<ForgetPasswordCubit>();
            return ListView(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              children: [
                SizedBox(height: 90.h),
                Container(
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Color.fromRGBO(243, 244, 246, 1),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.05),
                        offset: Offset(0, 1),
                        blurRadius: 2,
                      ),
                    ],
                  ),
                  padding: EdgeInsets.all(32),
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/images/Pharmacy App Logo Placeholder.png",
                        width: 64.w,
                        height: 64.h,
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        "Forget Password",
                        style: GoogleFonts.inter(
                          fontSize: 24.dg,
                          fontWeight: FontWeight.w700,
                          color: Color.fromRGBO(17, 24, 39, 1),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        "Enter your email address and we will send you a link to reset your password",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          fontSize: 14.dg,
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(107, 114, 128, 1),
                        ),
                      ),
                      SizedBox(height: 32.h),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(243, 244, 246, 1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: EdgeInsets.all(4),
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(255, 255, 255, 1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            "Email",
                            style: GoogleFonts.inter(
                              fontSize: 14.dg,
                              fontWeight: FontWeight.w500,
                              color: Color.fromRGBO(55, 65, 81, 1),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 32.h),
                      Container(
                        width: double.infinity,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Email Address",
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w500,
                            fontSize: 14.dg,
                            color: Color.fromRGBO(55, 65, 81, 1),
                          ),
                        ),
                      ),
                      SizedBox(height: 8.dg),
                      TextFormField(
                        onTapOutside: (event) {
                          FocusScope.of(context).unfocus();
                        },
                        autocorrect: true,
                        controller: cubit.emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hint: Text(
                            "e.g. name@email.com",
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w400,
                              fontSize: 16.dg,
                              color: Color.fromRGBO(107, 114, 128, 1),
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.dg),
                            borderSide: BorderSide(
                              color: Color.fromRGBO(209, 213, 219, 1),
                              width: 1.dg,
                            ),
                          ),
                        ),

                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                              ).hasMatch(value)
                              ? null
                              : 'Please enter a valid email';

                          return null;
                        },
                      ),
                      SizedBox(height: 32.h),
                      GestureDetector(
                        onTap: (state is ForgetPasswordLoading)
                            ? null
                            : () async {
                                await cubit.resetPassword();
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(builder: (_) => Login()),
                                  (route) => false,
                                );
                              },

                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                          height: 50.dg,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(45, 159, 117, 1),
                            borderRadius: BorderRadius.circular(12.dg),
                            border: BoxBorder.all(
                              color: Color.fromRGBO(0, 0, 0, 0),
                              width: 1.dg,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromRGBO(0, 0, 0, 0.05),
                                offset: Offset(0, 1),
                                blurRadius: 2,
                                spreadRadius: 0,
                              ),
                            ],
                          ),
                          child: Center(
                            child: (state is ForgetPasswordLoading)
                                ? CircularProgressIndicator(color: Colors.white)
                                : Text(
                                    "Send Code",
                                    style: GoogleFonts.inter(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14.dg,
                                      color: Colors.white,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                      SizedBox(height: 32.h),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              "Remembered your password?  ",
                              style: GoogleFonts.inter(
                                fontSize: 14.dg,
                                fontWeight: FontWeight.w500,
                                color: Color.fromRGBO(107, 114, 128, 1),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(builder: (_) => Login()),
                                  (route) => false,
                                );
                              },
                              child: Text(
                                "Back to Sign In",
                                style: GoogleFonts.inter(
                                  fontSize: 14.dg,
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromRGBO(45, 159, 117, 1),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
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
