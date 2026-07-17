import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduated_project/User%20Authentication/contolers/cubit/register_cubit.dart';
import 'package:graduated_project/User%20Authentication/view/login.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            "Create Account",
            style: GoogleFonts.inter(
              fontSize: 18.dg,
              fontWeight: FontWeight.w700,
              letterSpacing: -.27,
              color: Color.fromRGBO(15, 23, 42, 1),
            ),
          ),
        ),
        body: ListView(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          clipBehavior: Clip.antiAlias,

          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          children: [
            SizedBox(height: 32.h),
            Text(
              "Join our Pharmacy",
              style: GoogleFonts.inter(
                fontSize: 32.dg,
                fontWeight: FontWeight.w700,
                letterSpacing: -.8,
                color: Color.fromRGBO(15, 23, 42, 1),
              ),
            ),
            SizedBox(height: 8.h),
            SizedBox(
              child: Text(
                textAlign: TextAlign.start,
                """Sign up to manage your prescriptions and         health orders seamlessly.""",
                style: GoogleFonts.inter(
                  fontSize: 16.dg,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0,
                  color: Color.fromRGBO(71, 85, 105, 1),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            BlocBuilder<RegisterCubit, RegisterState>(
              builder: (context, state) {
                final registerCubit = context.read<RegisterCubit>();
                return Form(
                  key: registerCubit.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Full Name",
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
                        autovalidateMode: AutovalidateMode.onUserInteraction,

                        keyboardType: TextInputType.name,
                        controller: registerCubit.fullNameController,
                        decoration: InputDecoration(
                          hint: Text(
                            "Jane Doe",
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
                            return 'Please enter some text';
                          }
                          if (value.length < 3) {
                            return 'Please enter at least 3 characters';
                          }
                          if (!RegExp(r'^[a-zA-Zأ-ي]').hasMatch(value)) {
                            return 'Please enter a valid name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16.dg),
                      Text(
                        "Phone Number",
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
                        autovalidateMode: AutovalidateMode.onUserInteraction,

                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          hint: Text(
                            "+20 1234567890",
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
                          if (value == null ||
                              value.isEmpty ||
                              value.length < 11) {
                            return 'Please enter 11 numbers';
                          }
                          if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                            return 'Please enter a valid number';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16.dg),

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
                        controller: registerCubit.emailController,
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
                      SizedBox(height: 16.dg),
                      Text(
                        "Password",
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
                        controller: registerCubit.passwordController,
                        obscureText: registerCubit.isHidden1,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {
                              registerCubit.changePasswordVisibility();
                            },
                            icon: registerCubit.isHidden1
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
                            return 'Please enter some text';
                          }
                          if (value.length < 8) {
                            return 'Please enter at least 8 characters';
                          }
                          if (!RegExp(
                            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$',
                          ).hasMatch(value)) {
                            return 'Weak password';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16.dg),
                      Row(
                        spacing: 12.dg,
                        children: [
                          GestureDetector(
                            onTap: () {
                              registerCubit.changeCheckBox();
                            },
                            child: Container(
                              width: 20.dg,
                              height: 20.dg,
                              decoration: BoxDecoration(
                                color: registerCubit.isChecked
                                    ? Color.fromRGBO(45, 159, 117, 1)
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(8.dg),
                                border: Border.all(
                                  color: Color.fromRGBO(203, 213, 225, 1),
                                  width: 1.dg,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Wrap(
                              direction: Axis.horizontal,
                              children: [
                                Text(
                                  "I agree to the ",
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14.dg,
                                    color: Color.fromRGBO(55, 65, 81, 1),
                                  ),
                                ),
                                Text(
                                  "Terms of Service",
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14.dg,
                                    color: Color.fromRGBO(45, 159, 117, 1),
                                  ),
                                ),
                                Text(
                                  " and ",
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14.dg,
                                    color: Color.fromRGBO(55, 65, 81, 1),
                                  ),
                                ),
                                Text(
                                  "Privacy Policy",
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14.dg,
                                    color: Color.fromRGBO(45, 159, 117, 1),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 24.dg),

                      GestureDetector(
                        onTap: !registerCubit.isChecked
                            ? null
                            : (state is RegisterLoading)
                            ? null
                            : () async {
                                if (registerCubit.formKey.currentState!
                                    .validate()) {
                                  await registerCubit.register();
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(builder: (_) => Login()),
                                    (route) => false,
                                  );
                                }
                              },

                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          height: 50.dg,
                          decoration: BoxDecoration(
                            color: registerCubit.isChecked
                                ? Color.fromRGBO(45, 159, 117, 1)
                                : Color.fromRGBO(203, 213, 225, 1),
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
                            child: (state is RegisterLoading)
                                ? CircularProgressIndicator(color: Colors.white)
                                : Text(
                                    "Sign Up",
                                    style: GoogleFonts.inter(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16.dg,
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
                            "Already have an account? ",
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w400,
                              fontSize: 16.dg,
                              color: Color.fromRGBO(71, 85, 105, 1),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Login(),
                                ),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "A verification link has been sent to your email. Please check your inbox.",
                                  ),
                                  backgroundColor: Color.fromRGBO(
                                    45,
                                    159,
                                    117,
                                    1,
                                  ),
                                ),
                              );
                            },
                            child: Text(
                              "Sign In",
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w700,
                                fontSize: 16.dg,
                                color: Color.fromRGBO(45, 159, 117, 1),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.dg),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
