import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/features/cart/presentation/cart_page.dart';
import 'package:e_commerce/features/home/domain/models/products_model.dart';
import 'package:e_commerce/utils/all_providers.dart';
import 'package:e_commerce/utils/app_constants.dart';
import 'package:e_commerce/utils/colors.dart';
import 'package:e_commerce/widgets/app_column.dart';
import 'package:e_commerce/widgets/app_icon.dart';
import 'package:e_commerce/widgets/big_text.dart';
import 'package:e_commerce/widgets/expandable_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DetailPage extends ConsumerWidget {
  int index;
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
                height: 350,
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
              left: 15,
              right: 15,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const AppIcon(icon: Icons.arrow_back_ios)),
                  Stack(
                    children: [
                      const AppIcon(icon: Icons.shopping_cart_outlined),
                      ref.watch(controllerPopularProduct).totalItems >= 1
                          ? Positioned(
                              right: 0,
                              top: 0,
                              child: GestureDetector(
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const CartPage())),
                                child: const AppIcon(
                                  icon: Icons.circle,
                                  size: 20,
                                  iconColor: Colors.transparent,
                                  backgroundColor: AppColors.mainColor,
                                ),
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
                  )
                ],
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              top: 330,
              child: Container(
                padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
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
                    const SizedBox(height: 20),
                    BigText(text: "Introduce"),
                    const SizedBox(height: 20),
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
                      children: [
                        GestureDetector(
                            onTap: () {
                              controlProduct.setQuantity(false, context);
                            },
                            child: const Icon(Icons.remove,
                                color: AppColors.signColor)),
                        const SizedBox(width: 10),
                        BigText(text: controlProduct.inCartItems.toString()),
                        const SizedBox(width: 10),
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
