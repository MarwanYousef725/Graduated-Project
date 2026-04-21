import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduated_project/Search%20&%20Discovery/contolers/cubit/product_cubit.dart';
import 'package:graduated_project/Search%20&%20Discovery/widgets/outline_border.dart';

class BuildSearchBar extends StatelessWidget {
  const BuildSearchBar({
    super.key,
    required this.searchController,
    required this.context,
  });
  final BuildContext context;
  final TextEditingController searchController;
  @override
  Widget build(context) {
    return Container(
      padding: EdgeInsets.all(16.dg),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            width: 1.dg,
            color: const Color.fromRGBO(241, 245, 249, 1),
          ),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 24),
              ),
              Text(
                "Search Results",
                style: GoogleFonts.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Builder(
            builder: (context) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 4,
                    child: TextField(
                      controller: searchController,
                      onTapOutside: (_) {
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                      onChanged: (value) {
                        context.read<ProductCubit>().runFilter(value);
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(16.dg),
                        fillColor: const Color.fromRGBO(241, 245, 249, 1),
                        filled: true,
                        hintText: "Search here...",
                        enabledBorder: outlineBorder(),
                        focusedBorder: outlineBorder(),
                        prefixIcon: buildIcon("assets/images/SVG.png"),
                        suffixIcon: IconButton(
                          onPressed: () {
                            searchController.value = const TextEditingValue(
                              text: "",
                              selection: TextSelection.collapsed(offset: 0),
                            );
                            context.read<ProductCubit>().runFilter("");
                          },
                          icon: Image.asset(
                            "assets/images/SVG (1).png",
                            width: 24.dg,
                            height: 24.dg,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: PopupMenuButton<String>(
                      color: Colors.white,
                      elevation: 0.dg,
                      itemBuilder: (context) => List.generate(
                        context.read<ProductCubit>().products.length,
                        (index) => PopupMenuItem<String>(
                          value: context
                              .read<ProductCubit>()
                              .products[index]
                              .category
                              .toString(),
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12.dg),
                              border: Border.all(
                                width: 1.dg,
                                color: const Color.fromRGBO(241, 245, 249, 1),
                              ),
                            ),
                            child: Text(
                              context
                                  .read<ProductCubit>()
                                  .products[index]
                                  .category
                                  .toString(),
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w600,
                                fontSize: 12.dg,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                      onSelected: (value) {
                        context.read<ProductCubit>().sortByCategory(value);
                      },

                      offset: Offset(0, 100),
                      child: Image.asset(
                        "assets/images/Filter Button.png",
                        width: 54.dg,
                        height: 54.dg,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
