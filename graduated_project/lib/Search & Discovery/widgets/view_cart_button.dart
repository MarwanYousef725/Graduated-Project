import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduated_project/Search%20&%20Discovery/contolers/cubit/product_cubit.dart';
import 'package:graduated_project/Search%20&%20Discovery/models/product_model.dart';

class ViewCartButton extends StatelessWidget {
  const ViewCartButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 16.dg,
        right: 16.dg,
        top: 16.dg,
        bottom: 32.dg,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            width: 1.dg,
            color: const Color.fromRGBO(241, 245, 249, 1),
          ),
        ),
      ),
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("Cart_Products")
            .snapshots(),
        builder: (context, snapShot) {
          if (snapShot.hasData) {
            List<PharmacyProducts> products = snapShot.data!.docs
                .map(
                  (doc) => PharmacyProducts.fromJson(
                    doc.data() as Map<String, dynamic>,
                  ),
                )
                .toList();
            context.read<ProductCubit>().calculateTotalPrice(products);
          }
          int cartCount = 0;
          if (snapShot.hasError) {
            return Center(child: Text("Error: ${snapShot.error}"));
          }

          if (snapShot.hasData) {
            cartCount = snapShot.data!.docs.length;
          }
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                spacing: 12.dg,
                children: [
                  Stack(
                    children: [
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(234, 246, 241, 1),
                          borderRadius: BorderRadius.circular(12.dg),
                        ),
                        child: Image.asset(
                          "assets/images/cart.png",
                          color: Color.fromRGBO(45, 159, 117, 1),
                          width: 18.dg,
                          height: 18.dg,
                        ),
                      ),
                      Positioned(
                        top: 0.dg,
                        right: 0.dg,
                        child: Container(
                          width: 16.dg,
                          height: 16.dg,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(239, 68, 68, 1),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              "$cartCount",
                              style: GoogleFonts.inter(
                                fontSize: 10.dg,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "$cartCount Items in Cart",
                        style: GoogleFonts.inter(
                          fontSize: 12.dg,
                          fontWeight: FontWeight.w600,
                          color: Color.fromRGBO(100, 116, 139, 1),
                        ),
                      ),
                      Text(
                        "\$${context.read<ProductCubit>().totalPrice}",
                        style: GoogleFonts.inter(
                          fontSize: 14.dg,
                          fontWeight: FontWeight.w700,
                          color: Color.fromRGBO(30, 41, 59, 1),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  padding: EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 10.dg,
                  ),
                  backgroundColor: Color.fromRGBO(15, 23, 42, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.dg),
                  ),
                ),
                onPressed: () {},
                child: Text(
                  "View Cart",
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 14.dg,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
