import 'package:flutter/material.dart';
import 'package:flutter_onboard/flutter_onboard.dart';
import 'package:get/get.dart';
import 'package:shamba_huru/onboarding/controllers/onboard_controller.dart';

import '../../authentication/views/login_view.dart';
import '../../extras/utils/app_colors.dart';

class OnboardView extends StatelessWidget {
  OnboardView({Key? key}) : super(key: key);

  final OnboardController _controller = Get.put(OnboardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OnBoard(
        imageHeight: 200,
        imageWidth: 200,
        pageController: _controller.pageController,
        onBoardData: _controller.onBoardData,
        titleStyles: TextStyle(
          color: AppColor.deepGreen,
          fontSize: 18,
          fontWeight: FontWeight.w900,
          letterSpacing: 0.15,
        ),
        descriptionStyles: TextStyle(
          fontSize: 16,
          color: AppColor.pullmanBrown,
        ),
        pageIndicatorStyle: PageIndicatorStyle(
          width: 100,
          inactiveColor: AppColor.paleGreen,
          activeColor: AppColor.deepGreen,
          inactiveSize: const Size(8, 8),
          activeSize: const Size(12, 12),
        ),
        // Either Provide onSkip Callback or skipButton Widget to handle skip state
        skipButton: TextButton(
          onPressed: () {
            Get.to(LoginView());
          },
          child: Text(
            "Skip",
            style: TextStyle(color: AppColor.paleGreen),
          ),
        ),
        // Either Provide onDone Callback or nextButton Widget to handle done state
        nextButton: OnBoardConsumer(
          builder: (context, ref, child) {
            final state = ref.watch(onBoardStateProvider);
            return InkWell(
              onTap: () => _onNextTap(state),
              child: Container(
                width: 230,
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: LinearGradient(
                    colors: [AppColor.deepGreen, AppColor.paleGreen],
                  ),
                ),
                child: Text(
                  state.isLastPage ? "Done" : "Next",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _onNextTap(OnBoardState onBoardState) {
    if (!onBoardState.isLastPage) {
      _controller.pageController.animateToPage(
        onBoardState.page + 1,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOutSine,
      );
    } else {
      Get.to(LoginView());
    }
  }
}
