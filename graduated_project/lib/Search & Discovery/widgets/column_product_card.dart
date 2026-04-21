import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduated_project/Search%20&%20Discovery/contolers/cubit/product_cubit.dart';
import 'package:graduated_project/Search%20&%20Discovery/view/product_details.dart';

class ColumnProductCard extends StatelessWidget {
  const ColumnProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        final productCubit = context.read<ProductCubit>();
        if (state is ProductLoading) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is ProductError) {
          return Center(child: Text("error"));
        }
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SizedBox(width: 20.dg),

              Row(
                spacing: 16.dg,
                children: List.generate(6, (index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetails(
                            product: productCubit.products[index],
                          ),
                        ),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.all(12.dg),
                      width: 160.dg,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(255, 255, 255, 1),
                        borderRadius: BorderRadius.circular(12.dg),
                        border: Border.all(
                          color: Color.fromRGBO(243, 244, 246, 1),
                          width: 1.dg,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.05),
                            offset: Offset(0.dg, 1.dg),
                            blurRadius: 2.dg,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 8.dg,
                        children: [
                          Image.network(
                            productCubit.products[index].images![0],
                            width: 134.dg,
                            height: 112.dg,
                            cacheHeight: 112,
                            cacheWidth: 134,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              }
                              return Center(child: CircularProgressIndicator());
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return Center(child: Text("Error loading image"));
                            },
                          ),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                child: Text(
                                  "${productCubit.products[index].name}",
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14.dg,
                                    color: Color.fromRGBO(17, 24, 39, 1),
                                  ),
                                ),
                              ),
                              SizedBox(
                                child: Text(
                                  "${productCubit.products[index].description}",
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12.dg,
                                    color: Color.fromRGBO(107, 114, 128, 1),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 3,
                                child: Text(
                                  "\$${productCubit.products[index].priceUsd}",
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16.dg,
                                    color: Color.fromRGBO(45, 159, 117, 1),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: StreamBuilder<QuerySnapshot>(
                                  stream: FirebaseFirestore.instance
                                      .collection('Cart_Products')
                                      .where(
                                        "id",
                                        isEqualTo:
                                            productCubit.products[index].id,
                                      )
                                      .snapshots(),

                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData) {
                                      return const SizedBox();
                                    }

                                    int quantity = snapshot.data!.docs.length;
                                    return GestureDetector(
                                      onTap:
                                          productCubit
                                                  .products[index]
                                                  .isInStock ||
                                              productCubit
                                                  .products[index]
                                                  .isLowStock
                                          ? () {
                                              context
                                                  .read<ProductCubit>()
                                                  .addProductToCart(
                                                    productCubit
                                                        .products[index],
                                                  );
                                            }
                                          : null,
                                      child: Container(
                                        width: 24.dg,
                                        height: 24.dg,
                                        padding: EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          color:
                                              productCubit
                                                      .products[index]
                                                      .isInStock ||
                                                  productCubit
                                                      .products[index]
                                                      .isLowStock
                                              ? Color.fromRGBO(45, 159, 117, 1)
                                              : Color.fromRGBO(
                                                  45,
                                                  159,
                                                  117,
                                                  0.322,
                                                ),
                                          borderRadius: BorderRadius.circular(
                                            6.dg,
                                          ),
                                        ),
                                        child: quantity > 0
                                            ? Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    quantity.toString(),
                                                    textAlign: TextAlign.center,
                                                    style: GoogleFonts.inter(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 12.dg,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Center(
                                                    child: Icon(
                                                      Icons.add,
                                                      color: Colors.white,
                                                      size: 16.dg,
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : Center(
                                                child: Icon(
                                                  Icons.add,
                                                  color: Colors.white,
                                                  size: 16.dg,
                                                ),
                                              ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
              SizedBox(width: 20.dg),
            ],
          ),
        );
      },
    );
  }
}
