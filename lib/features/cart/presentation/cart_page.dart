import 'package:another_flushbar/flushbar.dart';
import 'package:e_commerce/base/no_data_page.dart';
import 'package:e_commerce/base/show_flushbar.dart';
import 'package:e_commerce/features/home/presentation/main_food_page.dart';
import 'package:e_commerce/features/home/presentation/popular_food_detail.dart';
import 'package:e_commerce/features/home/presentation/reccomended_food_detail.dart';
import 'package:e_commerce/utils/all_providers.dart';
import 'package:e_commerce/utils/app_constants.dart';
import 'package:e_commerce/utils/colors.dart';
import 'package:e_commerce/utils/dimensions.dart';
import 'package:e_commerce/widgets/app_icon.dart';
import 'package:e_commerce/widgets/big_text.dart';
import 'package:e_commerce/widgets/small_text.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../domain/models/cart_model.dart';

class CartPage extends StatelessWidget {
  static const String routeName = "/cart-page";
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Consumer(
        builder: (context, ref, child) {
          var controlProduct = ref.watch(controllerPopularProduct);
          return Container(
            height: 120,
            padding: const EdgeInsets.only(top: 30, right: 20, left: 20),
            decoration: const BoxDecoration(
              color: AppColors.buttonBackgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
            ),
            child: Consumer(
                builder: (context, ref, child) => ref
                        .watch(controllerCart)
                        .getItems
                        .isNotEmpty
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const SizedBox(width: 10),
                                BigText(
                                    text: ref
                                        .watch(controllerCart)
                                        .totalAmount
                                        .toString()),
                                const SizedBox(width: 10),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              ref.watch(controllerCart).addToHistory();
                            },
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: AppColors.mainColor),
                              child: BigText(
                                size: 18,
                                text: "Check out",
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      )
                    : const SizedBox()),
          );
        },
      ),
      body: Stack(
        children: [
          Positioned(
            left: Dimensions.width20,
            right: Dimensions.width20,
            top: Dimensions.height20 * 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const AppIcon(
                  icon: Icons.arrow_back_ios,
                  iconColor: Colors.white,
                  backgroundColor: AppColors.mainColor,
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () => context.pushNamed(MainFoodPage.routeName),
                  child: const AppIcon(
                    icon: Icons.home_outlined,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                  ),
                ),
                const SizedBox(width: 20),
                const AppIcon(
                  icon: Icons.shopping_cart,
                  iconColor: Colors.white,
                  backgroundColor: AppColors.mainColor,
                ),
              ],
            ),
          ),
          Consumer(
              builder: (context, ref, child) => ref
                      .watch(controllerCart)
                      .getItems
                      .isNotEmpty
                  ? Positioned(
                      top: Dimensions.height20 * 5,
                      right: Dimensions.width20,
                      left: Dimensions.width20,
                      bottom: 0,
                      child: Container(
                        margin: EdgeInsets.only(top: Dimensions.height15),
                        child: Consumer(builder: (context, ref, child) {
                          List<CartModel> cartList =
                              ref.watch(controllerCart).getItems;
                          return ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: cartList.length,
                            itemBuilder: (_, index) {
                              return SizedBox(
                                height: Dimensions.height20 * 5,
                                width: double.infinity,
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        var popularIndex = ref
                                            .watch(controllerPopularProduct)
                                            .popularProductList
                                            .indexOf(cartList[index].product);
                                        if (popularIndex >= 0) {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DetailPage(
                                                        index: popularIndex)),
                                          );
                                        } else {
                                          var recommendedIndex = ref
                                              .watch(
                                                  controllerRecommendedProduct)
                                              .recommendedProductList
                                              .indexOf(
                                                  cartList[index].product!);
                                          if (recommendedIndex < 0) {
                                            showCustomSnackBar(
                                                context: context,
                                                title: "History product",
                                                message:
                                                    "Product review is not available for history products");
                                          } else {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        RecommendedFoodDetail(
                                                            index:
                                                                recommendedIndex)));
                                          }
                                        }
                                      },
                                      child: Container(
                                        width: Dimensions.height20 * 5,
                                        height: Dimensions.height20 * 5,
                                        margin: EdgeInsets.only(
                                            bottom: Dimensions.height10),
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                  AppConstants.BASE_URL +
                                                      AppConstants.UPLOAD_URL +
                                                      ref
                                                          .watch(controllerCart)
                                                          .getItems[index]
                                                          .img!),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: Colors.white),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: SizedBox(
                                        height: Dimensions.height20 * 5,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            BigText(
                                              text: ref
                                                  .watch(controllerCart)
                                                  .getItems[index]
                                                  .name!,
                                              color: Colors.black54,
                                            ),
                                            SmallText(text: "Spicy"),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                BigText(
                                                  text: ref
                                                      .watch(controllerCart)
                                                      .getItems[index]
                                                      .price
                                                      .toString(),
                                                  color: Colors.redAccent,
                                                ),
                                                Container(
                                                  padding: EdgeInsets.all(
                                                      Dimensions.height10),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      color: Colors.white),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      GestureDetector(
                                                          onTap: () {
                                                            ref
                                                                .watch(
                                                                    controllerCart)
                                                                .addItem(
                                                                    cartList[
                                                                            index]
                                                                        .product!,
                                                                    -1);
                                                            // controlProduct.setQuantity(false, context);
                                                          },
                                                          child: const Icon(
                                                              Icons.remove,
                                                              color: AppColors
                                                                  .signColor)),
                                                      const SizedBox(width: 10),
                                                      BigText(
                                                          text: cartList[index]
                                                              .quantity
                                                              .toString()) //controlProduct.inCartItems.toString()),
                                                      ,
                                                      const SizedBox(width: 10),
                                                      GestureDetector(
                                                          onTap: () {
                                                            ref
                                                                .watch(
                                                                    controllerCart)
                                                                .addItem(
                                                                    cartList[
                                                                            index]
                                                                        .product!,
                                                                    1);
                                                            // controlProduct.setQuantity(true, context);
                                                          },
                                                          child: const Icon(
                                                              Icons.add,
                                                              color: AppColors
                                                                  .signColor)),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        }),
                      ),
                    )
                  : const NoDataPage(text: "Your cart is empty!")),
        ],
      ),
    );
  }
}
