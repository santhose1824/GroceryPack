import 'package:flutter/material.dart';
import 'package:grocery_pack/common_widgets/app_button.dart';
import 'package:grocery_pack/common_widgets/app_text.dart';
import 'package:grocery_pack/screens/login.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grocery_pack/screens/register.dart';
import 'package:grocery_pack/styles/colors.dart';

class WelcomeScreen extends StatelessWidget {
  final String imagePath = "assets/images/welcome_image.png";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 30),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Spacer(),
                icon(),
                SizedBox(
                  height: 20,
                ),
                welcomeTextWidget(),
                SizedBox(
                  height: 10,
                ),
                sloganText(),
                SizedBox(
                  height: 40,
                ),
                loginButton(context),
                SizedBox(
                  height: 40,
                ),
                signButton(context),
                SizedBox(
                  height: 40,
                )
              ],
            ),
          ),
        ));
  }

  Widget icon() {
    String iconPath = "assets/icons/app_icon.svg";
    return SvgPicture.asset(
      iconPath,
      width: 48,
      height: 56,
    );
  }

  Widget welcomeTextWidget() {
    return Column(
      children: [
        AppText(
          text: "Welcome",
          fontSize: 48,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        AppText(
          text: "to our store",
          fontSize: 48,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ],
    );
  }

  Widget sloganText() {
    return AppText(
      text: "All your Kitchen needs in your Doorstep",
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: Color(0xffFCFCFC).withOpacity(0.7),
    );
  }

  Widget loginButton(BuildContext context) {
    return AppButton(
      label: "LOGIN",
      fontWeight: FontWeight.w600,
      padding: EdgeInsets.symmetric(vertical: 25),
      onPressed: () {
        onLoginClicked(context);
      },
    );
  }
  Widget signButton(BuildContext context) {
    return AppButton(
      label: "SIGN UP",
      fontWeight: FontWeight.w600,
      padding: EdgeInsets.symmetric(vertical: 25),
      onPressed: () {
        onSignupClicked(context);
      },
    );
  }

  void onLoginClicked(BuildContext context) {
    Navigator.of(context).pushReplacement(new MaterialPageRoute(
      builder: (BuildContext context) {
        return LoginScreen();
      },
    ));
  }

  void onSignupClicked(BuildContext context) {
    Navigator.of(context).pushReplacement(new MaterialPageRoute(
      builder: (BuildContext context) {
        return SignupScreen();
      },
    ));
  }
}
