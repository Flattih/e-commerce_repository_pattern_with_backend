import 'package:dots_indicator/dots_indicator.dart';
import 'package:e_commerce/features/home/domain/models/products_model.dart';
import 'package:e_commerce/features/home/presentation/popular_food_detail.dart';
import 'package:e_commerce/features/home/presentation/reccomended_food_detail.dart';
import 'package:e_commerce/utils/all_providers.dart';

import 'package:e_commerce/utils/colors.dart';

import 'package:e_commerce/widgets/icon_and_text_widget.dart';
import 'package:e_commerce/widgets/big_text.dart';
import 'package:e_commerce/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/app_constants.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({Key? key}) : super(key: key);

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currentPageValue = 0.0;
  final double _scaleFactor = 0.8;
  final double _height = 220;
  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currentPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Consumer(
          builder: (context, ref, child) {
            return ref.watch(controllerPopularProduct).isLoaded
                ? SizedBox(
                    height: 320,
                    child: PageView.builder(
                      controller: pageController,
                      itemCount: ref
                          .watch(controllerPopularProduct)
                          .popularProductList
                          .length,
                      itemBuilder: (context, index) {
                        return _builPageItem(
                            index,
                            ref
                                .watch(controllerPopularProduct)
                                .popularProductList[index]);
                      },
                    ),
                  )
                : const CircularProgressIndicator(color: AppColors.mainColor);
          },
        ),
        Consumer(
          builder: (context, ref, child) {
            return DotsIndicator(
              dotsCount: ref
                      .watch(controllerPopularProduct)
                      .popularProductList
                      .isNotEmpty
                  ? ref
                      .watch(controllerPopularProduct)
                      .popularProductList
                      .length
                  : 1,
              position: _currentPageValue,
              decorator: DotsDecorator(
                activeColor: AppColors.mainColor,
                size: const Size.square(9.0),
                activeSize: const Size(18.0, 9.0),
                activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
              ),
            );
          },
        ),
        const SizedBox(height: 30),
        Container(
          margin: const EdgeInsets.only(left: 30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(text: "Recommended"),
              const SizedBox(width: 10),
              Container(
                margin: const EdgeInsets.only(bottom: 3),
                child: BigText(
                  text: ".",
                  color: Colors.black26,
                ),
              ),
              const SizedBox(width: 10),
              Container(
                margin: const EdgeInsets.only(bottom: 2),
                child: SmallText(text: "Food pairing"),
              )
            ],
          ),
        ),
        SizedBox(
          height: 700,
          child: Consumer(
            builder: (context, ref, child) => ref
                    .watch(controllerRecommendedProduct)
                    .isLoaded
                ? ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: ref
                        .watch(controllerRecommendedProduct)
                        .recommendedProductList
                        .length,
                    itemBuilder: ((context, index) {
                      return GestureDetector(
                        onTap: () => Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          ref.watch(controllerPopularProduct).initProduct(
                              ref.watch(controllerCart),
                              ref
                                  .watch(controllerRecommendedProduct)
                                  .recommendedProductList[index]);
                          return RecommendedFoodDetail(index: index);
                        })),
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 20),
                          child: Row(
                            children: [
                              Container(
                                width: 120,
                                height: 120,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(AppConstants
                                                .BASE_URL +
                                            "/uploads/" +
                                            ref
                                                .watch(
                                                    controllerRecommendedProduct)
                                                .recommendedProductList[index]
                                                .img!),
                                        fit: BoxFit.cover),
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white38),
                              ),
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  height: 100,
                                  decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(20),
                                        bottomRight: Radius.circular(20),
                                      ),
                                      color: Colors.white),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        BigText(
                                            text: ref
                                                .watch(
                                                    controllerRecommendedProduct)
                                                .recommendedProductList[index]
                                                .name!),
                                        const SizedBox(height: 10),
                                        SmallText(
                                            text:
                                                "With chinese characteristics"),
                                        const SizedBox(height: 10),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: const [
                                            IconAndTextWidget(
                                                icon: Icons.circle_sharp,
                                                text: "Normal",
                                                iconColor:
                                                    AppColors.iconColor1),
                                            IconAndTextWidget(
                                                icon: Icons.location_on,
                                                text: "1.7km",
                                                iconColor: AppColors.mainColor),
                                            IconAndTextWidget(
                                                icon: Icons.circle_sharp,
                                                text: "32min",
                                                iconColor:
                                                    AppColors.iconColor2),
                                          ],
                                        ),
                                      ]),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  )
                : const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.mainColor,
                    ),
                  ),
          ),
        )
      ],
    );
  }

  Widget _builPageItem(int index, ProductModel popularProduct) {
    Matrix4 matrix = Matrix4.identity();
    if (index == _currentPageValue.floor()) {
      var currScale = 1 - (_currentPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currentPageValue.floor() + 1) {
      var currScale =
          _scaleFactor + (_currentPageValue - index + 1) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);

      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currentPageValue.floor() - 1) {
      var currScale = 1 - (_currentPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);

      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, _height * (1 - _scaleFactor) / 2, 0);
    }
    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          Consumer(
            builder: (context, ref, child) => GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      ref.read(controllerPopularProduct).initProduct(
                          ref.watch(controllerCart),
                          ref
                              .watch(controllerPopularProduct)
                              .popularProductList[index]);
                      return DetailPage(index: index);
                    },
                  ),
                );
              },
              child: Container(
                height: 220,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  image: DecorationImage(
                      image: NetworkImage(AppConstants.BASE_URL +
                          "/uploads/" +
                          popularProduct.img!),
                      fit: BoxFit.cover),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.only(top: 10, right: 15, left: 15),
              height: 120,
              margin: const EdgeInsets.only(left: 30, right: 30, bottom: 30),
              decoration: BoxDecoration(boxShadow: const [
                BoxShadow(
                  offset: Offset(0, 5),
                  blurRadius: 5,
                  color: Color(0xFFe8e8e8),
                ),
                BoxShadow(
                  color: Colors.white,
                  offset: Offset(-5, 0),
                ),
                BoxShadow(color: Colors.white, offset: Offset(5, 0))
              ], borderRadius: BorderRadius.circular(20), color: Colors.white),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BigText(text: popularProduct.name!),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Wrap(
                        children: List.generate(
                          5,
                          (index) => const Icon(
                            Icons.star,
                            color: AppColors.mainColor,
                            size: 15,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      SmallText(text: "4.5"),
                      const SizedBox(width: 10),
                      SmallText(text: "1287"),
                      const SizedBox(width: 10),
                      SmallText(text: "comments")
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      IconAndTextWidget(
                          icon: Icons.circle_sharp,
                          text: "Normal",
                          iconColor: AppColors.iconColor1),
                      IconAndTextWidget(
                          icon: Icons.location_on,
                          text: "1.7km",
                          iconColor: AppColors.mainColor),
                      IconAndTextWidget(
                          icon: Icons.circle_sharp,
                          text: "32min",
                          iconColor: AppColors.iconColor2),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
