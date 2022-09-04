import 'package:e_commerce/utils/colors.dart';
import 'package:e_commerce/utils/dimensions.dart';
import 'package:e_commerce/widgets/account_widget.dart';
import 'package:e_commerce/widgets/app_icon.dart';
import 'package:e_commerce/widgets/big_text.dart';
import 'package:flutter/material.dart';

class AccountPage extends StatelessWidget {
  static const String routeName = "/account-page";
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Dimensions().init(context);
    return Scaffold(
      appBar: AppBar(
        title: BigText(
          text: "Profile",
          size: 24,
          color: Colors.white,
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(top: Dimensions.height20),
        width: double.infinity,
        child: Column(
          children: [
            AppIcon(
              iconSize: Dimensions.height45 + Dimensions.height30,
              icon: Icons.person,
              backgroundColor: AppColors.mainColor,
              iconColor: Colors.white,
              size: Dimensions.height15 * 10,
            ),
            SizedBox(height: Dimensions.height30),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    AccountWidget(
                      appIcon: AppIcon(
                        icon: Icons.phone,
                        backgroundColor: AppColors.yellowColor,
                        iconColor: Colors.white,
                        size: Dimensions.height10 * 5,
                      ),
                      bigText: BigText(text: "13761849016"),
                    ),
                    SizedBox(height: Dimensions.height20),
                    AccountWidget(
                      appIcon: AppIcon(
                        icon: Icons.email,
                        backgroundColor: AppColors.yellowColor,
                        iconColor: Colors.white,
                        size: Dimensions.height10 * 5,
                      ),
                      bigText: BigText(text: "info@dbestech.com"),
                    ),
                    SizedBox(height: Dimensions.height20),
                    AccountWidget(
                      appIcon: AppIcon(
                        icon: Icons.location_on,
                        backgroundColor: AppColors.yellowColor,
                        iconColor: Colors.white,
                        size: Dimensions.height10 * 5,
                      ),
                      bigText: BigText(text: "Fill in your address"),
                    ),
                    SizedBox(height: Dimensions.height20),
                    AccountWidget(
                      appIcon: AppIcon(
                        icon: Icons.message_outlined,
                        backgroundColor: Colors.redAccent,
                        iconColor: Colors.white,
                        size: Dimensions.height10 * 5,
                      ),
                      bigText: BigText(text: "Ahmet"),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
