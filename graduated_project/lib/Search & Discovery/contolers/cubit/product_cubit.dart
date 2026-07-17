import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:graduated_project/Search%20&%20Discovery/models/product_model.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final List<String> catigoriesImages = [
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
  static const String ordershistoryCollectionName = 'Orders_History';

  CollectionReference _getUserCollection(String subCollectionName) {
    final String? uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) {
      throw Exception("User is not logged in!");
    }
    return FirebaseFirestore.instance
        .collection('Users')
        .doc(uid)
        .collection(subCollectionName);
  }

  double totalPrice = 0.0;
  int currentIndex = 0;

  String sortOption = "A-Z";
  List<PharmacyProducts> products = [];
  List<PharmacyProducts> foundProducts = [];
  List<PharmacyProducts> productsInCart = [];
  List<PharmacyProducts> historyOrders = [];
  List<PharmacyProducts> productsByCategory = [];

  Future<void> addFavProduct(PharmacyProducts product) async {
    try {
      product.isFavorite = !(product.isFavorite ?? false);
      final favProducts = _getUserCollection(favCollectionName);

      if (product.isFavorite ?? false) {
        await favProducts.doc(product.id.toString()).set(product.toJson());
      } else {
        await favProducts.doc(product.id.toString()).delete();
      }
      emit(ProductSuccess());
    } catch (e) {
      log("Add/Remove Fav Error: $e");
    }
  }

  void calculateTotalPrice(List<PharmacyProducts> productsList) {
    double calculated = 0.0;
    for (var product in productsList) {
      calculated += (product.priceUsd ?? 0) * (product.quantity ?? 1);
    }
    if (totalPrice != calculated) {
      totalPrice = calculated;
      emit(ProductSuccess());
    }
  }

  Future<void> addProductToCart(PharmacyProducts product) async {
    try {
      final cartProducts = _getUserCollection(cartCollectionName);
      final docRef = cartProducts.doc(product.id.toString());
      final doc = await docRef.get();

      if (doc.exists) {
        await docRef.update({'quantity': FieldValue.increment(1)});
      } else {
        await docRef.set({...product.toJson(), 'quantity': 1});
      }
    } catch (e) {
      log("Add Cart Error: $e");
    }
  }

  Future<void> decreaseQuantity(int productId) async {
    try {
      final cartProducts = _getUserCollection(cartCollectionName);
      final docRef = cartProducts.doc(productId.toString());
      final doc = await docRef.get();
      if (!doc.exists) return;

      final data = doc.data() as Map<String, dynamic>?;
      final qty = data?['quantity'] ?? 1;
      if (qty > 1) {
        await docRef.update({'quantity': FieldValue.increment(-1)});
      } else {
        await docRef.delete();
      }
    } catch (e) {
      log("Decrease Error: $e");
    }
  }

  Future<void> removeProductFromCart(int productId) async {
    try {
      final cartProducts = _getUserCollection(cartCollectionName);
      await cartProducts.doc(productId.toString()).delete();
    } catch (e) {
      log("Remove Error: $e");
    }
  }

  Future<void> addOrderToHistory() async {
    try {
      final cartProducts = _getUserCollection(cartCollectionName);
      final ordersHistory = _getUserCollection(ordershistoryCollectionName);

      final snapshot = await cartProducts.get();
      if (snapshot.docs.isEmpty) return;
      final batch = FirebaseFirestore.instance.batch();

      for (var doc in snapshot.docs) {
        final productData = doc.data() as Map<String, dynamic>;
        final newOrderRef = ordersHistory.doc();
        batch.set(newOrderRef, {
          ...productData,
          "createdAt": FieldValue.serverTimestamp(),
        });
      }
      await batch.commit();
    } catch (e) {
      log("Add History Error: $e");
    }
  }

  Future<void> removeOrderFromHistory(int productId) async {
    try {
      final ordersHistory = _getUserCollection(ordershistoryCollectionName);
      await ordersHistory.doc(productId.toString()).delete();
    } catch (e) {
      log("Remove History Error: $e");
    }
  }

  Future<void> getHistoryOrders() async {
    emit(ProductLoading());
    try {
      final ordersHistory = _getUserCollection(ordershistoryCollectionName);
      final snapshot = await ordersHistory.get();
      historyOrders = snapshot.docs
          .map((doc) => PharmacyProducts.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
      emit(ProductSuccess());
    } catch (e) {
      emit(ProductError());
    }
  }

  Future<void> removeAll() async {
    try {
      final cartProducts = _getUserCollection(cartCollectionName);
      final snapshot = await cartProducts.get();
      if (snapshot.docs.isEmpty) return;

      final batch = FirebaseFirestore.instance.batch();
      for (var doc in snapshot.docs) {
        batch.delete(doc.reference);
      }
      await batch.commit();
    } catch (e) {
      log("Remove All Error: $e");
    }
  }

  Future<void> getProductsInCart([int? id]) async {
    emit(ProductLoading());
    try {
      final cartProducts = _getUserCollection(cartCollectionName);
      final snapshot = await cartProducts.get();
      productsInCart = snapshot.docs
          .map((doc) => PharmacyProducts.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
      emit(ProductSuccess());
    } catch (e) {
      emit(ProductError());
    }
  }

  void getProductsByCategory(String category) {
    emit(ProductLoading());
    productsByCategory = products.where((product) => product.category == category).toList();
    emit(ProductSuccess());
  }

  void runFilter(String enteredKeyword) {
    if (enteredKeyword.isEmpty) {
      foundProducts = products;
    } else {
      foundProducts = products
          .where((user) => (user.name ?? '').toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    emit(ProductSuccess());
  }

  void sortByCategory(String category) {
    foundProducts = products.where((product) => product.category == category).toList();
    emit(ProductSuccess());
  }

  void sortProducts(String sortBy) {
    foundProducts = List.from(products);
    if (sortBy == "A-Z") {
      foundProducts.sort((a, b) => (a.name ?? '').compareTo(b.name ?? ''));
    } else if (sortBy == "Z-A") {
      foundProducts.sort((a, b) => (b.name ?? '').compareTo(a.name ?? ''));
    } else if (sortBy == "LtoH") {
      foundProducts.sort((a, b) => (a.priceUsd ?? 0).compareTo(b.priceUsd ?? 0));
    } else if (sortBy == "HtoL") {
      foundProducts.sort((a, b) => (b.priceUsd ?? 0).compareTo(a.priceUsd ?? 0));
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

  Future<void> fetchProducts() async {
    emit(ProductLoading());
    final Dio dio = Dio();
    try {
      final response = await dio.get("https://www.mockachino.com/e1c9e45a-271f-4e/users");
      products = Autogenerated.fromJson(response.data).pharmacyProducts ?? [];
      foundProducts = products;
      emit(ProductSuccess());
    } catch (e) {
      log("Error: $e");
      emit(ProductError());
    }
  }

  void changeIndex(int index) {
    currentIndex = index;
    emit(ChangeIndexState());
  }
}

num getPriceBeforeDiscount(num price) {
  return price * 0.3 + price;
}