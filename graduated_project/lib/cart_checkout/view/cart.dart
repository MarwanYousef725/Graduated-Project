import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduated_project/Search%20&%20Discovery/contolers/cubit/product_cubit.dart';
import 'package:graduated_project/Search%20&%20Discovery/models/product_model.dart';
import 'package:graduated_project/Search%20&%20Discovery/widgets/product_card.dart';
import 'package:graduated_project/cart_checkout/view/widgets/checkout.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          final cartCubit2 = context.read<ProductCubit>();
          return Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24.dg),
                topRight: Radius.circular(24.dg),
              ),
              border: Border(
                top: BorderSide(
                  width: 1.dg,
                  color: const Color.fromRGBO(243, 244, 246, 1),
                ),
              ),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.05),
                  blurRadius: 15.dg,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Subtotal",
                      style: GoogleFonts.inter(
                        color: const Color.fromRGBO(107, 114, 128, 1),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      "\$${cartCubit2.totalPrice}",
                      style: GoogleFonts.inter(
                        color: const Color.fromRGBO(107, 114, 128, 1),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.dg),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Delivery Fee",
                      style: GoogleFonts.inter(
                        color: const Color.fromRGBO(107, 114, 128, 1),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      "\$35",
                      style: GoogleFonts.inter(
                        color: const Color.fromRGBO(107, 114, 128, 1),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.dg),
                Divider(
                  thickness: 1.dg,
                  color: const Color.fromRGBO(243, 244, 246, 1),
                ),
                SizedBox(height: 24.dg),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total Price",
                      style: GoogleFonts.inter(
                        color: const Color.fromRGBO(15, 23, 42, 1),
                        fontSize: 18.dg,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      cartCubit2.totalPrice == 0
                          ? "\$0"
                          : "\$${cartCubit2.totalPrice + 35}",
                      style: GoogleFonts.inter(
                        color: const Color.fromRGBO(45, 159, 117, 1),
                        fontSize: 24.dg,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24.dg),
                GestureDetector(
                  onTap: cartCubit2.totalPrice == 0
                      ? null
                      : () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => Checkout()),
                          );
                        },
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.dg),
                      color: cartCubit2.totalPrice == 0
                          ? Colors.grey
                          : const Color.fromRGBO(45, 159, 117, 1),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Proceed to Checkout",
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 16.dg,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(width: 3),
                          Directionality(
                            textDirection: TextDirection.rtl,
                            child: Icon(
                              Icons.arrow_back_sharp,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      backgroundColor: const Color.fromRGBO(246, 248, 247, 1),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("Users")
            .doc(FirebaseAuth.instance.currentUser!.uid)
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
          return ListView(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                height: 61.dg,
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Color.fromRGBO(243, 244, 246, 1),
                      width: 1,
                    ),
                  ),
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "My Cart",
                      style: GoogleFonts.inter(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: const Color.fromRGBO(15, 23, 42, 1),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: const Color.fromRGBO(234, 245, 241, 1),
                      ),
                      child: Text(
                        "$cartCount Items",
                        style: GoogleFonts.inter(
                          color: const Color.fromRGBO(45, 159, 117, 1),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.dg),

              snapShot.hasData == true
                  ? snapShot.data!.docs.isNotEmpty == true
                        ? ListView.separated(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            separatorBuilder: (context, index) =>
                                SizedBox(height: 10.dg),
                            shrinkWrap: true,
                            itemCount: snapShot.data!.docs.length,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return BuildProductCard(
                                item: PharmacyProducts.fromJson(
                                  snapShot.data!.docs[index].data()
                                      as Map<String, dynamic>,
                                ),
                                context: context,
                              );
                            },
                          )
                        : Center(
                            child: Center(
                              child: Text(
                                "No items in cart",
                                style: GoogleFonts.inter(
                                  fontSize: 16.dg,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          )
                  : const Center(
                      child: CircularProgressIndicator(
                        color: Color.fromRGBO(5, 150, 105, 1),
                      ),
                    ),

              const SizedBox(height: 20),
            ],
          );
        },
      ),
    );
  }
}
