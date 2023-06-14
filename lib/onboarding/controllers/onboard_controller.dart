import 'package:flutter/material.dart';
import 'package:flutter_onboard/flutter_onboard.dart';
import 'package:get/get.dart';

class OnboardController extends GetxController {
  final PageController pageController = PageController();

  final List<OnBoardModel> onBoardData = [
    const OnBoardModel(
      title: "Connecting farmers",
      description: "Stay connected and get engaged with fellow farmers",
      imgUrl: "assets/images/tractor.png",
    ),
    const OnBoardModel(
      title: "Market Prices",
      description: "View realtime farm products prices",
      imgUrl: 'assets/images/farm.png',
    ),
    const OnBoardModel(
      title: "Weather Tracking",
      description: "Track weather conditions for your farm",
      imgUrl: 'assets/images/cow.png',
    ),
  ];
}
