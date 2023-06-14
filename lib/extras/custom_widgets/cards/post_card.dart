import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:shamba_huru/authentication/controllers/auth_controller.dart';

import '../../../authentication/models/user.dart';
import '../../../feeds/controllers/feeds_controller.dart';
import '../../../my_feeds/models/post.dart';
import '../../../profile/views/profile_view.dart';
import '../../utils/app_colors.dart';
import '../alive_wrapper.dart';
import '../texts/text_01.dart';
import '../texts/username_text.dart';

class PostCard extends StatelessWidget {
  FeedsController controller;
  final int postIndex;
  PostCard({Key? key, required this.postIndex, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool liked = (controller.feedData[postIndex]
            .likes[AuthController.authInstance.firebaseUser.value!.uid] ==
        true);

    return Obx(() => Card(
          margin: EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _head(),
              _content(),
              _userInteract(isLike: liked),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ));
  }

  _head() => KeepAliveFutureBuilder(
      future:
          controller.getProfileSnapshot(controller.feedData[postIndex].ownerId),
      builder: (context, snapshot) {
        AppUser user = snapshot.hasData
            ? AppUser.fromDocument(snapshot.data)
            : controller.visitorData.visitor;

        return Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: user.uid ==
                            AuthController.authInstance.firebaseUser.value!.uid
                        ? null
                        : () => Get.to(() => ProfileView(
                              profileID: user.uid,
                            )),
                    child: CircleAvatar(
                      backgroundColor: AppColor.paleBrown,
                      radius: 30,
                      backgroundImage:
                          CachedNetworkImageProvider(user.photoUrl),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //? Username
                          UsernameText(
                            username: user.username,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          //! Verification Badge
                          // false ? ExpertLabel() : Container(),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //? Location
                              Text01(
                                text: controller.feedData[postIndex].location,
                              ),
                              //! Date and Time
                              Text01(
                                text: controller.dateTimeFirestore(controller
                                    .feedData[postIndex].timestamp
                                    .toDate()),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 20,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Expanded(child: Container()),
                  //TODO: Make this text clickable to follow and unfollow people (Suggested posts)

                  // buildFollowButton(),
                  Expanded(child: Container()),

                  //? More Option Icon
                  Icon(
                    Icons.more_vert_rounded,
                    color: AppColor.paleGreen,
                  )
                ],
              ),
              SizedBox(
                height: 5,
              ),
              //! Post tags
              // Container(
              //   height: 25,
              //   child: ListView.separated(
              //     itemCount:
              //         controller.posData.value.posts[postIndex].tags.length,
              //     scrollDirection: Axis.horizontal,
              //     itemBuilder: (context, index) {
              //       return _tag(
              //           controller.posData.value.posts[postIndex].tags[index]);
              //     },
              //     separatorBuilder: (context, index) {
              //       return SizedBox(
              //         width: 5,
              //       );
              //     },
              //   ),
              // ),
            ],
          ),
        );
      });

  _content() => KeepAliveFutureBuilder(
      future: controller.getPostCard(controller.feedData[postIndex].postId),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container(
              alignment: FractionalOffset.center,
              padding: const EdgeInsets.only(top: 10.0),
              child: CircularProgressIndicator());
        } else {
          Post postData = Post.fromDocument(snapshot.data);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //? Content Image
              Container(
                alignment: Alignment.center,
                height: 350,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(postData.mediaUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Obx(
                () => Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //! Title
                      Text(
                        postData.description,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColor.pullmanBrown,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      //? Description
                      GestureDetector(
                        onTap: () {
                          controller.toggle(postIndex);
                        },
                        child: Text(
                          "Ugonjwa hatari wa mahindi ujulikanao kwa jina la kitaalamu “Maize Lethal Necrosis Disease” umethibitika kuwepo nchini Tanzania. Ugonjwa huu umeanza kuua matumaini ya wakulima katika harakati za kuendeleza kilimo cha mahindi kama zao kuu la chakula.",
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColor.paleBrown,
                          ),
                          overflow: controller.descSelected.contains(postIndex)
                              ? null
                              : TextOverflow.ellipsis,
                          maxLines: controller.descSelected.contains(postIndex)
                              ? null
                              : 2,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          );
        }
      });

  _userInteract({required bool isLike}) => Padding(
        padding: const EdgeInsets.only(
          left: 12,
        ),
        child: Row(
          children: [
            LikeButton(
              onTap: ((isLiked) async {
                return controller.onLikeButtonTapped(
                    isLiked, controller, postIndex);
              }),
              circleColor: CircleColor(
                start: AppColor.paleBrown,
                end: AppColor.paleGreen,
              ),
              bubblesColor: BubblesColor(
                dotPrimaryColor: AppColor.paleBrown,
                dotSecondaryColor: AppColor.paleGreen,
              ),
              likeCount: controller.feedData[postIndex]
                  .getLikeCount(controller.feedData[postIndex].likes),
              isLiked: isLike,
              likeBuilder: (bool isLiked) {
                if (!isLiked) {
                  controller.likedPost(
                    ownerId: controller.feedData[postIndex].ownerId,
                    postId: controller.feedData[postIndex].postId,
                    mediaUrl: controller.feedData[postIndex].mediaUrl,
                  );

                  controller.feedData[postIndex].likes[AuthController
                      .authInstance.firebaseUser.value!.uid] = true;
                } else {
                  controller.unLikePost(
                    ownerId: controller.feedData[postIndex].ownerId,
                    postId: controller.feedData[postIndex].postId,
                  );

                  controller.feedData[postIndex].likes[AuthController
                      .authInstance.firebaseUser.value!.uid] = false;
                }
                return Icon(
                  Icons.front_hand_rounded,
                  color: isLiked
                      ? AppColor.paleGreen
                      : AppColor.paleBrown.withOpacity(0.4),
                );
              },
            ),
          ],
        ),
      );

  // !
  _tag(String tagName) => Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: AppColor.paleGreen.withOpacity(0.3),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          tagName,
          style: TextStyle(
            color: AppColor.deepGreen,
            fontSize: 12,
          ),
        ),
      );

  buildFollowButton() {
    return TextButton(
      onPressed: () {},
      child: Text(
        "Follow",
        style: TextStyle(
          color: AppColor.paleGreen,
        ),
      ),
    );
  }
}
