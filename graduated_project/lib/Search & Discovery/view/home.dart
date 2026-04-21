import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduated_project/Search%20&%20Discovery/contolers/cubit/product_cubit.dart';
import 'package:graduated_project/Search%20&%20Discovery/view/categories_details.dart';
import 'package:graduated_project/Search%20&%20Discovery/view/category.dart';
import 'package:graduated_project/Search%20&%20Discovery/view/products_view.dart';
import 'package:graduated_project/Search%20&%20Discovery/widgets/category_name_above_products.dart';
import 'package:graduated_project/Search%20&%20Discovery/widgets/column_product_card.dart';
import 'package:graduated_project/Search%20&%20Discovery/widgets/row_product_card.dart';
import 'package:graduated_project/Search%20&%20Discovery/view/search.dart';

class Home extends StatelessWidget {
  final List screens = [];
  final List<Map<String, dynamic>> categories = [
    {"image": "assets/images/Pain_Relief.png"},
    {"image": "assets/images/Diabetes.png"},
    {"image": "assets/images/Respiratory.png"},
    {"image": "assets/images/Skin_Care.png"},
    {"image": "assets/images/Cardiac.png"},
    {"image": "assets/images/Vitamins.png"},
  ];
  Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
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
        body: ListView(
          children: [
            Container(
              width: 390.dg,
              padding: EdgeInsets.only(
                top: 16.dg,
                right: 16.dg,
                left: 16.dg,
                bottom: 8.dg,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.05),
                    blurRadius: 2.dg,
                    offset: Offset(2.dg, 0.dg),
                  ),
                ],
              ),
              child: Column(
                spacing: 16.dg,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Deliver to",
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w400,
                              fontSize: 12.dg,
                              color: Color.fromRGBO(107, 114, 128, 1),
                            ),
                          ),
                          PopupMenuButton<String>(
                            color: Colors.white,
                            elevation: 0.dg,
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                enabled: false,
                                child: Text(
                                  "Home, 123 Health St., San Francisco, CA, 94107, USA",
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14.dg,
                                    color: Color.fromRGBO(17, 24, 39, 1),
                                  ),
                                ),
                              ),
                              const PopupMenuDivider(),
                              PopupMenuItem(
                                value: 'edit',
                                child: Text(
                                  "Edit Address",
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12.dg,
                                    color: Color.fromRGBO(45, 159, 117, 1),
                                  ),
                                ),
                              ),
                            ],
                            offset: Offset(0, 30),
                            onSelected: (value) {
                              if (value == 'edit') {
                                log("Navigate to Edit Address");
                              }
                            },
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 140.dg,
                                  height: 20.dg,
                                  child: Text(
                                    "Home, 123 Health St., San Francisco, CA, 94107, USA",
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.inter(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14.dg,
                                      color: Color.fromRGBO(17, 24, 39, 1),
                                    ),
                                  ),
                                ),
                                Icon(
                                  Icons.keyboard_arrow_down,
                                  size: 16.dg,
                                  color: Color.fromRGBO(45, 159, 117, 1),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        child: Stack(
                          children: [
                            Container(
                              height: 40.dg,
                              width: 40.dg,
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(243, 244, 246, 1),
                                shape: BoxShape.circle,
                              ),
                              child: Image.asset(
                                "assets/images/Vector.png",
                                width: 16.dg,
                                height: 18.dg,
                              ),
                            ),
                            Positioned(
                              top: 3.dg,
                              right: 3.dg,
                              child: Container(
                                height: 10.dg,
                                width: 10.dg,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2.dg,
                                  ),
                                  shape: BoxShape.circle,
                                  color: Color.fromRGBO(239, 68, 68, 1),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  GestureDetector(
                    onTap: () {
                      Navigator.of(
                        context,
                      ).push(MaterialPageRoute(builder: (context) => Search()));
                    },
                    child: Container(
                      padding: const EdgeInsets.only(
                        left: 16.0,
                        top: 13,
                        bottom: 14,
                        right: 12,
                      ),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(243, 244, 246, 1),
                        borderRadius: BorderRadius.circular(12.dg),
                      ),
                      child: Row(
                        spacing: 12.dg,
                        children: [
                          Image.asset(
                            "assets/images/searchicon.png",
                            width: 24.dg,
                            height: 24.dg,
                          ),
                          Text(
                            "Search medicines, health products...",
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w400,
                              fontSize: 16.dg,
                              color: Color.fromRGBO(107, 114, 128, 1),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.dg),
            GestureDetector(
              onTap: () {
                Navigator.of(
                  context,
                ).push(MaterialPageRoute(builder: (context) => ProductsView()));
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: GestureDetector(
                  child: Image.asset("assets/images/offer.png"),
                ),
              ),
            ),
            SizedBox(height: 32.dg),
            CategoryNameAboveProducts(
              categoryName: "Categories",
              howToShow: "Vee All",
              onTapped: () {
                Navigator.of(
                  context,
                ).push(MaterialPageRoute(builder: (context) => Category()));
              },
            ),

            SizedBox(height: 16.dg),

            BlocProvider(
              create: (context) => ProductCubit()..fetchProducts(),
              child: BlocBuilder<ProductCubit, ProductState>(
                builder: (context, state) {
                  if (state is ProductLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        SizedBox(width: 20.dg),

                        Row(
                          spacing: 16.dg,
                          children: List.generate(categories.length, (index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CategoriesDetails(
                                      product: context
                                          .read<ProductCubit>()
                                          .products[index]
                                          .category!,
                                    ),
                                  ),
                                );
                              },
                              child: Column(
                                spacing: 8.dg,
                                children: [
                                  Image.asset(
                                    categories[index]["image"],
                                    width: 64,
                                    height: 64,
                                  ),
                                  SizedBox(
                                    width: 64.dg,
                                    child: Text(
                                      textAlign: TextAlign.center,
                                      context
                                          .read<ProductCubit>()
                                          .products[index]
                                          .category!,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.inter(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 10.dg,
                                        color: Color.fromRGBO(17, 24, 39, 1),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                        ),
                        SizedBox(width: 20.dg),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 32.dg),
            CategoryNameAboveProducts(
              categoryName: "Popular Medicines",
              howToShow: "See All",
              onTapped: () {
                Navigator.of(
                  context,
                ).push(MaterialPageRoute(builder: (context) => ProductsView()));
              },
            ),
            SizedBox(height: 16.dg),
            ColumnProductCard(),
            SizedBox(height: 32.dg),
            CategoryNameAboveProducts(
              categoryName: "Pain Relief",
              howToShow: "See All",
              onTapped: () {
                Navigator.of(
                  context,
                ).push(MaterialPageRoute(builder: (context) => ProductsView()));
              },
            ),
            SizedBox(height: 16.dg),
            RowProductCard(),
            SizedBox(height: 32.dg),
          ],
        ),
      ),
    );
  }
}
