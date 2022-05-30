import 'package:dio/dio.dart';
import 'package:e_commerce/features/cart/data/repository/cart_repo.dart';
import 'package:e_commerce/features/home/data/repository/popular_product_repo.dart';
import 'package:e_commerce/features/home/data/repository/recommended_product_repo.dart';
import 'package:e_commerce/features/cart/presentation/cart_controller.dart';

import 'package:e_commerce/features/home/presentation/popular_product_controller.dart';
import 'package:e_commerce/features/home/presentation/recommended_product_controller.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../features/home/data/repository/popular_product_repo.dart';

//CONTROLLER PROVİDERS

final controllerPopularProduct = ChangeNotifierProvider((ref) {
  return PopularProductController(
      popularProductRepo: ref.watch(popularProductRepoProvider));
});

final controllerRecommendedProduct =
    ChangeNotifierProvider<RecommendedProductController>((ref) {
  return RecommendedProductController(
      recommendedProductRepo: ref.watch(recommendedProductProvider));
});

final controllerCart = ChangeNotifierProvider<CartController>((ref) {
  return CartController(cartRepo: ref.watch(cartRepoProvider));
});

//REPO PROVİDERS

final recommendedProductProvider = Provider<RecommendedProductRepo>((ref) {
  return RecommendedProductRepo(dio: Dio());
});

final popularProductRepoProvider = Provider<PopularProductRepo>((ref) {
  return PopularProductRepo(dio: Dio());
});

final cartRepoProvider = Provider<CartRepo>((ref) {
  return CartRepo();
});
