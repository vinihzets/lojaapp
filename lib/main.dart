import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lojaapp/core/inject/injector.dart';
import 'package:lojaapp/core/utils/consts.dart';
import 'package:lojaapp/features/cart/presentation/ui/cart_screen.dart';
import 'package:lojaapp/features/categories/presentation/ui/categories_screen.dart';
import 'package:lojaapp/features/orders/presentation/ui/order_screen.dart';
import 'package:lojaapp/features/products/presentation/ui/products_details_screen.dart';
import 'package:lojaapp/features/products/presentation/ui/products_screen.dart';
import 'package:lojaapp/features/home/presentation/ui/home_screen.dart';
import 'package:lojaapp/features/initialize/presentation/ui/initialize_screen.dart';
import 'package:lojaapp/features/login/presentation/ui/login_screen.dart';
import 'package:lojaapp/features/register/presentation/ui/register_screen.dart';

final gConsts = Consts();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  Injector.initialize();

  runApp(MaterialApp(
    routes: {
      gConsts.initializeScreen: (_) => const InitializeScreen(),
      gConsts.loginScreen: (_) => const LoginScreen(),
      gConsts.registerScreen: (_) => const RegisterScreen(),
      gConsts.homeScreen: (_) => const HomeScreen(),
      gConsts.categoriesScreen: (_) => const CategoriesScreen(),
      gConsts.productsScreen: (_) => const ProductsScreen(),
      gConsts.productsDetailsScreen: (_) => const ProductsDetailsScreen(),
      gConsts.cartScreen: (_) => const CartScreen(),
      gConsts.orderScreen: (_) => const OrderScreen(),
    },
    initialRoute: gConsts.initializeScreen,
  ));
}
