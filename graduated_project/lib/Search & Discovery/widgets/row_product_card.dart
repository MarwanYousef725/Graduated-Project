import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduated_project/Search%20&%20Discovery/contolers/cubit/product_cubit.dart';
import 'package:graduated_project/Search%20&%20Discovery/models/product_model.dart';
import 'package:graduated_project/Search%20&%20Discovery/view/product_details.dart';

class RowProductCard extends StatelessWidget {
  const RowProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser?.uid ?? '';

    return BlocBuilder<ProductCubit, ProductState>(
      buildWhen: (previous, current) =>
          current is ProductLoading ||
          current is ProductError ||
          current is ProductSuccess,
      builder: (context, state) {
        final productCubit = context.read<ProductCubit>();
        if (state is ProductLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: Color.fromRGBO(5, 150, 105, 1),
            ),
          );
        }
        if (state is ProductError) {
          return const Center(child: Text("Error"));
        }

        int availableItems = productCubit.products.length > 10
            ? (productCubit.products.length - 10).clamp(0, 10)
            : 0;

        if (availableItems == 0) {
          return const SizedBox.shrink();
        }

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SizedBox(width: 20.dg),
              Row(
                spacing: 16.dg,
                children: List.generate(availableItems, (index) {
                  final int actualIndex = index + 10;
                  final currentProduct = productCubit.products[actualIndex];

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ProductDetails(product: currentProduct),
                        ),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                        right: 12.dg,
                        bottom: 12.dg,
                        top: 12.dg,
                      ),
                      width: 300.dg,
                      height: 120.dg,
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(255, 255, 255, 1),
                        borderRadius: BorderRadius.circular(12.dg),
                        border: Border.all(
                          color: const Color.fromRGBO(243, 244, 246, 1),
                          width: 1.dg,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromRGBO(0, 0, 0, 0.05),
                            offset: Offset(0.dg, 1.dg),
                            blurRadius: 2.dg,
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          CachedNetworkImage(
                            imageUrl:
                                (currentProduct.images != null &&
                                    currentProduct.images!.isNotEmpty)
                                ? currentProduct.images![0]
                                : '',
                            width: 134.dg,
                            height: 112.dg,
                            errorWidget: (context, error, stackTrace) {
                              return Container(
                                alignment: Alignment.center,
                                child: Icon(
                                  Icons.broken_image_rounded,
                                  color: Colors.red,
                                  size: 32.dg,
                                ),
                              );
                            },
                            placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator(
                                color: Color.fromRGBO(5, 150, 105, 1),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      currentProduct.name ?? '',
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.inter(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14.dg,
                                        color: const Color.fromRGBO(
                                          17,
                                          24,
                                          39,
                                          1,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      currentProduct.description ?? '',
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.inter(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12.dg,
                                        color: const Color.fromRGBO(
                                          107,
                                          114,
                                          128,
                                          1,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Text(
                                        "\$${currentProduct.priceUsd ?? '0.00'}",
                                        style: GoogleFonts.inter(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16.dg,
                                          color: const Color.fromRGBO(
                                            45,
                                            159,
                                            117,
                                            1,
                                          ),
                                        ),
                                      ),
                                    ),
                                    if (userId.isNotEmpty)
                                      Expanded(
                                        flex: 1,
                                        child: StreamBuilder<QuerySnapshot>(
                                          stream: FirebaseFirestore.instance
                                              .collection('Users')
                                              .doc(userId)
                                              .collection('Cart_Products')
                                              .where(
                                                "id",
                                                isEqualTo: currentProduct.id,
                                              )
                                              .snapshots(),
                                          builder: (context, snapshot) {
                                            if (!snapshot.hasData ||
                                                snapshot.data == null) {
                                              return const SizedBox.shrink();
                                            }
                                            int quantity = 0;
                                            if (snapshot
                                                .data!
                                                .docs
                                                .isNotEmpty) {
                                              final docData =
                                                  snapshot.data!.docs[0].data()
                                                      as Map<String, dynamic>?;
                                              if (docData != null) {
                                                quantity =
                                                    PharmacyProducts.fromJson(
                                                      docData,
                                                    ).quantity ??
                                                    0;
                                              }
                                            }

                                            final bool canAddToCart =
                                                currentProduct.isInStock ||
                                                currentProduct.isLowStock;

                                            return GestureDetector(
                                              onTap: canAddToCart
                                                  ? () => context
                                                        .read<ProductCubit>()
                                                        .addProductToCart(
                                                          currentProduct,
                                                        )
                                                  : null,
                                              child: Container(
                                                width: 24.dg,
                                                height: 24.dg,
                                                padding: const EdgeInsets.all(
                                                  4,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: canAddToCart
                                                      ? const Color.fromRGBO(
                                                          45,
                                                          159,
                                                          117,
                                                          1,
                                                        )
                                                      : const Color.fromRGBO(
                                                          45,
                                                          159,
                                                          117,
                                                          0.322,
                                                        ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        6.dg,
                                                      ),
                                                ),
                                                child: quantity > 0
                                                    ? Center(
                                                        child: Text(
                                                          quantity.toString(),
                                                          textAlign:
                                                              TextAlign.center,
                                                          style:
                                                              GoogleFonts.inter(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize: 12.dg,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                        ),
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
