import 'package:e_commerce/base/show_flushbar.dart';
import 'package:e_commerce/utils/colors.dart';
import 'package:e_commerce/utils/dimensions.dart';
import 'package:e_commerce/widgets/app_text_field.dart';
import 'package:e_commerce/widgets/big_text.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignUpPage extends StatefulWidget {
  static const String routeName = "/sign-up";
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  List<String> signUpImages = ["t.png", "f.png", "g.png"];

  void _registration() {
    String name = nameController.text.trim();
    String phone = phoneController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (name.isEmpty) {
      showCustomSnackBar(
          context: context,
          message: "Type in your name",
          title: "Name",
          bgColor: Colors.red);
    } else if (phone.isEmpty) {
      showCustomSnackBar(
          context: context,
          message: "Type in your phone number",
          bgColor: Colors.red,
          title: "Phone number");
    } else if (email.isEmpty) {
      showCustomSnackBar(
          bgColor: Colors.red,
          context: context,
          message: "Type in your email adress",
          title: "Email address");
    } else if (!EmailValidator.validate(email)) {
      showCustomSnackBar(
          bgColor: Colors.red,
          context: context,
          message: "Type in a valid email address",
          title: "Valid email address");
    } else if (password.isEmpty) {
      showCustomSnackBar(
          bgColor: Colors.red,
          context: context,
          message: "Type in your password",
          title: "password");
    } else if (password.length < 6) {
      showCustomSnackBar(
          bgColor: Colors.red,
          context: context,
          message: "Password can not be less than six characters",
          title: "Password");
    } else {
      showCustomSnackBar(
          bgColor: AppColors.mainColor,
          context: context,
          message: "All went well!",
          title: "Perfect");
    }
  }

  @override
  Widget build(BuildContext context) {
    Dimensions().init(context);

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
            AppTextField(
                textController: nameController,
                hintText: "Name",
                icon: Icons.person),
            SizedBox(height: Dimensions.height20),
            AppTextField(
                textController: phoneController,
                hintText: "Phone",
                icon: Icons.phone),
            SizedBox(height: Dimensions.height20),
            GestureDetector(
              onTap: _registration,
              child: Container(
                alignment: Alignment.center,
                width: Dimensions.screenWidth! / 2,
                height: Dimensions.screenHeight! / 13,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: AppColors.mainColor),
                child: BigText(
                  text: "Sign Up",
                  size: 27,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: Dimensions.height10),
            RichText(
              text: TextSpan(
                recognizer: TapGestureRecognizer()..onTap = () => context.pop(),
                text: "Have an account already?",
                style: TextStyle(color: Colors.grey[500], fontSize: 17),
              ),
            ),
            SizedBox(height: Dimensions.screenHeight! * 0.05),
            RichText(
              text: TextSpan(
                text: "Sign up using one of the following methods",
                style: TextStyle(
                  color: Colors.grey[500],
                ),
              ),
            ),
            Wrap(
              children: List.generate(
                3,
                (index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    radius: 30,
                    backgroundImage:
                        AssetImage("assets/image/${signUpImages[index]}"),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
