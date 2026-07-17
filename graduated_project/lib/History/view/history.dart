import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduated_project/Search%20&%20Discovery/contolers/cubit/product_cubit.dart';
import 'package:graduated_project/Search%20&%20Discovery/models/product_model.dart';
import 'package:graduated_project/Search%20&%20Discovery/view/home.dart';
import 'package:graduated_project/Search%20&%20Discovery/view/product_details.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  void initState() {
    super.initState();
    context.read<ProductCubit>().getHistoryOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(246, 248, 247, 1),
      body: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          final productCubit = context.read<ProductCubit>();
          if (state is ProductLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is ProductError) {
            return const Center(child: Text("Error"));
          }
          if (productCubit.historyOrders.isEmpty) {
            return const Center(child: Text("No History"));
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 30.dg),
                ListView.separated(
                  separatorBuilder: (context, index) => SizedBox(height: 20),
                  itemCount: productCubit.historyOrders.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    PharmacyProducts item = productCubit.historyOrders[index];
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.dg),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.05),
                            blurRadius: 2,
                            offset: const Offset(0, 1),
                          ),
                        ],
                        border: Border.all(
                          width: 1.dg,
                          color: const Color.fromRGBO(243, 244, 246, 1),
                        ),
                      ),
                      child: Column(
                        spacing: 12.dg,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${item.createdAt?.day}/${item.createdAt?.month}/${item.createdAt?.year} • ${item.createdAt?.hour}:${item.createdAt?.minute} ${item.createdAt?.hour != null && item.createdAt!.hour > 12 ? "PM" : "AM"}",
                                    style: GoogleFonts.inter(
                                      fontSize: 14.dg,
                                      color: Color.fromRGBO(107, 114, 128, 1),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(220, 252, 231, 1),
                                  borderRadius: BorderRadius.circular(150.dg),
                                ),
                                child: Text(
                                  "DELIVERED",
                                  style: GoogleFonts.inter(
                                    color: Color.fromRGBO(21, 128, 61, 1),
                                    fontWeight: FontWeight.w700,
                                    fontSize: 10.dg,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Divider(
                            thickness: 1.dg,
                            color: Color.fromRGBO(249, 250, 251, 1),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            spacing: 16.dg,
                            children: [
                              Container(
                                clipBehavior: Clip.antiAlias,
                                width: 48.dg,
                                height: 48.dg,
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(8.dg),
                                ),
                                child: CachedNetworkImage(
                                  imageUrl: item.images![0],
                                  fit: BoxFit.cover,
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: 4,
                                  children: [
                                    Text(
                                      "${item.name}",
                                      style: GoogleFonts.inter(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14.dg,
                                        color: Color.fromRGBO(31, 41, 55, 1),
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      "${item.description}",
                                      style: GoogleFonts.inter(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12.dg,
                                        color: Color.fromRGBO(107, 114, 128, 1),
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  "\$${item.priceUsd}",
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14.dg,
                                    color: Color.fromRGBO(17, 24, 39, 1),
                                  ),
                                  maxLines: 1,
                                  textAlign: TextAlign.end,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          Divider(
                            thickness: 1.dg,
                            color: Color.fromRGBO(249, 250, 251, 1),
                          ),
                          Center(
                            child: Row(
                              spacing: 12.dg,
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ProductDetails(product: item),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      height: 45.dg,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                          color: Color(0xff2D9F75),
                                          width: 1.5,
                                        ),
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "view details",
                                          style: TextStyle(
                                            color: Color(0xff2D9F75),
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      productCubit.addProductToCart(item);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Home(index: 1),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      height: 45.dg,
                                      decoration: BoxDecoration(
                                        color: Color(0xff2D9F75),
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Reorder",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                SizedBox(height: 30.dg),
              ],
            ),
          );
        },
      ),
    );
  }
}
