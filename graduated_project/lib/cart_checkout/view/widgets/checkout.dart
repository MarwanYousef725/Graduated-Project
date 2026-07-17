import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduated_project/Search%20&%20Discovery/contolers/cubit/product_cubit.dart';
import 'package:graduated_project/Search%20&%20Discovery/models/product_model.dart';
import 'package:graduated_project/cart_checkout/view/widgets/cart3.dart';

class Checkout extends StatefulWidget {
  const Checkout({super.key});

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  final List<Map<String, dynamic>> details = [
    {"image": "assets/Container.png", "text": "Credit Card"},
    {"image": "assets/Container (1).png", "text": "PayPal"},
    {"image": "assets/SVG (8).png", "text": "Cash on Delivery"},
  ];
  String selectedvalue = "Credit Card";

  String _getUid() {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) throw Exception("User missing");
    return uid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          final cubit = context.read<ProductCubit>();
          return Container(
            height: 89.dg,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(
                  width: 1.dg,
                  color: const Color.fromRGBO(226, 232, 240, 1),
                ),
              ),
            ),
            child: Center(
              child: GestureDetector(
                onTap: cubit.totalPrice == 0
                    ? null
                    : () {
                        cubit.addOrderToHistory();
                        cubit.removeAll();
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => const Cart3(),
                          ),
                          (route) => false,
                        );
                      },
                child: Container(
                  height: 56.dg,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.dg),
                    color: cubit.totalPrice == 0
                        ? Colors.grey
                        : const Color(0xff2D9F75),
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromRGBO(45, 159, 117, 0.2),
                        blurRadius: 6.dg,
                        spreadRadius: -4.dg,
                        offset: const Offset(0, 4),
                      ),
                      BoxShadow(
                        color: const Color.fromRGBO(45, 159, 117, 0.2),
                        blurRadius: 15.dg,
                        spreadRadius: -3.dg,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Place Order",
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(width: 3),
                      const Directionality(
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
          );
        },
      ),
      backgroundColor: const Color.fromRGBO(246, 248, 247, 1),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("Users")
            .doc(_getUid())
            .collection("Cart_Products")
            .snapshots(),
        builder: (context, snapShot) {
          if (snapShot.hasData) {
            final products = snapShot.data!.docs
                .map(
                  (doc) => PharmacyProducts.fromJson(
                    doc.data() as Map<String, dynamic>,
                  ),
                )
                .toList();
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (context.mounted) {
                context.read<ProductCubit>().calculateTotalPrice(products);
              }
            });
          }
          if (snapShot.hasError) {
            return Center(child: Text("Error: ${snapShot.error}"));
          }
          if (!snapShot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final cubit = context.read<ProductCubit>()
            ..calculateTotalPrice(
              snapShot.data!.docs
                  .map(
                    (doc) => PharmacyProducts.fromJson(
                      doc.data() as Map<String, dynamic>,
                    ),
                  )
                  .toList(),
            );
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
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Image.asset("assets/Button - Go back.png"),
                    ),
                    Text(
                      "Checkout      ",
                      style: GoogleFonts.inter(
                        fontSize: 18.dg,
                        fontWeight: FontWeight.w700,
                        color: const Color.fromRGBO(15, 23, 42, 1),
                      ),
                    ),
                    const SizedBox.shrink(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "DELIVERY ADDRESS",
                      style: GoogleFonts.inter(
                        fontSize: 14.dg,
                        color: const Color.fromRGBO(100, 116, 139, 1),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "Change",
                      style: GoogleFonts.inter(
                        fontSize: 14.dg,
                        color: const Color(0xff2D9F75),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.dg),
                    color: Colors.white,
                    boxShadow: [
                      const BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.05),
                        blurRadius: 2,
                        offset: Offset(0, 1),
                      ),
                    ],
                    border: Border.all(
                      width: 1,
                      color: const Color.fromRGBO(241, 245, 249, 1),
                    ),
                  ),
                  child: Row(
                    spacing: 12.dg,
                    children: [
                      Image.asset(
                        "assets/images/address.png",
                        height: 36.dg,
                        width: 36.dg,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Home",
                              style: GoogleFonts.inter(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: const Color.fromRGBO(30, 41, 59, 1),
                              ),
                            ),
                            Text(
                              "123 Health Avenue, Suite 4B \nMedical District, NY 10001",
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: const Color.fromRGBO(100, 116, 139, 1),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "PAYMENT METHOD",
                  style: GoogleFonts.inter(
                    fontSize: 14.dg,
                    color: const Color.fromRGBO(100, 116, 139, 1),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 12),
                itemCount: 3,
                itemBuilder: (context, index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.dg),
                    color: Colors.white,
                    border: Border.all(
                      width: 1,
                      color: const Color.fromRGBO(241, 245, 249, 1),
                    ),
                    boxShadow: [
                      const BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.05),
                        blurRadius: 2,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        spacing: 10,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(243, 244, 246, 1),
                              borderRadius: BorderRadius.circular(4.dg),
                            ),
                            child: Image.asset(
                              "${details[index]["image"]}",
                              height: 24.dg,
                              width: 40.dg,
                            ),
                          ),
                          Text(
                            "${details[index]["text"]}",
                            style: GoogleFonts.inter(
                              fontSize: 14.dg,
                              fontWeight: FontWeight.w500,
                              color: const Color.fromRGBO(15, 23, 42, 1),
                            ),
                          ),
                        ],
                      ),
                      Radio<String>(
                        activeColor: const Color(0xff2D9F75),
                        value: "${details[index]["text"]}",
                        groupValue: selectedvalue,
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              selectedvalue = value;
                            });
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "ORDER SUMMARY",
                  style: GoogleFonts.inter(
                    fontSize: 14.dg,
                    color: const Color.fromRGBO(100, 116, 139, 1),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.dg),
                  border: Border.all(
                    width: 1.dg,
                    color: const Color.fromRGBO(243, 244, 246, 1),
                  ),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromRGBO(0, 0, 0, 0.05),
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
                          "\$${cubit.totalPrice}",
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
                    SizedBox(height: 8.dg),
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
                          cubit.totalPrice == 0
                              ? "\$0"
                              : "\$${cubit.totalPrice + 35}",
                          style: GoogleFonts.inter(
                            color: const Color.fromRGBO(45, 159, 117, 1),
                            fontSize: 24.dg,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.dg),
            ],
          );
        },
      ),
    );
  }
}
