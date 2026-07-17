import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduated_project/Search%20&%20Discovery/contolers/cubit/product_cubit.dart';
import 'package:graduated_project/Search%20&%20Discovery/models/product_model.dart';
import 'package:graduated_project/Search%20&%20Discovery/widgets/home_page.dart';
import 'package:graduated_project/cart_checkout/view/cart.dart';
import 'package:graduated_project/features/profile/ui/screens/profile_screen.dart';
import 'package:graduated_project/History/view/history.dart';

class Home extends StatelessWidget {
  final int index;
  final List screens = [HomePage(), Cart(), History(), ProfileScreen()];

  Home({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser?.uid ?? 'unknown_user';
    return BlocProvider(
      create: (context) => ProductCubit()..changeIndex(index),
      child: Material(
        child: BlocBuilder<ProductCubit, ProductState>(
          builder: (context, state) {
            final cubit = context.read<ProductCubit>();
            final currentIndex = cubit.currentIndex;

            return Scaffold(
              bottomNavigationBar: BottomAppBar(
                height: 68.dg,
                color: Colors.white,
                padding: const EdgeInsets.all(0),
                child: Container(
                  padding: const EdgeInsets.only(top: 20),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () => cubit.changeIndex(0),
                        child: Column(
                          spacing: 4.dg,
                          children: [
                            Image.asset(
                              "assets/images/home.png",
                              width: 18.dg,
                              height: 18.dg,
                              color: currentIndex == 0
                                  ? const Color.fromRGBO(45, 159, 117, 1)
                                  : const Color.fromRGBO(148, 163, 184, 1),
                            ),
                            Text(
                              "Home",
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w500,
                                fontSize: 10.dg,
                                color: currentIndex == 0
                                    ? const Color.fromRGBO(45, 159, 117, 1)
                                    : const Color.fromRGBO(148, 163, 184, 1),
                              ),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () => cubit.changeIndex(1),
                        child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('Users')
                              .doc(uid)
                              .collection('Cart_Products')
                              .snapshots(),
                          builder: (context, snapShot) {
                            int cartCount = 0;
                            if (snapShot.hasError) {
                              return Center(
                                child: Text("Error: ${snapShot.error}"),
                              );
                            }

                            if (snapShot.hasData) {
                              final docs = snapShot.data!.docs;
                              docs
                                  .map(
                                    (doc) => PharmacyProducts.fromJson(
                                      doc.data() as Map<String, dynamic>,
                                    ),
                                  )
                                  .toList();

                              for (var doc in docs) {
                                cartCount +=
                                    PharmacyProducts.fromJson(
                                      doc.data() as Map<String, dynamic>,
                                    ).quantity ??
                                    0;
                              }
                            }

                            return Stack(
                              children: [
                                SizedBox(
                                  width: 50.dg,
                                  child: Column(
                                    spacing: 4.dg,
                                    children: [
                                      Image.asset(
                                        "assets/images/cart.png",
                                        width: 18.dg,
                                        height: 18.dg,
                                        color: currentIndex == 1
                                            ? const Color.fromRGBO(
                                                45,
                                                159,
                                                117,
                                                1,
                                              )
                                            : const Color.fromRGBO(
                                                148,
                                                163,
                                                184,
                                                1,
                                              ),
                                      ),
                                      Text(
                                        "Cart",
                                        style: GoogleFonts.inter(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 10.dg,
                                          color: currentIndex == 1
                                              ? const Color.fromRGBO(
                                                  45,
                                                  159,
                                                  117,
                                                  1,
                                                )
                                              : const Color.fromRGBO(
                                                  148,
                                                  163,
                                                  184,
                                                  1,
                                                ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                if (cartCount > 0)
                                  Positioned(
                                    top: 0.dg,
                                    right: 0.dg,
                                    child: Container(
                                      width: 16.dg,
                                      height: 16.dg,
                                      decoration: const BoxDecoration(
                                        color: Color.fromRGBO(239, 68, 68, 1),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Center(
                                        child: Text(
                                          "$cartCount",
                                          style: GoogleFonts.inter(
                                            fontSize: 10.dg,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            );
                          },
                        ),
                      ),
                      InkWell(
                        onTap: () => cubit.changeIndex(2),
                        child: Column(
                          spacing: 4.dg,
                          children: [
                            Image.asset(
                              "assets/images/orders.png",
                              width: 18.dg,
                              height: 18.dg,
                              color: currentIndex == 2
                                  ? const Color.fromRGBO(45, 159, 117, 1)
                                  : const Color.fromRGBO(148, 163, 184, 1),
                            ),
                            Text(
                              "Orders",
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w500,
                                fontSize: 10.dg,
                                color: currentIndex == 2
                                    ? const Color.fromRGBO(45, 159, 117, 1)
                                    : const Color.fromRGBO(148, 163, 184, 1),
                              ),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () => cubit.changeIndex(3),
                        child: Column(
                          spacing: 4.dg,
                          children: [
                            Image.asset(
                              "assets/images/profile.png",
                              width: 18.dg,
                              height: 18.dg,
                              color: currentIndex == 3
                                  ? const Color.fromRGBO(45, 159, 117, 1)
                                  : const Color.fromRGBO(148, 163, 184, 1),
                            ),
                            Text(
                              "Profile",
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w500,
                                fontSize: 10.dg,
                                color: currentIndex == 3
                                    ? const Color.fromRGBO(45, 159, 117, 1)
                                    : const Color.fromRGBO(148, 163, 184, 1),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              backgroundColor: const Color.fromRGBO(249, 250, 251, 1),
              body: screens[currentIndex],
            );
          },
        ),
      ),
    );
  }
}
