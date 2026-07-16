import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduated_project/Search%20&%20Discovery/contolers/cubit/product_cubit.dart';
import 'package:graduated_project/cart_checkout/controller/cart_cubit.dart';
import 'package:graduated_project/cart_checkout/controller/cart_state.dart';
import 'package:graduated_project/cart_checkout/view/widgets/checkout.dart';
import 'package:graduated_project/cart_checkout/view/widgets/increasequantity.dart';
// import 'package:graduated_project/cart_checkout/controller/cart_cubit.dart';
import 'package:graduated_project/Search & Discovery/contolers/cubit/product_cubit.dart';

class Cart extends StatelessWidget {
  Cart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        // child: SingleChildScrollView(
        child: Directionality(
          textDirection: TextDirection.ltr,

          child: Column(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: Offset(0, 4), // shadow من تحت بس
                    ),
                  ],
                ),

                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "My Cart",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Color(0xffEAF5F1),
                        ),
                        width: 80,
                        height: 30,
                        // color: Color(0xffEAF5F1),
                        child: Center(
                          child: Text(
                            "3 items",
                            style: TextStyle(color: Color(0xff2D9F75)),
                          ),
                        ),
                      ),
                      // ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Divider(thickness: 0.5),
              Expanded(
                child: BlocBuilder<CartCubit, CartState>(
                  builder: (context, state) {
                    final cartCubit = context.watch<CartCubit>();
                    final items = cartCubit.products; // مصدر واحد بس
                    // to=cartCubit.t
                    return ListView.separated(
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 10),
                      shrinkWrap: true,
                      itemCount: items.length, // ← نفس المصدر
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final product =
                            items[index]; // بدل products[index] الثابت

                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Container(
                            width: double.infinity,
                            height: 115,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 8,
                                  offset: Offset(0, 4), // shadow من تحت بس
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Row(
                                // spacing: 6,
                                children: [
                                  Image.asset(product["image"]),
                                  SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    spacing: 0,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "${product["title"]}",
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(width: 330),
                                          IconButton(
                                            onPressed: () {},
                                            icon: Icon(Icons.delete_rounded),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        "${product["subtitle"]}",
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            " ${product["price"]} L.E",
                                            style: TextStyle(
                                              fontSize: 19,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xff2D9F75),
                                            ),
                                          ),
                                          SizedBox(width: 410),
                                          Container(
                                            width: 100,
                                            height: 31,
                                            decoration: BoxDecoration(
                                              color: Color.fromARGB(
                                                255,
                                                255,
                                                255,
                                                255,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.3),
                                                  blurRadius: 10,
                                                  offset: const Offset(0, 2),
                                                  spreadRadius: 0,
                                                ),
                                              ],
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    vertical: 0,
                                                    horizontal: 0,
                                                  ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                    width: 35,
                                                    height: 35,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            2,
                                                          ),
                                                      color: Colors.grey[200],
                                                    ),

                                                    child: InkWell(
                                                      onTap: () {
                                                        cartCubit.delete(index);
                                                      },
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets.all(
                                                              0.0,
                                                            ),
                                                        child: Icon(
                                                          Icons.remove,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 0,
                                                    child: Divider(
                                                      thickness: 0.8,
                                                    ),
                                                  ),
                                                  Center(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.symmetric(
                                                            vertical: 2,
                                                          ),
                                                      child: Text(
                                                        '${product["numbers"]}',
                                                        style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 0.8),
                                                  Container(
                                                    width: 35,
                                                    height: 35,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            2,
                                                          ),
                                                      color: Colors.grey[200],
                                                    ),
                                                    child: InkWell(
                                                      onTap: () {
                                                        cartCubit.add(index);
                                                      },
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets.all(
                                                              6.0,
                                                            ),
                                                        child: Icon(
                                                          Icons.add,
                                                          color: Color(
                                                            0xff2D9F75,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          // Increasequantity(),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),

              SizedBox(height: 20),
              BlocBuilder<CartCubit, CartState>(
                builder: (context, State) {
                  final CartCubit2 = context.watch<CartCubit>();

                  return Container(
                    width: double.infinity,
                    height: 250,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: Offset(0, -4),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(26.0),
                      child: Column(
                        spacing: 10,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Subtotal"),
                              Text("${CartCubit2.subtotal} L.E"),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Delivery Fee"),
                              Text("${CartCubit2.delivery} L.E"),
                            ],
                          ),
                          BlocBuilder<ProductCubit, ProductState>(
                            builder: (context, State) {
                              final ProductCubit1 = context
                                  .watch<ProductCubit>();
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Total Price :${ProductCubit1.productsInCart.length}",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "${CartCubit2.totalprice} L.E",
                                    style: TextStyle(
                                      fontSize: 21,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff2D9F75),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                          SizedBox(height: 10),
                          Center(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => Checkout(),
                                  ),
                                );
                              },
                              child: Container(
                                width: double.infinity,
                                height: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: Color(0xff2D9F75),
                                ),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Proceed to Checkout",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 21,
                                          fontWeight: FontWeight.bold,
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
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
          // ),
        ),
        // ),
      ),
    );
  }
}
