// import 'dart:nativewrappers/_internal/vm/lib/ffi_native_type_patch.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduated_project/cart_checkout/controller/cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(Cartinitial());

  List<Map<String, dynamic>> products = [
    {
      "numbers": 1,
      "price": 4,
      "baseprice": 4,
      "image": "assets/Background (1).png",
      "title": "Paracetamol 500mg      ",
      "subtitle": "10 Tablets / Strip",
    },
    {
      "numbers": 1,
      "price": 5,
      "baseprice": 5,
      "image": "assets/Background (2).png",
      "title": "Vitamin C Effervescent ",
      "subtitle": "Tube of 20 Tabs",
    },
    {
      "numbers": 1,
      "price": 6,
      "baseprice": 6,
      "image": "assets/Vitamin C 1000mg (1).png",
      "title": "Disposable Face Masks",
      "subtitle": "Box of 50",
    },
  ];

  int subtotal = 15;
  int totalprice = 50;
  int delivery = 35;
  int totalpriceforcart = 0;

  void add(int index) {
    // delivery = 5;
    // int
    totalpriceforcart = products[index]["baseprice"];
    products[index]["numbers"] += 1;
    products[index]["price"] =
        products[index]["numbers"] * products[index]["baseprice"];
    // products[index]["baseprice"] * (products[index]["numbers"]-1);
    total();
    emit(Cartadded());
  }

  void delete(int index) {
    // delivery = 5;
    // int
    totalpriceforcart = products[index]["baseprice"];
    if (products[index]["numbers"] > 1) {
      products[index]["numbers"] -= 1;
      products[index]["price"] =
          products[index]["numbers"] * products[index]["baseprice"];
      // products[index]["baseprice"] * products[index]["numbers"];

      total();
      emit(Cartdeleted());
    }
  }

  void total() {
    subtotal =
        products[0]["price"] + products[1]["price"] + products[2]["price"];
    totalprice = subtotal + delivery;

    emit(Carttotal());
  }
}
