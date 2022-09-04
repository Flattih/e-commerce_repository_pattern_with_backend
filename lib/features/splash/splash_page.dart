import 'dart:async';
import 'package:e_commerce/utils/all_providers.dart';
import 'package:e_commerce/utils/dimensions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

class SplashScreen extends ConsumerStatefulWidget {
  static const String routeName = "/splash-page";
  const SplashScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;
  Future<void> _loadResources() async {
    await ref.read(controllerPopularProduct).getPopularProductList();
    await ref.read(controllerRecommendedProduct).getRecommendedProductList();
  }

  @override
  void initState() {
    super.initState();

    _loadResources();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))
          ..forward();
    animation = CurvedAnimation(parent: controller, curve: Curves.linear);
    Timer(const Duration(seconds: 3), () => context.go("/home"));
  }

  @override
  Widget build(BuildContext context) {
    Dimensions().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Center(
          child: ScaleTransition(
              scale: animation,
              child: Image.asset("assets/image/logo part 1.png",
                  width: Dimensions.splashImg)),
        ),
        Center(
          child: Image.asset("assets/image/logo part 2.png",
              width: Dimensions.splashImg),
        )
      ]),
    );
  }
}
