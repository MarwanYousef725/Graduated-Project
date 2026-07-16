// import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduated_project/Search%20&%20Discovery/contolers/cubit/product_cubit.dart';
// import 'package:graduated_project/Search%20&%20Discovery/contolers/cubit/product_cubit.dart';
// import 'package:graduated_project/Search%20&%20Discovery/view/home.dart';
// import 'package:graduated_project/cart&checkout/controller/cart_cubit.dart';
// import 'package:graduated_project/cart&checkout/view/cart.dart';
import 'package:graduated_project/cart_checkout/controller/cart_cubit.dart';
import 'package:graduated_project/cart_checkout/view/cart.dart';
import 'package:graduated_project/track&history/view/tracking.dart';
// import 'package:graduated_project/cart_checkout/view/widgets/cart3.dart';
// import 'package:graduated_project/cart_checkout/view/widgets/checkout.dart';
// import 'package:graduated_project/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    MultiBlocProvider(
      providers: [
        // BlocProvider<CartCubit>(create: (_) => CartCubit()),
        // BlocProvider<CartBlocController>(create: (_) => CartBlocController()),
        BlocProvider<ProductCubit>(create: (_) => ProductCubit()),
        // BlocProvider<FavProductsCubit>(create: (context) => FavProductsCubit()),
        // BlocProvider<logocubit>(create: (context) => logocubit()..startlogo()),
        // BlocProvider<LoginCubit>(create: (context) => LoginCubit()),
        // BlocProvider<RegisterCubit>(create: (context) => RegisterCubit()),
        // BlocProvider<LocationCubit>(create: (_) => LocationCubit()),
        BlocProvider<CartCubit>(create: (_) => CartCubit()),
        BlocProvider<ProductCubit>(create: (_) => ProductCubit()),
        // BlocProvider<logincubit>(create: (context) => Logincubit()),
      ],

      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 890),
      minTextAdapt: true,
      splitScreenMode: true,
      child: Builder(builder: (context) => MaterialApp(home: Cart())),
    );
  }
}
