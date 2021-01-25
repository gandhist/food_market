import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_market/cubit/cubit.dart';
import 'package:food_market/models/models.dart';
import 'package:food_market/ui/pages/pages.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // harus ada di pubspec yaml bloc
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => UserCubit()),
        BlocProvider(create: (_) => FoodCubit()),
        BlocProvider(create: (_) => TransactionCubit()),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: SignInPage(),
        // home: PaymentPage(
        //   transaction: Transaction(
        //       food: mockFoods[2],
        //       user: mockUser,
        //       quantity: 2,
        //       total: (mockFoods[2].price * 2 * 1.1).toInt() + 50000),
        // ),
      ),
    );
  }
}
