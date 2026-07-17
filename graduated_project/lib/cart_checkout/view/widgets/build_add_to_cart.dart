import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduated_project/Search%20&%20Discovery/contolers/cubit/product_cubit.dart';
import 'package:graduated_project/Search%20&%20Discovery/models/product_model.dart';

class BuildAddToCart extends StatelessWidget {
  final PharmacyProducts item;
  const BuildAddToCart({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('Cart_Products')
          .where("id", isEqualTo: item.id)
          .snapshots(),

      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox();
        }

        int quantity = 0;
        for (var doc in snapshot.data!.docs) {
          quantity +=
              PharmacyProducts.fromJson(
                doc.data() as Map<String, dynamic>,
              ).quantity ??
              0;
        }
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
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    spacing: 20.dg,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () => context
                            .read<ProductCubit>()
                            .decreaseQuantity(item.id!),
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
                          color: Color.fromRGBO(45, 159, 117, 1),

                          borderRadius: BorderRadius.circular(8.dg),
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
                        onTap: () =>
                            context.read<ProductCubit>().addProductToCart(item),
                        child: Icon(
                          Icons.add,
                          color: Color.fromRGBO(45, 159, 117, 1),
                          size: 18.dg,
                        ),
                      ),
                    ],
                  ),
                )
              : ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: Color.fromRGBO(45, 159, 117, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.dg),
                    ),
                  ),
                  onPressed: item.isInStock || item.isLowStock
                      ? () =>
                            context.read<ProductCubit>().addProductToCart(item)
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

        // return GestureDetector(
        //   onTap: item.isInStock || item.isLowStock
        //       ? () {
        //           context.read<ProductCubit>().addProductToCart(item);
        //         }
        //       : null,
        //   child: Container(
        //     width: 24.dg,
        //     height: 24.dg,
        //     padding: EdgeInsets.all(4),
        //     decoration: BoxDecoration(
        //       color: item.isInStock || item.isLowStock
        //           ? Color.fromRGBO(45, 159, 117, 1)
        //           : Color.fromRGBO(45, 159, 117, 0.322),
        //       borderRadius: BorderRadius.circular(6.dg),
        //     ),
        //     child: quantity > 0
        //         ? Row(
        //             mainAxisAlignment: MainAxisAlignment.center,
        //             crossAxisAlignment: CrossAxisAlignment.center,
        //             children: [
        //               Text(
        //                 quantity.toString(),
        //                 textAlign: TextAlign.center,
        //                 style: GoogleFonts.inter(
        //                   fontWeight: FontWeight.w600,
        //                   fontSize: 12.dg,
        //                   color: Colors.white,
        //                 ),
        //               ),
        //               Center(
        //                 child: Icon(
        //                   Icons.add,
        //                   color: Colors.white,
        //                   size: 16.dg,
        //                 ),
        //               ),
        //             ],
        //           )
        //         : Center(
        //             child: Icon(Icons.add, color: Colors.white, size: 16.dg),
        //           ),
        //   ),
        // );
      },
    );
  }
}
