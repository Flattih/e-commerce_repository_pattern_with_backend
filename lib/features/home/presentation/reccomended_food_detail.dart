import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/features/cart/presentation/cart_page.dart';
import 'package:e_commerce/features/home/domain/models/products_model.dart';
import 'package:e_commerce/utils/all_providers.dart';
import 'package:e_commerce/utils/app_constants.dart';
import 'package:e_commerce/utils/colors.dart';
import 'package:e_commerce/utils/dimensions.dart';

import 'package:e_commerce/widgets/app_icon.dart';
import 'package:e_commerce/widgets/expandable_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../widgets/big_text.dart';

class RecommendedFoodDetail extends ConsumerWidget {
  static const String routeName = "/recommended-food-detail";
  final int index;
  const RecommendedFoodDetail({Key? key, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ProductModel product =
        ref.watch(controllerRecommendedProduct).recommendedProductList[index];
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              toolbarHeight: 75,
              title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: () => context.pop(),
                        child: const AppIcon(icon: Icons.clear)),
                    GestureDetector(
                      onTap: () {
                        if (ref.watch(controllerPopularProduct).totalItems >=
                            1) {
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
                  ]),
              pinned: true,
              bottom: PreferredSize(
                child: Container(
                  alignment: Alignment.center,
                  child: BigText(
                    text: product.name!,
                    size: Dimensions.font26,
                  ),
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  padding: const EdgeInsets.only(top: 5, bottom: 10),
                ),
                preferredSize: const Size.fromHeight(20),
              ),
              backgroundColor: AppColors.yellowColor,
              expandedHeight: 300,
              flexibleSpace: FlexibleSpaceBar(
                background: CachedNetworkImage(
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
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Container(
                    child: ExpandableTextWidget(text: product.description!),
                    margin:
                        EdgeInsets.symmetric(horizontal: Dimensions.width20),
                  )
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.width20 * 2.5,
                  vertical: Dimensions.height10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      ref
                          .watch(controllerPopularProduct)
                          .setQuantity(false, context);
                    },
                    child: const AppIcon(
                        backgroundColor: AppColors.mainColor,
                        iconColor: Colors.white,
                        icon: Icons.remove),
                  ),
                  BigText(
                    text:
                        "\$${product.price}  X  ${ref.watch(controllerPopularProduct).inCartItems} ",
                    color: AppColors.mainBlackColor,
                    size: Dimensions.font26,
                  ),
                  GestureDetector(
                    onTap: () {
                      ref
                          .watch(controllerPopularProduct)
                          .setQuantity(true, context);
                    },
                    child: const AppIcon(
                      icon: Icons.add,
                      backgroundColor: AppColors.mainColor,
                      iconColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 120,
              padding: const EdgeInsets.only(top: 30, right: 20, left: 20),
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
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Icon(
                          Icons.favorite,
                          color: AppColors.mainColor,
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      ref.read(controllerPopularProduct).addItem(product);
                    },
                    child: Container(
                      padding: EdgeInsets.all(Dimensions.height20),
                      child: BigText(
                        text: "\$ ${product.price!} | Add to cart",
                        color: Colors.white,
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: AppColors.mainColor),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
