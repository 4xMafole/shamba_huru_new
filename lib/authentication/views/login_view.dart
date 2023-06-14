import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shamba_huru/authentication/controllers/login_controller.dart';

import '../../extras/custom_widgets/custom_app_bar.dart';
import '../../extras/custom_widgets/login_button.dart';
import '../../extras/utils/app_colors.dart';
import '../../extras/utils/constant.dart';

class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);

  final LoginController _controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              onPressed: () => Get.back(),
              iconSize: 30,
              icon: Icon(Icons.close),
            ),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              AppColor.paleGreen,
              AppColor.deepGreen,
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(child: Container()),

              Image.asset(
                'assets/icons/logo.png',
                color: Colors.white,
                height: 150,
              ),
              SizedBox(
                height: 100,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'By tapping Sign In, you agree to our\n',
                        style: kNormalText,
                      ),
                      TextSpan(
                        text: 'Terms',
                        style: kUnderlinedText,
                      ),
                      TextSpan(
                        text: '. Learn how we process your data in our ',
                        style: kNormalText,
                      ),
                      TextSpan(
                        text: 'Privacy\nPolicy',
                        style: kUnderlinedText,
                      ),
                      TextSpan(
                        text: ' and ',
                        style: kNormalText,
                      ),
                      TextSpan(
                        text: 'Cookies Policy',
                        style: kUnderlinedText,
                      ),
                      TextSpan(
                        text: '.',
                        style: kNormalText,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 50),
              InkWell(
                onTap: () => _controller.googleUser(context),
                child: LoginButtonWidget(
                  text: 'SIGN IN WITH GOOGLE',
                  icon: "assets/icons/google.svg",
                ),
              ),
              // LoginButtonWidget(
              //   text: 'SIGN IN WITH FACEBOOK',
              //   icon: "assets/icons/facebook.svg",
              // ),
              const SizedBox(height: 20),

              // InkWell(
              //   onTap: () => Get.to(PhoneView()),
              //   child: LoginButtonWidget(
              //     text: 'SIGN IN WITH PHONE NUMBER',
              //     icon: "assets/icons/phone.svg",
              //   ),
              // ),
              const SizedBox(height: 20),
              // const Text(
              //   'Trouble Signing In?',
              //   style: TextStyle(
              //     fontSize: 13,
              //     fontWeight: FontWeight.w500,
              //     color: Colors.white,
              //   ),
              // ),
              const SizedBox(height: 30),
              Expanded(child: Container()),
            ],
          ),
        ),
      ),
    );
  }
}
