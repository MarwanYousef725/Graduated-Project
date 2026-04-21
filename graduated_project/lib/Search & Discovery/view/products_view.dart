import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduated_project/Search%20&%20Discovery/contolers/cubit/product_cubit.dart';
import 'package:graduated_project/Search%20&%20Discovery/view/search.dart';
import 'package:graduated_project/Search%20&%20Discovery/widgets/product_card.dart';
import 'package:graduated_project/Search%20&%20Discovery/widgets/view_cart_button.dart';

class ProductsView extends StatefulWidget {
  const ProductsView({super.key});

  @override
  State<ProductsView> createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> {
  ProductCubit cubit = ProductCubit();
  @override
  void initState() {
    super.initState();
    cubit = context.read<ProductCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: ViewCartButton(),
      backgroundColor: const Color.fromRGBO(249, 250, 251, 1),
      body: Stack(
        children: [
          ListView(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
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
                          icon: Icon(
                            Icons.arrow_back_ios_new_rounded,
                            size: 24.dg,
                          ),
                        ),
                        SizedBox(
                          width: 240.dg,
                          child: Text(
                            "Products",
                            style: GoogleFonts.inter(
                              fontSize: 18.dg,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),

                    IconButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => Search()),
                        );
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
                  return Padding(
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                      top: 16,
                      bottom: 96,
                    ),
                    child: Column(
                      children: List.generate(cubit.products.length, (i) {
                        return ProductCard(product: cubit.products[i]);
                      }),
                    ),
                  );
                },
              ),
            ],
          ),

          Positioned(
            bottom: 0.dg,
            left: 0.dg,
            right: 0.dg,
            child: ViewCartButton(),
          ),
        ],
      ),
    );
  }
}
