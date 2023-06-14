import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:infinite_widgets/infinite_widgets.dart';
import 'package:shamba_huru/feeds/controllers/follow_controller.dart';
import 'package:shamba_huru/my_feeds/controllers/my_feeds_controller.dart';
import 'package:shamba_huru/profile/views/follow_view.dart';

import 'package:shimmer/shimmer.dart';

import '../../../authentication/controllers/auth_controller.dart';
import '../../../my_feeds/models/post.dart';
import '../authentication/models/user.dart';
import '../authentication/views/login_view.dart';
import '../extras/custom_widgets/texts/expert_label.dart';
import '../extras/custom_widgets/texts/text_01.dart';
import '../extras/custom_widgets/texts/username_text.dart';
import '../extras/utils/app_colors.dart';
import '../my_feeds/my_feeds_list_view.dart';
import '../my_feeds/views/add_my_feeds_view.dart';
import '../options/views/edit_profile_view.dart';
import '../options/views/settings/settings_view.dart';
import 'controllers/profile_controller.dart';

class ProfileView extends StatelessWidget {
  final String? profileID;

  ProfileView({Key? key, this.profileID}) : super(key: key);

  final MyFeedsController _feedsController = Get.put(MyFeedsController());

  final ProfileController _profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: AppColor.deepGreen,
      statusBarIconBrightness: Brightness.light,
    ));

    return FutureBuilder<dynamic>(
        future: _profileController.getProfileSnapshot(profileID),
        builder: (context, snapshot) {
          AppUser user = snapshot.hasData && snapshot.data!.exists
              ? AppUser.fromDocument(snapshot.data!)
              : _profileController.visitorData.visitor;

          if (user.followers
                  .containsKey(_profileController.currentUserId?.value) &&
              user.followers[_profileController.currentUserId?.value] &&
              _profileController.followButtonClicked.value == false) {
            _profileController.isFollowing.value = true;
          }
          return Scaffold(
              appBar: AppBar(
                backgroundColor: AppColor.deepGreen,
                elevation: 0,
                actions: [
                  IconButton(
                    onPressed: profileID != null
                        ? () => _editBottomModal(widget: _options())
                        : () => Get.to(() => LoginView()),
                    icon: Icon(Icons.menu),
                    iconSize: 30,
                  ),
                ],
                title: Text(
                  "Profile",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                centerTitle: true,
              ),
              body: Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    _profile(user),
                    Divider(
                      color: Colors.grey.shade400,
                      height: 1,
                    ),
                    _myDetails(user),
                  ],
                ),
              ));
        });
  }

  _profile(AppUser user) => Stack(
        children: [
          Card(
            elevation: 0,
            color: Colors.transparent,
            margin: EdgeInsets.only(
              top: 55.0,
              right: 20,
              left: 20,
            ),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 50),
                  UsernameText(
                    username: profileID != null ? user.username : "User",
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //? field work
                      Text01(
                        text: profileID != null || user.bio.isNotEmpty
                            ? user.bio
                            : "Work",
                        font: 14,
                      ),

                      SizedBox(
                        width: 10,
                      ),
                      //? Verification Badge
                      AuthController.authInstance.firebaseUser.value != null
                          ? const ExpertLabel()
                          : Container(),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Divider(
                      color: AppColor.paleGrey,
                      height: 0.5,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      InkWell(
                        onTap: profileID != null
                            ? () => Get.to(() => FollowView(
                                  index: 0,
                                ))
                            : () => Get.to(() => LoginView()),
                        child: counter(
                            "${_profileController.countFollow(user.following)}",
                            "Following"),
                      ),
                      InkWell(
                        onTap: () {
                          final ScrollController scrollController1 =
                              ScrollController();
                          profileID != null
                              ? Get.to(() => MyFeedsListView(
                                    scrollController: scrollController1,
                                  ))
                              : Get.to(() => LoginView());
                        },
                        child: counter(
                            "${_feedsController.postCount.value}", "Feeds"),
                      ),
                      InkWell(
                        onTap: profileID != null
                            ? () => Get.to(() => FollowView(
                                  index: 1,
                                ))
                            : () => Get.to(() => LoginView()),
                        child: counter(
                            "${_profileController.countFollow(user.followers)}",
                            "Followers"),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  _profileFollowButton(user),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: profileID != null
                ? CircleAvatar(
                    backgroundColor: AppColor.paleGrey,
                    radius: 45,
                    backgroundImage: NetworkImage(user.photoUrl),
                  )
                : CircleAvatar(
                    backgroundColor: AppColor.paleGrey,
                    radius: 45,
                    backgroundImage: AssetImage('assets/images/user.png'),
                  ),
          ),
        ],
      );

  Widget counter(String counter, String counterName) {
    return Column(
      children: <Widget>[
        Text(
          counter,
          style: TextStyle(
            color: AppColor.paleGreen,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          counterName,
          style: TextStyle(
            color: AppColor.pullmanBrown,
          ),
        ),
      ],
    );
  }

  _myDetails(AppUser user) => FutureBuilder<List<Post>>(
      future: _feedsController.getUserPosts(profileID),
      builder: (context, snapshot) {
        if (!snapshot.hasData || user.email.isEmpty) {
          return Expanded(
            child: GestureDetector(
              onTap: profileID != null
                  ? () => Get.to(() => AddMyFeedsView())
                  : () => Get.to(() => LoginView()),
              child: Center(
                child: SizedBox(
                  height: 100,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/news_feed.png",
                        width: 60,
                        height: 60,
                      ),
                      Text(
                        'Add New Feeds',
                        style: TextStyle(
                          color: AppColor.paleGreen,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else {
          return Flexible(
            child: InfiniteGridView(
              loadingWidget: Shimmer.fromColors(
                child: Card(
                  child: Container(),
                ),
                baseColor: Colors.grey.shade100,
                highlightColor: Colors.grey.shade300,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemBuilder: (context, index) {
                List<Post> data = snapshot.data!.toList();
                return GestureDetector(
                  onTap: () {
                    final ScrollController scrollController =
                        ScrollController();

                    Get.to(() => MyFeedsListView(
                          postIndex: index,
                          scrollController: scrollController,
                        ));
                  },
                  child: Card(
                    child: Image.network(
                      data[index].mediaUrl,
                      fit: BoxFit.cover,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                );
              },
              itemCount: _feedsController.postCount.value,
              hasNext: _feedsController.postCount.value > 200,
              nextData: _feedsController.loadNextData,
            ),
          );
        }
      });

  _options() => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            //! Update menu with (activity feeds & settings only)
            // GestureDetector(
            //   onTap: () {
            //     Get.back();
            //     Get.to(MyFarmView());
            //   },
            //   child: ListTile(
            //     title: Text(
            //       "My Farm",
            //       style: TextStyle(
            //         color: AppColor.pullmanBrown,
            //       ),
            //     ),
            //     trailing: Icon(
            //       Icons.arrow_forward_ios_rounded,
            //       color: AppColor.paleGreen,
            //     ),
            //   ),
            // ),
            // Divider(
            //   color: AppColor.grey,
            // ),
            // GestureDetector(
            //   onTap: () {
            //     Get.back();
            //     Get.to(CropSelectionView());
            //   },
            //   child: ListTile(
            //     title: Text(
            //       "My Crop",
            //       style: TextStyle(
            //         color: AppColor.pullmanBrown,
            //       ),
            //     ),
            //     trailing: Icon(
            //       Icons.arrow_forward_ios_rounded,
            //       color: AppColor.paleGreen,
            //     ),
            //   ),
            // ),
            // Divider(
            //   color: AppColor.grey,
            // ),
            GestureDetector(
              onTap: () {
                Get.back();
                Get.to(() => SettingsView());
              },
              child: ListTile(
                title: Text(
                  "Settings",
                  style: TextStyle(
                    color: AppColor.pullmanBrown,
                  ),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: AppColor.paleGreen,
                ),
              ),
            ),
          ],
        ),
      );

  Container _profileFollowButton(AppUser user) {
    if (profileID != null) {
      // viewing your own profile - should show edit button
      if (user.uid == profileID) {
        return followButton(
          text: "Edit Profile",
          textColor: AppColor.paleGreen,
          function: () => Get.to(() => EditProfileView()),
          backgroundColor: Colors.white,
        );
      }

      // already following user - should show unfollow button
      if (_profileController.isFollowing.value) {
        return followButton(
          text: "Unfollow",
          backgroundColor: Colors.white,
          textColor: AppColor.paleGreen,
          function: () => _profileController.unfollowUser(profileID),
        );
      }

      // does not follow user - should show follow button
      if (!_profileController.isFollowing.value) {
        return followButton(
          text: "Follow",
          textColor: Colors.white,
          function: () => _profileController.followUser(profileID),
          backgroundColor: AppColor.paleGreen,
        );
      }
    }

    return followButton(
      text: "Welcome",
      textColor: AppColor.paleGreen,
      backgroundColor: Colors.white,
      function: () => Get.to(() => LoginView()),
    );
  }

  Container followButton({
    required String text,
    void Function()? function,
    required Color textColor,
    required Color backgroundColor,
  }) {
    return Container(
        width: 200,
        child: OutlinedButton(
          onPressed: function,
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
            ),
          ),
          style: OutlinedButton.styleFrom(
            backgroundColor: backgroundColor,
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
