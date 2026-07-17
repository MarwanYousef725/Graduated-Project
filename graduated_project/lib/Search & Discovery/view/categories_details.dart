import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduated_project/Search%20&%20Discovery/contolers/cubit/product_cubit.dart';
import 'package:graduated_project/Search%20&%20Discovery/models/product_model.dart';
import 'package:graduated_project/Search%20&%20Discovery/view/search.dart';
import 'package:graduated_project/Search%20&%20Discovery/widgets/product_card.dart';
import 'package:graduated_project/Search%20&%20Discovery/widgets/view_cart_button.dart';

class CategoriesDetails extends StatefulWidget {
  final String product;
  const CategoriesDetails({super.key, required this.product});

  @override
  State<CategoriesDetails> createState() => _CategoriesDetailsState();
}

class _CategoriesDetailsState extends State<CategoriesDetails> {
  late final ProductCubit _productCubit;

  @override
  void initState() {
    super.initState();
    _productCubit = ProductCubit();
    _productCubit.fetchProducts().then((_) {
      if (mounted) {
        _productCubit.getProductsByCategory(widget.product);
      }
    });
  }

  @override
  void dispose() {
    _productCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _productCubit,
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(249, 250, 251, 1),
        body: BlocBuilder<ProductCubit, ProductState>(
          builder: (context, state) {
            if (state is ProductLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Color.fromRGBO(5, 150, 105, 1),
                ),
              );
            }
            final List<PharmacyProducts> currentProducts =
                _productCubit.productsByCategory;
            return Stack(
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
                            color: const Color.fromRGBO(243, 244, 246, 1),
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
                                  widget.product,
                                  maxLines: 3,
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
                                MaterialPageRoute(
                                  builder: (context) => Search(),
                                ),
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
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 16,
                        right: 16,
                        top: 16,
                        bottom: 96,
                      ),
                      child: Column(
                        spacing: 16.dg,
                        children: List.generate(currentProducts.length, (i) {
                          return BuildProductCard(
                            item: currentProducts[i],
                            context: context,
                          );
                        }),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  bottom: 0.dg,
                  left: 0.dg,
                  right: 0.dg,
                  child: const ViewCartButton(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
