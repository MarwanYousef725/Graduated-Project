import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduated_project/Search%20&%20Discovery/contolers/cubit/product_cubit.dart';
import 'package:graduated_project/Search%20&%20Discovery/models/product_model.dart';

class ProductDetails extends StatelessWidget {
  final PharmacyProducts product;
  const ProductDetails({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: Colors.white,
          body: ListView(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    bottom: BorderSide(
                      width: 1.dg,
                      color: Color.fromRGBO(243, 244, 246, 1),
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.arrow_back_ios_new_rounded, size: 24.dg),
                    ),
                    Text(
                      "Medicine Details",
                      style: GoogleFonts.inter(
                        fontSize: 18.dg,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('Fav_Products')
                          .where("id", isEqualTo: product.id)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) return const SizedBox();
                        PharmacyProducts favProduct = product;
                        if (snapshot.data!.docs.isNotEmpty) {
                          favProduct = PharmacyProducts.fromJson(
                            snapshot.data!.docs.first.data(),
                          );
                        } else {
                          favProduct.isFavorite = false;
                        }
                        return IconButton(
                          onPressed: () {
                            BlocProvider.of<ProductCubit>(
                              context,
                            ).addFavProduct(favProduct);
                          },
                          icon: Icon(
                            favProduct.isFavorite == true
                                ? Icons.favorite_rounded
                                : Icons.favorite_border_rounded,
                            size: 24.dg,
                            color: favProduct.isFavorite == true
                                ? Colors.red
                                : Colors.black,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(32),
                width: 390.dg,
                height: 390.dg,
                color: Color.fromRGBO(249, 250, 251, 1),
                child: Container(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  width: 326.dg,
                  height: 326.dg,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.dg),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.03),
                        offset: Offset(0, 20),
                        blurRadius: 13,
                      ),
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.08),
                        offset: Offset(0, 8),
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: Image.network(
                    product.images![0],
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.error,
                          color: Colors.red,
                          size: 32.dg,
                        ),
                      );
                    },
                    loadingBuilder: (context, child, loadingProgress) =>
                        loadingProgress == null
                        ? child
                        : Center(child: CircularProgressIndicator()),
                    cacheHeight: 326,
                    cacheWidth: 326,
                  ),
                ),
              ),
              SizedBox(height: 24.dg),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  spacing: 8.dg,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 220.dg,
                          child: Text(
                            product.name ?? "",
                            style: GoogleFonts.inter(
                              fontSize: 24.dg,
                              fontWeight: FontWeight.w700,
                              color: Color.fromRGBO(17, 24, 39, 1),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 4,
                            horizontal: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(254, 252, 232, 1),
                            borderRadius: BorderRadius.circular(8.dg),
                          ),
                          child: Row(
                            spacing: 4.dg,
                            children: [
                              Icon(
                                Icons.star,
                                size: 16.dg,
                                color: Color.fromRGBO(234, 179, 8, 1),
                              ),
                              Text(
                                "${product.rating} (${product.reviews}) ",
                                style: GoogleFonts.inter(
                                  fontSize: 14.dg,
                                  fontWeight: FontWeight.w700,
                                  color: Color.fromRGBO(161, 98, 7, 1),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      spacing: 8.dg,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "\$${product.priceUsd}",
                          style: GoogleFonts.inter(
                            fontSize: 30.dg,
                            fontWeight: FontWeight.w700,
                            color: Color.fromRGBO(45, 159, 117, 1),
                          ),
                        ),
                        Text(
                          "\$${getPriceBeforeDiscount(product.priceUsd ?? 0).toStringAsFixed(2)}",
                          style: GoogleFonts.inter(
                            decoration: TextDecoration.lineThrough,
                            fontSize: 14.dg,
                            fontWeight: FontWeight.w400,
                            color: Color.fromRGBO(156, 163, 175, 1),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                      decoration: BoxDecoration(
                        color: (product.isInStock)
                            ? Color.fromRGBO(220, 252, 231, 1)
                            : product.isLowStock
                            ? Color.fromRGBO(252, 248, 220, 1)
                            : Color.fromRGBO(252, 220, 220, 1),
                        borderRadius: BorderRadius.circular(100.dg),
                      ),
                      child: Row(
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
                                ? "In Stock (${product.stockQuantity} units available)"
                                : (product.isLowStock)
                                ? "Low Stock (${product.stockQuantity} units available)"
                                : "Out of Stock",
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
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.dg),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  "Description",
                  style: GoogleFonts.inter(
                    fontSize: 18.dg,
                    fontWeight: FontWeight.w700,
                    color: Color.fromRGBO(17, 24, 39, 1),
                  ),
                ),
              ),
              SizedBox(height: 8.dg),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  product.description ?? "",
                  style: GoogleFonts.inter(
                    fontSize: 16.dg,
                    fontWeight: FontWeight.w400,
                    color: Color.fromRGBO(75, 85, 99, 1),
                  ),
                ),
              ),
              SizedBox(height: 24.dg),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(45, 159, 117, 0.05),
                  borderRadius: BorderRadius.circular(12.dg),
                  border: Border.all(
                    color: Color.fromRGBO(45, 159, 117, 0.1),
                    width: 1.dg,
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      spacing: 8.dg,
                      children: [
                        Image.asset(
                          "assets/images/Dosage Instructions.png",
                          width: 20.dg,
                          height: 20.dg,
                        ),
                        Text(
                          "Dosage Instructions",
                          style: GoogleFonts.inter(
                            fontSize: 18.dg,
                            fontWeight: FontWeight.w700,
                            color: Color.fromRGBO(45, 159, 117, 1),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.dg),
                    Text(
                      product.dosageInstructions ?? "",
                      style: GoogleFonts.inter(
                        fontSize: 14.dg,
                        fontWeight: FontWeight.w400,
                        color: Color.fromRGBO(55, 65, 81, 1),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.dg),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  "Side Effects",
                  style: GoogleFonts.inter(
                    fontSize: 18.dg,
                    fontWeight: FontWeight.w700,
                    color: Color.fromRGBO(17, 24, 39, 1),
                  ),
                ),
              ),

              SizedBox(height: 8.dg),
              sideEffects(product, "Common Side Effects", "common"),
              SizedBox(height: 8.dg),
              Divider(color: Color.fromRGBO(243, 244, 246, 1)),
              SizedBox(height: 8.dg),
              sideEffects(product, "Rare Side Effects", "rare"),
              SizedBox(height: 8.dg),
              Divider(color: Color.fromRGBO(243, 244, 246, 1)),
              SizedBox(height: 8.dg),
              sideEffects(product, "Uncommon Side Effects", "uncommon"),
              SizedBox(height: 24.dg),

              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    top: BorderSide(
                      width: 1.dg,
                      color: Color.fromRGBO(243, 244, 246, 1),
                    ),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.05),
                      offset: Offset(0, -4),
                      blurRadius: 20.dg,
                    ),
                  ],
                ),
                padding: EdgeInsets.only(
                  bottom: 30,
                  left: 20,
                  right: 20,
                  top: 20,
                ),
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('Cart_Products')
                      .where("id", isEqualTo: product.id)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) return const SizedBox();

                    int quantity = snapshot.data!.docs.length;

                    return Container(
                      width: double.infinity,
                      height: 60.dg,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(164, 253, 220, 0.322),

                        borderRadius: BorderRadius.circular(12.dg),
                        border: Border.all(
                          color: Color.fromRGBO(45, 159, 117, 1),
                          width: 1.dg,
                        ),
                      ),
                      child: quantity > 0
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                IconButton(
                                  onPressed: () => context
                                      .read<ProductCubit>()
                                      .removeProductFromCart(product.id!),
                                  icon: Icon(
                                    Icons.remove,
                                    color: Color(0xFF2D9F75),
                                    size: 35.dg,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 12.dg,
                                    vertical: 4.dg,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(45, 159, 117, 1),

                                    borderRadius: BorderRadius.circular(8.dg),
                                  ),
                                  child: Text(
                                    "$quantity",
                                    style: TextStyle(
                                      fontSize: 22.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () => context
                                      .read<ProductCubit>()
                                      .addProductToCart(product),
                                  icon: Icon(
                                    Icons.add,
                                    color: Color.fromRGBO(45, 159, 117, 1),
                                    size: 35.dg,
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      left: BorderSide(
                                        width: 1.dg,
                                        color: Color.fromRGBO(45, 159, 117, 1),
                                      ),
                                    ),
                                  ),
                                  child: IconButton(
                                    padding: EdgeInsets.only(left: 16.dg),
                                    onPressed: () => context
                                        .read<ProductCubit>()
                                        .removeAll(product.id!),
                                    icon: Icon(
                                      Icons.delete_outline_rounded,
                                      color: Colors.redAccent.shade700,
                                      size: 35.dg,
                                    ),
                                  ),
                                ),
                              ],
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
                                  borderRadius: BorderRadius.circular(12.dg),
                                ),
                              ),
                              onPressed: product.isInStock || product.isLowStock
                                  ? () => context
                                        .read<ProductCubit>()
                                        .addProductToCart(product)
                                  : null,
                              child: Text(
                                "Add to Cart",
                                style: GoogleFonts.inter(
                                  fontSize: 16.dg,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

Widget sideEffects(
  PharmacyProducts product,
  String sideEffect,
  String sideType,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Text(
          sideEffect,
          style: GoogleFonts.inter(
            fontSize: 16.dg,
            fontWeight: FontWeight.w600,
            color: Color.fromRGBO(17, 24, 39, 1),
          ),
        ),
      ),

      SizedBox(height: 8.dg),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.start,
          children: List.generate(
            (sideType == "common")
                ? product.sideEffects!.common!.length
                : (sideType == "uncommon")
                ? product.sideEffects!.uncommon!.length
                : product.sideEffects!.rare!.length,
            (index) {
              return Container(
                margin: const EdgeInsets.only(right: 8, bottom: 8),
                padding: EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                decoration: BoxDecoration(
                  color: (sideType == "common")
                      ? Color.fromRGBO(220, 252, 231, 1)
                      : (sideType == "rare")
                      ? Color.fromRGBO(252, 248, 220, 1)
                      : Color.fromRGBO(252, 220, 220, 1),
                  borderRadius: BorderRadius.circular(100.dg),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  spacing: 6.dg,
                  children: [
                    Container(
                      width: 6.dg,
                      height: 6.dg,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: (sideType == "common")
                            ? Color.fromRGBO(45, 159, 117, 1)
                            : (sideType == "rare")
                            ? Color.fromRGBO(159, 148, 45, 1)
                            : Color.fromRGBO(159, 45, 45, 1),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        (sideType == "common")
                            ? product.sideEffects!.common![index]
                            : (sideType == "rare")
                            ? product.sideEffects!.rare![index]
                            : product.sideEffects!.uncommon![index],

                        overflow: TextOverflow.visible,
                        style: GoogleFonts.inter(
                          fontSize: 12.dg,
                          fontWeight: FontWeight.w500,
                          color: (sideType == "common")
                              ? Color.fromRGBO(45, 159, 117, 1)
                              : (sideType == "rare")
                              ? Color.fromRGBO(159, 148, 45, 1)
                              : Color.fromRGBO(159, 45, 45, 1),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    ],
  );
}
