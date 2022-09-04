import 'package:e_commerce/utils/colors.dart';
import 'package:e_commerce/utils/dimensions.dart';
import 'package:e_commerce/widgets/app_text_field.dart';
import 'package:e_commerce/widgets/big_text.dart';
import 'package:flutter/gestures.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignInPage extends StatefulWidget {
  static const String routeName = "/sign-in";
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    Dimensions().init(context);
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              height: Dimensions.screenHeight! * 0.05,
            ),
            SizedBox(
              height: Dimensions.screenHeight! * 0.25,
              child: const Center(
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 80,
                  backgroundImage: AssetImage("assets/image/logo part 1.png"),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: Dimensions.width20),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hello",
                    style: TextStyle(
                        fontSize: Dimensions.font20 * 3 + Dimensions.font20 / 2,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Sign into your account",
                    style: TextStyle(
                        fontSize: Dimensions.font20, color: Colors.grey[500]),
                  ),
                ],
              ),
            ),
            SizedBox(height: Dimensions.height20),
            AppTextField(
                textController: emailController,
                hintText: "Email",
                icon: Icons.email),
            SizedBox(height: Dimensions.height20),
            AppTextField(
                textController: passwordController,
                hintText: "Password",
                icon: Icons.password),
            SizedBox(height: Dimensions.height20),
            Row(
              children: [
                Spacer(),
                RichText(
                  text: TextSpan(
                    text: "Sign into your account",
                    style: TextStyle(color: Colors.grey[500], fontSize: 17),
                  ),
                ),
                SizedBox(width: Dimensions.width20)
              ],
            ),
            SizedBox(height: Dimensions.screenHeight! * 0.05),
            GestureDetector(
              onTap: () {},
              child: Container(
                alignment: Alignment.center,
                width: Dimensions.screenWidth! / 2,
                height: Dimensions.screenHeight! / 13,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: AppColors.mainColor),
                child: BigText(
                  text: "Sign in",
                  size: 27,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: Dimensions.screenHeight! * 0.05),
            RichText(
              text: TextSpan(
                  text: "Don't have an account?",
                  style: TextStyle(
                    fontSize: Dimensions.font20,
                    color: Colors.grey[500],
                  ),
                  children: [
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => context.pushNamed('/sign-up'),
                      text: " Create",
                      style: TextStyle(
                        fontSize: Dimensions.font20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.mainBlackColor,
                      ),
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
