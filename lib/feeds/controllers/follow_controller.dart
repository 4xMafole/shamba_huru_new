import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/follows.dart';
import '../../profile/models/follow.dart';

class FollowController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  final Rx<FollowData> followData = FollowData().obs;

  RxInt selectedIndex = 0.obs;
  RxBool hasRemove = true.obs;
  RxBool hasFollowing = true.obs;

  loadFollowersData() => _loadNextData(followData.value.followers);
  loadFollowingData() => _loadNextData(followData.value.following);

  _loadNextData(List<Follow> follow) {
    final initialIndex = follow.length;
    final finalIndex = follow.length + 10;
    print('load data from ${follow.length}');

    Future.delayed(Duration(seconds: 3), () {
      for (var i = initialIndex; i < finalIndex; ++i) {
        follow.add(Follow(
          userId: "y219",
          photo: "assets/images/profile1.jpg",
          name: "Josephat John",
          profession: "Bwana Shamba",
          isFollower: false,
        ));
      }
      print('${follow.length} data now');
      followData.refresh();
    });
  }

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(
      length: 2,
      vsync: this,
    );

    tabController.addListener(() {
      selectedIndex.value = tabController.index;
    });
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  updateFollower() {
    hasRemove.value = !hasRemove.value;
  }

  updateFollowing() {
    hasFollowing.value = !hasFollowing.value;
  }
}
