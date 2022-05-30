import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'features/home/presentation/main_food_page.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: _router.routerDelegate,
      routeInformationParser: _router.routeInformationParser,
      debugShowCheckedModeBanner: false,
      title: 'FOOD',
    );
  }
}

final GoRouter _router = GoRouter(
    initialLocation: "/home",
    debugLogDiagnostics: true,
    routes: <GoRoute>[
      GoRoute(
          path: "/home",
          builder: (context, state) {
            return const MainFoodPage();
          })
    ]);

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
