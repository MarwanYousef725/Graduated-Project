import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduated_project/Search%20&%20Discovery/contolers/cubit/product_cubit.dart';
import 'package:graduated_project/Search%20&%20Discovery/models/product_model.dart';

class BuildAddButton extends StatelessWidget {
  final PharmacyProducts item;
  const BuildAddButton({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('Cart_Products')
          .where("id", isEqualTo: item.id)
          .snapshots(),

      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox();
        }

        int quantity = snapshot.data!.docs.length;
        return GestureDetector(
          onTap: item.isInStock || item.isLowStock
              ? () {
                  context.read<ProductCubit>().addProductToCart(item);
                }
              : null,
          child: Container(
            width: 24.dg,
            height: 24.dg,
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: item.isInStock || item.isLowStock
                  ? Color.fromRGBO(45, 159, 117, 1)
                  : Color.fromRGBO(45, 159, 117, 0.322),
              borderRadius: BorderRadius.circular(6.dg),
            ),
            child: quantity > 0
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        quantity.toString(),
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
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
                    child: Icon(Icons.add, color: Colors.white, size: 16.dg),
                  ),
          ),
        );
      },
    );
  }
}
