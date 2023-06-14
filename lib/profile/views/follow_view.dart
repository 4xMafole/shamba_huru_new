import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:infinite_widgets/infinite_widgets.dart';
import 'package:shamba_huru/feeds/controllers/follow_controller.dart';

import '../../extras/utils/app_colors.dart';
import '../models/follow.dart';

class FollowView extends StatelessWidget {
  int index;
  FollowView({Key? key, required this.index}) : super(key: key);
  final FollowController _controller = Get.put(FollowController());
  @override
  Widget build(BuildContext context) {
    _controller.tabController.index = index;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: ((context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                pinned: true,
                floating: true,
                backgroundColor: AppColor.deepGreen,
                elevation: 0,
                leading: IconButton(
                  onPressed: (() => Get.back()),
                  icon: Icon(
                    Icons.arrow_back_ios_rounded,
                    color: Colors.white,
                  ),
                ),
                bottom: TabBar(
                  controller: _controller.tabController,
                  indicatorColor: Colors.white,
                  indicatorWeight: 3,
                  tabs: [
                    Tab(
                      text: "Followers",
                    ),
                    Tab(
                      text: "Following",
                    ),
                  ],
                ),
                title: Text(
                  "User",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ];
          }),
          body: TabBarView(
            controller: _controller.tabController,
            children: [
              Obx(() => _followers()),
              Obx(() => _following()),
            ],
          ),
        ),
      ),
    );
  }

  _followers() => _controller.followData.value.followers.isNotEmpty
      ? _followersContent()
      : Center(
          child: SizedBox(
            height: 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/follows.png",
                  width: 60,
                  height: 60,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'No followers',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        );
  _following() => _controller.followData.value.following.isNotEmpty
      ? _followingContent()
      : InkWell(
          onTap: () {
            //TODO: popup a suggestion bottom sheet.

            _editBottomModal(widget: _sugfollowingContent());
          },
          child: Center(
            child: SizedBox(
              height: 100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/new_follows.png",
                    width: 60,
                    height: 60,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Add following',
                    style: TextStyle(
                      color: AppColor.paleGreen,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );

  _followersContent() {
    return InfiniteListView.separated(
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(
            bottom: 15,
            right: 15,
            left: 15,
          ),
          child: followList(
            follow: _controller.followData.value.followers,
            index: index,
          ),
        );
      },
      itemCount: _controller.followData.value.followers.length,
      hasNext: _controller.followData.value.followers.length > 200,
      nextData: _controller.loadFollowersData,
      separatorBuilder: (context, index) => Container(),
    );
  }

  Row followList({required List<Follow> follow, required int index}) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: AppColor.paleBrown,
          radius: 35,
          backgroundImage: AssetImage(
            follow[index].photo,
          ),
        ),
        SizedBox(
          width: 20,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              follow[index].name,
              style: TextStyle(
                color: AppColor.pullmanBrown,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              follow[index].profession,
              style: TextStyle(
                color: AppColor.paleBrown,
                fontSize: 13,
              ),
            ),
          ],
        ),
        Expanded(child: Container()),
        Obx(() => followButton(
              follow: follow,
              index: index,
            )),
      ],
    );
  }

  Container followButton({required List<Follow> follow, required int index}) {
    return Container(
        width: 100,
        child: OutlinedButton(
          onPressed: () {
            follow[index].isFollower
                ? _controller.updateFollower()
                : _controller.updateFollowing();
          },
          child: Text(
            follow[index].isFollower
                ? (_controller.hasRemove.value ? "Remove" : "Follow")
                : (_controller.hasFollowing.value ? "Following" : "Follow"),
            style: TextStyle(
              color: follow[index].isFollower
                  ? (_controller.hasRemove.value ? null : Colors.white)
                  : (_controller.hasFollowing.value ? null : Colors.white),
            ),
          ),
          style: OutlinedButton.styleFrom(
            backgroundColor: follow[index].isFollower
                ? (_controller.hasRemove.value ? null : AppColor.paleGreen)
                : (_controller.hasFollowing.value ? null : AppColor.paleGreen),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            side: BorderSide(
              width: 1,
              color: AppColor.paleGreen,
            ),
          ),
        ));
  }

  _followingContent() => InfiniteListView.separated(
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(
              bottom: 15,
              right: 15,
              left: 15,
            ),
            child: followList(
              follow: _controller.followData.value.following,
              index: index,
            ),
          );
        },
        itemCount: _controller.followData.value.following.length,
        hasNext: _controller.followData.value.following.length > 200,
        nextData: _controller.loadFollowingData,
        separatorBuilder: (context, index) => Divider(height: 1),
      );

  _sugfollowingContent() => _controller.followData.value.sugFollowing.isNotEmpty
      ? InfiniteListView.separated(
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.only(
                bottom: 15,
                right: 15,
                left: 15,
              ),
              child: followList(
                follow: _controller.followData.value.sugFollowing,
                index: index,
              ),
            );
          },
          itemCount: _controller.followData.value.sugFollowing.length,
          hasNext: _controller.followData.value.sugFollowing.length > 200,
          nextData: _controller.loadFollowingData,
          separatorBuilder: (context, index) => Container(),
        )
      : Center(
          child: SizedBox(
            height: 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/follows.png",
                  width: 60,
                  height: 60,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'No Suggestions',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        );

  void _editBottomModal({required Widget widget}) => Get.bottomSheet(
        SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(height: 5),
              const Center(
                child: Divider(
                  indent: 190,
                  endIndent: 190,
                  height: 10,
                  thickness: 4,
                ),
              ),
              widget,
            ],
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      );
}
