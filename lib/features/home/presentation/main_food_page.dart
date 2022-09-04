import 'package:e_commerce/features/home/presentation/food_page_body.dart';
import 'package:e_commerce/utils/all_providers.dart';

import 'package:e_commerce/utils/colors.dart';
import 'package:e_commerce/utils/dimensions.dart';
import 'package:e_commerce/widgets/big_text.dart';
import 'package:e_commerce/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainFoodPage extends ConsumerStatefulWidget {
  static const String routeName = "/main-food-page";
  const MainFoodPage({Key? key}) : super(key: key);

  @override
  ConsumerState<MainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends ConsumerState<MainFoodPage> {
  @override
  Widget build(BuildContext context) {
    Dimensions().init(context);
    Future<void> _loadResources() async {
      await ref.read(controllerPopularProduct).getPopularProductList();
      await ref.read(controllerRecommendedProduct).getRecommendedProductList();
    }

    return RefreshIndicator(
      onRefresh: _loadResources,
      child: Scaffold(
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.only(
                  top: Dimensions.height45, bottom: Dimensions.height15),
              padding: EdgeInsets.symmetric(horizontal: Dimensions.width20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BigText(
                        text: "Bangladesh",
                        color: AppColors.mainColor,
                      ),
                      Row(
                        children: [
                          SmallText(
                            text: "Narsingdi",
                            color: Colors.black54,
                          ),
                          const Icon(Icons.arrow_drop_down_rounded)
                        ],
                      )
                    ],
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: Dimensions.height45,
                    height: Dimensions.height45,
                    child: const Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: AppColors.mainColor),
                  )
                ],
              ),
            ),
            const Expanded(child: SingleChildScrollView(child: FoodPageBody()))
          ],
        ),
      ),
    );
  }
}
