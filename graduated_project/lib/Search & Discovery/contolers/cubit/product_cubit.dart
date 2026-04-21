import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:graduated_project/Search%20&%20Discovery/models/product_model.dart';
part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  List<String> catigoriesImages = [
    'assets/images/Antibiotics.png',
    'assets/images/Cardiac.png',
    'assets/images/Diabetes.png',
    'assets/images/Pain_Relief.png',
    'assets/images/Baby_Care.png',
    'assets/images/Vitamins.png',
    'assets/images/Respiratory.png',
    'assets/images/Skin_Care.png',
    'assets/images/9.jpg',
    'assets/images/10.jpg',
    'assets/images/11.jpg',
    'assets/images/12.jpg',
    'assets/images/13.jpg',
    'assets/images/14.jpg',
    'assets/images/15.jpg',
    'assets/images/16.jpg',
    'assets/images/17.jpg',
    'assets/images/18.jpg',
    'assets/images/19.jpg',
    'assets/images/20.jpg',
  ];
  ProductCubit() : super(ProductInitial());
  static const String cartCollectionName = 'Cart_Products';
  static const String favCollectionName = 'Fav_Products';
  final CollectionReference cartProducts = FirebaseFirestore.instance
      .collection(cartCollectionName);
  final CollectionReference favProducts = FirebaseFirestore.instance.collection(
    favCollectionName,
  );
  double totalPrice = 0.0;
  Future<void> addFavProduct(PharmacyProducts product) async {
    try {
      if (product.isFavorite == null) {
        product.isFavorite = true;
      } else {
        product.isFavorite = !product.isFavorite!;
      }
      if (product.isFavorite!) {
        await favProducts.add(product.toJson());
      } else {
        await favProducts
            .where("id", isEqualTo: product.id)
            .limit(1)
            .get()
            .then((snapshot) => snapshot.docs.first.reference.delete());
      }
      emit(ProductSuccess());
    } catch (e) {
      log("Add Error: $e");
    }
  }

  void calculateTotalPrice(List<PharmacyProducts> products) {
    totalPrice = 0.0;
    for (var product in products) {
      totalPrice += product.priceUsd!;
    }
    emit(ProductSuccess());
  }

  Future<void> addProductToCart(PharmacyProducts product) async {
    try {
      await cartProducts.add(product.toJson());
    } catch (e) {
      log("Add Error: $e");
    }
  }

  Future<void> removeProductFromCart(int productId) async {
    try {
      final snapshot = await cartProducts
          .where("id", isEqualTo: productId)
          .limit(1)
          .get();

      if (snapshot.docs.isNotEmpty) {
        await snapshot.docs.first.reference.delete();
      }
    } catch (e) {
      log("Remove Error: $e");
    }
  }

  Future<void> removeAll(int productId) async {
    try {
      final snapshot = await cartProducts
          .where("id", isEqualTo: productId)
          .get();

      if (snapshot.docs.isNotEmpty) {
        for (var doc in snapshot.docs) {
          await doc.reference.delete();
        }
      }
    } catch (e) {
      log("Remove Error: $e");
    }
  }

  String sortOption = "A-Z";
  List<PharmacyProducts> products = [];
  List<PharmacyProducts> foundProducts = [];
  List<PharmacyProducts> productsInCart = [];

  List<PharmacyProducts> productsByCategory = [];

  void getProductsByCategory(String category) {
    productsByCategory = products
        .where((product) => product.category == category)
        .toList();
    emit(ProductSuccess());
  }

  void runFilter(String enteredKeyword) {
    List<PharmacyProducts> results = [];
    if (enteredKeyword.isEmpty) {
      results = products;
    } else {
      results = products
          .where(
            (user) =>
                user.name!.toLowerCase().contains(enteredKeyword.toLowerCase()),
          )
          .toList();
    }
    foundProducts = results;
    emit(ProductSuccess());
  }

  void sortByCategory(String category) {
    foundProducts = products
        .where((product) => product.category == category)
        .toList();
    emit(ProductSuccess());
  }

  void sortProducts(String sortBy) {
    foundProducts = products;
    if (sortBy == "A-Z") {
      foundProducts.sort((a, b) => a.name!.compareTo(b.name!));
    } else if (sortBy == "Z-A") {
      foundProducts.sort((a, b) => b.name!.compareTo(a.name!));
    } else if (sortBy == "LtoH") {
      foundProducts.sort((a, b) => a.priceUsd!.compareTo(b.priceUsd!));
    } else if (sortBy == "HtoL") {
      foundProducts.sort((a, b) => b.priceUsd!.compareTo(a.priceUsd!));
    }
    emit(ProductSuccess());
  }

  void getSortOption(String option) {
    if (option == "A-Z") {
      sortOption = "A-Z";
    } else if (option == "Z-A") {
      sortOption = "Z-A";
    } else if (option == "LtoH") {
      sortOption = "Low to High";
    } else if (option == "HtoL") {
      sortOption = "High to Low";
    }
    emit(ProductSuccess());
  }

  void fetchProducts() async {
    emit(ProductLoading());

    final Dio dio = Dio();
    try {
      final response = await dio.get(
        "https://www.mockachino.com/e1c9e45a-271f-4e/users",
      );
      products = Autogenerated.fromJson(response.data).pharmacyProducts!;
      foundProducts = products;
      emit(ProductSuccess());
    } catch (e) {
      log("Error: $e");
      emit(ProductError());
    }
  }

  Future<void> getProductsInCart([int? id]) async {
    emit(ProductLoading());
    try {
      final snapshot = await cartProducts.get();
      productsInCart = snapshot.docs
          .map(
            (doc) =>
                PharmacyProducts.fromJson(doc.data() as Map<String, dynamic>),
          )
          .toList();
      emit(ProductSuccess());
    } catch (e) {
      emit(ProductError());
    }
  }
}

num getPriceBeforeDiscount(num price) {
  num discount = price * 0.3 + price;
  return discount;
}
