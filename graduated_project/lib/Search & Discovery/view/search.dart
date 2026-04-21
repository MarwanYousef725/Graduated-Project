import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduated_project/Search%20&%20Discovery/contolers/cubit/product_cubit.dart';
import 'package:graduated_project/Search%20&%20Discovery/widgets/build_product_card.dart';
import 'package:graduated_project/Search%20&%20Discovery/widgets/build_search_bar.dart';

class Search extends StatelessWidget {
  final TextEditingController searchController = TextEditingController();
  Search({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      body: SafeArea(
        child: Column(
          children: [
            BuildSearchBar(
              searchController: searchController,
              context: context,
            ),
            Builder(
              builder: (context) {
                return BlocBuilder<ProductCubit, ProductState>(
                  builder: (context, state) {
                    return barInfo(
                      context.read<ProductCubit>().foundProducts,
                      searchController.text,
                    );
                  },
                );
              },
            ),
            Expanded(
              child: BlocBuilder<ProductCubit, ProductState>(
                builder: (context, state) {
                  if (state is ProductLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is ProductError) {
                    return const Center(child: Text("Error loading products"));
                  }

                  final foundProducts = context
                      .read<ProductCubit>()
                      .foundProducts;

                  if (foundProducts.isEmpty) {
                    return const Center(child: Text("No results found"));
                  }

                  return ListView.builder(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.dg,
                      vertical: 10.dg,
                    ),
                    itemCount: foundProducts.length,
                    itemBuilder: (context, index) {
                      final item = foundProducts[index];
                      return BuildProductCard(item: item, context: context);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget barInfo(List data, String name) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    "${data.length} results for ",
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    "\"$name\"",
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              PopupMenuButton<String>(
                color: Colors.white,
                elevation: 0.dg,
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 'A-Z',
                    child: Text(
                      "A-Z",
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                        fontSize: 12.dg,
                        color: Color.fromRGBO(45, 159, 117, 1),
                      ),
                    ),
                  ),
                  const PopupMenuDivider(),
                  PopupMenuItem(
                    value: 'Z-A',
                    child: Text(
                      "Z-A",
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                        fontSize: 12.dg,
                        color: Color.fromRGBO(45, 159, 117, 1),
                      ),
                    ),
                  ),
                  const PopupMenuDivider(),
                  PopupMenuItem(
                    value: 'LtoH',
                    child: Text(
                      "Price Low to High",
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                        fontSize: 12.dg,
                        color: Color.fromRGBO(45, 159, 117, 1),
                      ),
                    ),
                  ),
                  const PopupMenuDivider(),
                  PopupMenuItem(
                    value: 'HtoL',
                    child: Text(
                      "Price High to Low",
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
                  context.read<ProductCubit>().sortProducts(value);
                  context.read<ProductCubit>().getSortOption(value);
                },
                child: Row(
                  children: [
                    SizedBox(
                      width: 140.dg,
                      height: 20.dg,
                      child: Text(
                        "Sort by: ${context.read<ProductCubit>().sortOption}",
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                          fontSize: 14.dg,
                          color: Color.fromRGBO(45, 159, 117, 1),
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
        );
      },
    );
  }
}
