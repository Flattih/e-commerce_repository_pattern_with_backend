import 'package:another_flushbar/flushbar.dart';
import 'package:e_commerce/base/show_flushbar.dart';
import 'package:e_commerce/features/home/data/repository/popular_product_repo.dart';
import 'package:e_commerce/features/cart/domain/models/cart_model.dart';
import 'package:e_commerce/features/cart/presentation/cart_controller.dart';

import 'package:flutter/material.dart';

import '../../../utils/colors.dart';
import '../domain/models/products_model.dart';

class PopularProductController extends ChangeNotifier {
  final PopularProductRepo popularProductRepo;
  PopularProductController(
      {BuildContext? context, required this.popularProductRepo}) {
    getPopularProductList();
  }
  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;
  List _popularProductList = [];
  List get popularProductList => _popularProductList;
  late CartController _cart;

  int _quantity = 0;
  int get quantity => _quantity;
  int _inCartItems = 0;
  int get inCartItems => _inCartItems + _quantity;

  getPopularProductList() async {
    final response = await popularProductRepo.getPopularProductData();

    _popularProductList = [];
    _popularProductList.addAll(Product.fromJson(response).products);
    _isLoaded = true;
    notifyListeners();
  }

  void setQuantity(bool isIncrement, BuildContext context) {
    if (isIncrement) {
      _quantity = checkQuantity(_quantity + 1, context);
    } else {
      _quantity = checkQuantity(_quantity - 1, context);
    }
    notifyListeners();
  }

  int checkQuantity(int quantity, BuildContext context) {
    if ((quantity + _inCartItems) > 15) {
      showCustomSnackBar(
          context: context, message: "You can't add more", title: "Item Count");

      return 15;
    } else if ((quantity + _inCartItems) < 0) {
      showCustomSnackBar(
          context: context,
          title: "Item Count",
          message: "You can't reduce more");

      return 0;
    } else {
      return quantity;
    }
  }

  void initProduct(CartController cart, ProductModel product) {
    _quantity = 0;
    _inCartItems = 0;
    _cart = cart;
    var exist = false;
    exist = _cart.existInCart(product);

    if (exist) {
      _inCartItems = _cart.getQuantity(product);
    }
  }

  void addItem(ProductModel product) {
    _cart.addItem(product, _quantity);
    _quantity = 0;
    _inCartItems = _cart.getQuantity(product);
    notifyListeners();
  }

  int get totalItems {
    return _cart.totalItems;
  }

  List<CartModel> get getItems {
    return _cart.getItems;
  }
}
