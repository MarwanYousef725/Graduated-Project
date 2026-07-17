import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduated_project/Search%20&%20Discovery/view/home.dart';
import 'package:graduated_project/User%20Authentication/contolers/cubit/login_cubit.dart';
import 'package:graduated_project/User%20Authentication/view/forget_password.dart';
import 'package:graduated_project/User%20Authentication/view/sign_up.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: ListView(
              children: [
                SizedBox(height: 118.h),
                Image.asset(
                  'assets/images/Logo Placeholder.png',
                  width: 80.w,
                  height: 80.h,
                ),
                SizedBox(height: 20.dg),
                Text(
                  textAlign: TextAlign.center,
                  "Welcome Back",
                  style: GoogleFonts.inter(
                    fontSize: 24.dg,
                    fontWeight: FontWeight.w700,
                    color: Color.fromRGBO(17, 24, 39, 1),
                  ),
                ),
                SizedBox(height: 8.dg),
                Text(
                  textAlign: TextAlign.center,
                  "Sign in to access your pharmacy profile",
                  style: GoogleFonts.inter(
                    fontSize: 16.dg,
                    fontWeight: FontWeight.w400,
                    color: Color.fromRGBO(107, 114, 128, 1),
                  ),
                ),
                BlocBuilder<LoginCubit, LoginState>(
                  builder: (context, state) {
                    final loginCubit = context.read<LoginCubit>();
                    return Padding(
                      padding: const EdgeInsets.only(top: 32.0, bottom: 16.0),
                      child: Form(
                        key: loginCubit.formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Email",
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w500,
                                fontSize: 14.dg,
                                color: Color.fromRGBO(55, 65, 81, 1),
                              ),
                            ),
                            SizedBox(height: 8.dg),
                            TextFormField(
                              onTapOutside: (event) {
                                FocusScope.of(context).unfocus();
                              },
                              autocorrect: true,
                              controller: loginCubit.emailController,
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
                            SizedBox(height: 24.dg),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Password",
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.dg,
                                    color: Color.fromRGBO(55, 65, 81, 1),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ForgetPassword(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    "Forgot Password?",
                                    style: GoogleFonts.inter(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12.dg,
                                      color: Color.fromRGBO(45, 159, 117, 1),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8.dg),

                            TextFormField(
                              onTapOutside: (event) {
                                FocusScope.of(context).unfocus();
                              },
                              controller: loginCubit.passwordController,
                              obscureText: loginCubit.isHidden1,
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    loginCubit.changePasswordVisibility();
                                  },
                                  icon: loginCubit.isHidden1
                                      ? Icon(Icons.visibility_off_outlined)
                                      : Icon(Icons.visibility_outlined),
                                ),
                                hint: Text(
                                  "••••••••",
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
                                  return 'Please enter your password';
                                }
                                if (value.length < 6) {
                                  return 'Password must be at least 6 characters';
                                }
                                if (value.length > 20) {
                                  return 'Password must be less than 20 characters';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 30.dg),

                            GestureDetector(
                              onTap: (state is LoginLoading)
                                  ? null
                                  : () async {
                                      if (loginCubit.formKey.currentState!
                                          .validate()) {
                                        await loginCubit.login(false);
                                        Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => Home(index: 0),
                                          ),
                                          (route) => false,
                                        );
                                      }
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
                                  child: (state is LoginLoading)
                                      ? CircularProgressIndicator(
                                          color: Colors.white,
                                        )
                                      : Text(
                                          "Sign In",
                                          style: GoogleFonts.inter(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 14.dg,
                                            color: Colors.white,
                                          ),
                                        ),
                                ),
                              ),
                            ),
                            SizedBox(height: 40.dg),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Don't have an account? ",
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14.dg,
                                    color: Color.fromRGBO(107, 114, 128, 1),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SignUp(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    "Create Account",
                                    style: GoogleFonts.inter(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14.dg,
                                      color: Color.fromRGBO(45, 159, 117, 1),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 32.dg),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,

                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Divider(
                                    thickness: .5.dg,
                                    color: Color.fromRGBO(156, 163, 175, 1),
                                  ),
                                ),
                                Text(
                                  "   OR CONTINUE WITH   ",
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 10.dg,
                                    color: Color.fromRGBO(156, 163, 175, 1),
                                    letterSpacing: .5.dg,
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Divider(
                                    thickness: .5.dg,
                                    color: Color.fromRGBO(156, 163, 175, 1),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 32.dg),
                            GestureDetector(
                              onTap: () async {
                                await loginCubit.signInWithGoogle();
                                if (FirebaseAuth.instance.currentUser != null) {
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => Home(index: 0),
                                    ),
                                    (route) => false,
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("Please verify your email"),
                                      backgroundColor: Color.fromRGBO(
                                        45,
                                        159,
                                        117,
                                        1,
                                      ),
                                    ),
                                  );
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                height: 50.dg,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12.dg),
                                  border: BoxBorder.all(
                                    color: Color.fromRGBO(229, 231, 235, 1),
                                    width: 1.dg,
                                  ),
                                ),

                                child: Center(
                                  child: Image.asset(
                                    "assets/images/google.png",
                                    width: 25.w,
                                    height: 25.h,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
