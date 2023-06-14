import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shamba_huru/authentication/models/user.dart';

import '../../data/posts.dart';
import '../../extras/services/firebase/database.dart';
import '../models/post.dart';

class MyFeedsController extends GetxController {
  final Rx<PostsData> posData = PostsData().obs;
  FireDatabase database = FireDatabase();
  RxInt postCount = 0.obs;

  final RxBool isFull = false.obs;

  void updateDesc(bool updateBool, int index) {
    // posData.value.posts[index].isFull = !updateBool;
    isFull.value = !updateBool;
  }

  Future<bool?> onLikeButtonTapped(bool isLiked) async {
    //send the request here
    //final bool success = await sendRequest();

    //if failed, you can do nothing
    //return success? !isLiked:isLiked;

    return !isLiked;
  }

  Future<List<Post>> getUserPosts(String? profileID) async {
    List<Post> posts = await database.getPosts(profileID);
    postCount.value = posts.length;
    return posts;
  }

  loadNextData() {
    final initialIndex = postCount.value;
    final finalIndex = postCount.value + 10;
    print('load data from $postCount');

    Future.delayed(Duration(seconds: 3), () {
      for (var i = initialIndex; i < finalIndex; ++i) {
        //**Write the upated posts in here */
      }
      posData.refresh();
    });
  }

  //todo: App does not scroll until I reload the app
  /* 
    -------------Auto-Scroll Method-----------
    scrollToIndexedFeed(double index, ScrollController controller) {
      if (controller.hasClients) {
        final contentSize = controller.position.viewportDimension +
            controller.position.maxScrollExtent;
        final itemCount = posData.value.posts.length;
        final target = contentSize * index / itemCount;
        controller.position.animateTo(
          target,
          duration: const Duration(seconds: 2),
          curve: Curves.easeInOut,
        );
      }
    } */
}
