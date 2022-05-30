import 'package:flutter/material.dart';

import '../data/repository/recommended_product_repo.dart';
import '../domain/models/products_model.dart';

class RecommendedProductController extends ChangeNotifier {
  final RecommendedProductRepo recommendedProductRepo;
  RecommendedProductController({required this.recommendedProductRepo}) {
    getRecommendedProductList();
  }
  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;
  List<ProductModel> _recommendedProductList = [];
  List<ProductModel> get recommendedProductList => _recommendedProductList;

  getRecommendedProductList() async {
    final response = await recommendedProductRepo.getRecommendedProductData();

    _recommendedProductList = [];
    _recommendedProductList.addAll(Product.fromJson(response).products);
    _isLoaded = true;
    notifyListeners();
  }
}
