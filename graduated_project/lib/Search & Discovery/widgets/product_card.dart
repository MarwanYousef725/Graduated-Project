import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduated_project/Search%20&%20Discovery/contolers/cubit/product_cubit.dart';
import 'package:graduated_project/Search%20&%20Discovery/models/product_model.dart';
import 'package:graduated_project/Search%20&%20Discovery/view/product_details.dart';

class ProductCard extends StatelessWidget {
  final PharmacyProducts product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetails(product: product),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            width: 1.dg,
            color: Color.fromRGBO(241, 245, 249, 1),
          ),
          borderRadius: BorderRadius.circular(12.dg),
          boxShadow: [
            BoxShadow(
              color: const Color.fromRGBO(0, 0, 0, 0.05),
              offset: const Offset(0, 1),
              blurRadius: 2,
            ),
          ],
        ),
        child: Row(
          spacing: 16.dg,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.dg),
              child: Image.network(
                product.images![0],
                width: 96.dg,
                height: 96.dg,
                cacheHeight: 96,
                cacheWidth: 96,
                loadingBuilder: (context, child, loadingProgress) {
                  return loadingProgress == null
                      ? child
                      : const Center(child: CircularProgressIndicator());
                },
                errorBuilder: (context, error, stackTrace) {
                  return const Center(
                    child: Icon(Icons.broken_image, size: 24),
                  );
                },
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 8.dg,
                children: [
                  SizedBox(
                    width: 200.dg,
                    child: Text(
                      product.name!,
                      maxLines: 2,
                      style: GoogleFonts.inter(
                        fontSize: 16.dg,
                        fontWeight: FontWeight.w600,
                        color: const Color.fromRGBO(30, 41, 59, 1),
                      ),
                    ),
                  ),
                  Text(
                    "${product.packSize}",
                    style: GoogleFonts.inter(
                      fontSize: 12.dg,
                      fontWeight: FontWeight.w400,
                      color: const Color.fromRGBO(100, 116, 139, 1),
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    spacing: 6.dg,
                    children: [
                      Container(
                        width: 6.dg,
                        height: 6.dg,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: (product.isInStock)
                              ? Color.fromRGBO(45, 159, 117, 1)
                              : product.isLowStock
                              ? Color.fromRGBO(159, 148, 45, 1)
                              : Color.fromRGBO(159, 45, 45, 1),
                        ),
                      ),
                      Text(
                        (product.isInStock)
                            ? "IN STOCK"
                            : (product.isLowStock)
                            ? "LOW STOCK"
                            : "OUT OF STOCK",
                        style: GoogleFonts.inter(
                          fontSize: 12.dg,
                          fontWeight: FontWeight.w500,
                          color: (product.isInStock)
                              ? Color.fromRGBO(45, 159, 117, 1)
                              : product.isLowStock
                              ? Color.fromRGBO(159, 148, 45, 1)
                              : Color.fromRGBO(159, 45, 45, 1),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "\$${product.priceUsd}",
                        style: GoogleFonts.inter(
                          fontSize: 18.dg,
                          fontWeight: FontWeight.w700,
                          color: const Color.fromRGBO(15, 23, 42, 1),
                        ),
                      ),
                      StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('Cart_Products')
                            .where("id", isEqualTo: product.id)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) return const SizedBox();

                          int quantity = snapshot.data!.docs.length;

                          return Container(
                            height: 32.dg,
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(164, 253, 220, 0.322),

                              borderRadius: BorderRadius.circular(12.dg),
                              border: Border.all(
                                color: Color.fromRGBO(45, 159, 117, 1),
                                width: 1.dg,
                              ),
                            ),
                            child: quantity > 0
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0,
                                    ),
                                    child: Row(
                                      spacing: 20.dg,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        GestureDetector(
                                          onTap: () => context
                                              .read<ProductCubit>()
                                              .removeProductFromCart(
                                                product.id!,
                                              ),
                                          child: Icon(
                                            Icons.remove,
                                            color: Color(0xFF2D9F75),
                                            size: 18.dg,
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 6.dg,
                                            vertical: 2.dg,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Color.fromRGBO(
                                              45,
                                              159,
                                              117,
                                              1,
                                            ),

                                            borderRadius: BorderRadius.circular(
                                              8.dg,
                                            ),
                                          ),
                                          child: Text(
                                            "$quantity",
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () => context
                                              .read<ProductCubit>()
                                              .addProductToCart(product),
                                          child: Icon(
                                            Icons.add,
                                            color: Color.fromRGBO(
                                              45,
                                              159,
                                              117,
                                              1,
                                            ),
                                            size: 18.dg,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      backgroundColor: Color.fromRGBO(
                                        45,
                                        159,
                                        117,
                                        1,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          12.dg,
                                        ),
                                      ),
                                    ),
                                    onPressed:
                                        product.isInStock || product.isLowStock
                                        ? () => context
                                              .read<ProductCubit>()
                                              .addProductToCart(product)
                                        : null,
                                    child: Text(
                                      "Add to Cart",
                                      style: GoogleFonts.inter(
                                        fontSize: 14.dg,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                          );
                        },
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
  }
}
