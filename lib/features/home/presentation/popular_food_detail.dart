import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/features/cart/presentation/cart_page.dart';
import 'package:e_commerce/features/home/domain/models/products_model.dart';
import 'package:e_commerce/utils/all_providers.dart';
import 'package:e_commerce/utils/app_constants.dart';
import 'package:e_commerce/utils/colors.dart';
import 'package:e_commerce/utils/dimensions.dart';
import 'package:e_commerce/widgets/app_column.dart';
import 'package:e_commerce/widgets/app_icon.dart';
import 'package:e_commerce/widgets/big_text.dart';
import 'package:e_commerce/widgets/expandable_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class DetailPage extends ConsumerWidget {
  int index;
  static const String routeName = "/popular-food-detail";
  DetailPage({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ProductModel product =
        ref.watch(controllerPopularProduct).popularProductList[index];

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              child: SizedBox(
                width: double.infinity,
                height: Dimensions.popularFoodImgSize,
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: AppConstants.BASE_URL +
                      AppConstants.UPLOAD_URL +
                      product.img!,
                  placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(
                    color: AppColors.mainColor,
                  )),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
            Positioned(
              top: 25,
              left: Dimensions.width20,
              right: Dimensions.width20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        context.pop();
                      },
                      child: const AppIcon(icon: Icons.arrow_back_ios)),
                  GestureDetector(
                    onTap: () {
                      if (ref.watch(controllerPopularProduct).totalItems >= 1) {
                        context.pushNamed(CartPage.routeName);
                      }
                    },
                    child: Stack(
                      children: [
                        const AppIcon(icon: Icons.shopping_cart_outlined),
                        ref.watch(controllerPopularProduct).totalItems >= 1
                            ? const Positioned(
                                right: 0,
                                top: 0,
                                child: AppIcon(
                                  icon: Icons.circle,
                                  size: 20,
                                  iconColor: Colors.transparent,
                                  backgroundColor: AppColors.mainColor,
                                ),
                              )
                            : const SizedBox(),
                        ref.watch(controllerPopularProduct).totalItems >= 1
                            ? Positioned(
                                right: 5,
                                top: 3,
                                child: BigText(
                                  text: ref
                                      .watch(controllerPopularProduct)
                                      .totalItems
                                      .toString(),
                                  size: 12,
                                  color: Colors.white,
                                ),
                              )
                            : const SizedBox()
                      ],
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              top: Dimensions.popularFoodImgSize - 20,
              child: Container(
                padding: EdgeInsets.only(
                    left: Dimensions.width20,
                    top: Dimensions.width20,
                    right: Dimensions.height20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppColumn(text: product.name!),
                    SizedBox(height: Dimensions.height20),
                    BigText(text: "Introduce"),
                    SizedBox(height: Dimensions.height20),
                    Expanded(
                      child: SingleChildScrollView(
                        child: ExpandableTextWidget(text: product.description!),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: Consumer(
          builder: (context, ref, child) {
            var controlProduct = ref.watch(controllerPopularProduct);
            return Container(
              height: 120,
              padding: EdgeInsets.symmetric(
                  vertical: Dimensions.height30,
                  horizontal: Dimensions.width20),
              decoration: const BoxDecoration(
                color: AppColors.buttonBackgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.all(Dimensions.height20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                            onTap: () {
                              controlProduct.setQuantity(false, context);
                            },
                            child: const Icon(Icons.remove,
                                color: AppColors.signColor)),
                        SizedBox(width: Dimensions.width10 / 2),
                        BigText(text: controlProduct.inCartItems.toString()),
                        SizedBox(width: Dimensions.width10 / 2),
                        GestureDetector(
                            onTap: () {
                              controlProduct.setQuantity(true, context);
                            },
                            child: const Icon(Icons.add,
                                color: AppColors.signColor)),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () =>
                        ref.read(controllerPopularProduct).addItem(product),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      child: BigText(
                        size: 18,
                        text: "\$ ${product.price} | Add to cart",
                        color: Colors.white,
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: AppColors.mainColor),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
