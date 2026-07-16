import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduated_project/Search%20&%20Discovery/contolers/cubit/product_cubit.dart';
import 'package:graduated_project/Search%20&%20Discovery/widgets/home_page.dart';
import 'package:graduated_project/features/profile/ui/screens/profile_screen.dart';

class Home extends StatelessWidget {
  final List screens = [HomePage(), Cart(), Orders(), ProfileScreen()];

  Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: BlocProvider(
        create: (context) => ProductCubit(),
        child: BlocBuilder<ProductCubit, ProductState>(
          builder: (context, state) {
            return Scaffold(
              bottomNavigationBar: BottomAppBar(
                height: 68.dg,
                color: Colors.white,
                padding: const EdgeInsets.all(0),
                child: Container(
                  padding: EdgeInsets.only(top: 20),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        width: 1.dg,
                        color: Color.fromRGBO(229, 231, 235, 1),
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          context.read<ProductCubit>().changeIndex(0);
                        },
                        child: Column(
                          spacing: 4.dg,
                          children: [
                            Image.asset(
                              "assets/images/home.png",
                              width: 18.dg,
                              height: 18.dg,
                            ),
                            Text(
                              "Home",
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w500,
                                fontSize: 10.dg,
                                color: Color.fromRGBO(107, 114, 128, 1),
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          context.read<ProductCubit>().changeIndex(1);
                        },
                        child: Column(
                          spacing: 4.dg,
                          children: [
                            Image.asset(
                              "assets/images/cart.png",
                              width: 18.dg,
                              height: 18.dg,
                            ),
                            Text(
                              "Cart",
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w500,
                                fontSize: 10.dg,
                                color: Color.fromRGBO(107, 114, 128, 1),
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          context.read<ProductCubit>().changeIndex(2);
                        },
                        child: Column(
                          spacing: 4.dg,
                          children: [
                            Image.asset(
                              "assets/images/orders.png",
                              width: 18.dg,
                              height: 18.dg,
                            ),
                            Text(
                              "Orders",
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w500,
                                fontSize: 10.dg,
                                color: Color.fromRGBO(107, 114, 128, 1),
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          context.read<ProductCubit>().changeIndex(3);
                        },
                        child: Column(
                          spacing: 4.dg,
                          children: [
                            Image.asset(
                              "assets/images/profile.png",
                              width: 18.dg,
                              height: 18.dg,
                            ),
                            Text(
                              "Profile",
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w500,
                                fontSize: 10.dg,
                                color: Color.fromRGBO(107, 114, 128, 1),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              backgroundColor: Color.fromRGBO(249, 250, 251, 1),
              body: screens[context.read<ProductCubit>().currentIndex],
              // body: HomePage(),
            );
          },
        ),
      ),
    );
  }
}

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("Cart")));
  }
}

class Orders extends StatelessWidget {
  const Orders({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("Orders")));
  }
}
