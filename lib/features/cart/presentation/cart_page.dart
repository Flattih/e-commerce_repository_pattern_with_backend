import 'package:e_commerce/features/home/presentation/main_food_page.dart';
import 'package:e_commerce/utils/all_providers.dart';
import 'package:e_commerce/utils/app_constants.dart';
import 'package:e_commerce/utils/colors.dart';
import 'package:e_commerce/widgets/app_icon.dart';
import 'package:e_commerce/widgets/big_text.dart';
import 'package:e_commerce/widgets/small_text.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            left: 20,
            right: 20,
            top: 60,
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
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MainFoodPage())),
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
          Positioned(
            top: 100,
            right: 20,
            left: 20,
            bottom: 0,
            child: Container(
              margin: const EdgeInsets.only(top: 15),
              child: Consumer(builder: (context, ref, child) {
                return ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: ref.watch(controllerCart).getItems.length,
                  itemBuilder: (_, index) {
                    return SizedBox(
                      height: 100,
                      width: double.infinity,
                      child: Row(
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            margin: const EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(AppConstants.BASE_URL +
                                      AppConstants.UPLOAD_URL +
                                      ref
                                          .watch(controllerCart)
                                          .getItems[index]
                                          .img!),
                                ),
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: SizedBox(
                              height: 100,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                        MainAxisAlignment.spaceBetween,
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
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: Colors.white),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            GestureDetector(
                                                onTap: () {
                                                  // controlProduct.setQuantity(false, context);
                                                },
                                                child: const Icon(Icons.remove,
                                                    color:
                                                        AppColors.signColor)),
                                            const SizedBox(width: 10),
                                            BigText(
                                                text:
                                                    "0") //controlProduct.inCartItems.toString()),
                                            ,
                                            const SizedBox(width: 10),
                                            GestureDetector(
                                                onTap: () {
                                                  // controlProduct.setQuantity(true, context);
                                                },
                                                child: const Icon(Icons.add,
                                                    color:
                                                        AppColors.signColor)),
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
          ),
        ],
      ),
    );
  }
}
