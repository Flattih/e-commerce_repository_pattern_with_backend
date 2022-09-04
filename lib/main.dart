import 'dart:io';
import 'package:e_commerce/features/auth/sign_in_page.dart';
import 'package:e_commerce/features/auth/sign_up_page.dart';
import 'package:e_commerce/features/home/presentation/home_page.dart';
import 'package:e_commerce/features/home/presentation/main_food_page.dart';
import 'package:e_commerce/features/splash/splash_page.dart';
import 'package:e_commerce/utils/all_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences preferences = await SharedPreferences.getInstance();
  HttpOverrides.global = MyHttpOverrides();
  runApp(ProviderScope(
      overrides: [sharedProvider.overrideWithValue(preferences)],
      child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(controllerCart).getCartData();
    return MaterialApp.router(
      routeInformationProvider: _router.routeInformationProvider,
      routerDelegate: _router.routerDelegate,
      routeInformationParser: _router.routeInformationParser,
      debugShowCheckedModeBanner: false,
      title: 'FOOD',
    );
  }
}

final GoRouter _router = GoRouter(
    initialLocation: "/sign-in",
    debugLogDiagnostics: true,
    routes: <GoRoute>[
      GoRoute(
          name: HomePage.routeName,
          path: "/home",
          builder: (context, state) => const HomePage()),
      GoRoute(
          name: MainFoodPage.routeName,
          path: "/main-food-page",
          builder: (context, state) => const MainFoodPage()),
      GoRoute(
          name: SplashScreen.routeName,
          path: "/splash",
          builder: (context, state) => const SplashScreen()),
      GoRoute(
          name: SignUpPage.routeName,
          path: "/sign-up",
          builder: (context, state) => const SignUpPage()),
      GoRoute(
          name: SignInPage.routeName,
          path: "/sign-in",
          builder: (context, state) => const SignInPage())
    ]);

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
