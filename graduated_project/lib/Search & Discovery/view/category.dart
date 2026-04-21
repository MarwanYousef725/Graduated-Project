import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduated_project/Search%20&%20Discovery/contolers/cubit/product_cubit.dart';
import 'package:graduated_project/Search%20&%20Discovery/view/categories_details.dart';
import 'package:graduated_project/Search%20&%20Discovery/view/search.dart';

class Category extends StatelessWidget {
  const Category({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(249, 250, 251, 1),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(
                  width: 1.dg,
                  color: Color.fromRGBO(243, 244, 246, 1),
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  spacing: 12.dg,
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.arrow_back_ios_new_rounded, size: 24.dg),
                    ),
                    Text(
                      "Categroies",
                      style: GoogleFonts.inter(
                        fontSize: 20.dg,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),

                IconButton(
                  onPressed: () {
                    Navigator.of(
                      context,
                    ).push(MaterialPageRoute(builder: (context) => Search()));
                  },
                  icon: Image.asset(
                    "assets/images/Search_Icon.png",
                    width: 18.dg,
                    height: 18.dg,
                  ),
                ),
              ],
            ),
          ),
          BlocBuilder<ProductCubit, ProductState>(
            builder: (context, state) {
              ProductCubit productCubit = context.read<ProductCubit>();
              if (state is ProductLoading) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Color.fromRGBO(5, 150, 105, 1),
                  ),
                );
              }
              return Padding(
                padding: EdgeInsetsGeometry.only(
                  top: 24,
                  bottom: 96,
                  left: 16,
                  right: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 24.dg,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Health Solutions",
                          style: GoogleFonts.inter(
                            fontSize: 16.dg,
                            fontWeight: FontWeight.w600,
                            color: Color.fromRGBO(100, 116, 139, 1),
                          ),
                        ),
                        Text(
                          "Find your medicine by category",
                          style: GoogleFonts.inter(
                            fontSize: 24.dg,
                            fontWeight: FontWeight.w700,
                            color: Color.fromRGBO(30, 41, 59, 1),
                          ),
                        ),
                      ],
                    ),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 12.dg,
                        crossAxisSpacing: 12.dg,
                      ),
                      itemCount: productCubit.products.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => CategoriesDetails(
                                  product:
                                      productCubit.products[index].category ??
                                      "",
                                ),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromRGBO(0, 0, 0, 0.05),
                                  offset: Offset(0, 1),
                                  blurRadius: 2,
                                ),
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12.dg),
                              border: Border.all(
                                color: Color.fromRGBO(241, 245, 249, 1),
                                width: 1.dg,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(bottom: 12),
                                  clipBehavior: Clip.antiAlias,
                                  width: 56.dg,
                                  height: 56.dg,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(200.dg),
                                  ),
                                  child: Image.asset(
                                    productCubit.catigoriesImages[index],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Text(
                                  productCubit.products[index].category ?? "",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.inter(
                                    fontSize: 16.dg,
                                    fontWeight: FontWeight.w600,
                                    color: Color.fromRGBO(51, 65, 85, 1),
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
              );
            },
          ),
        ],
      ),
    );
  }
}
