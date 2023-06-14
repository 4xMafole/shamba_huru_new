import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shamba_huru/my_feeds/models/post.dart';

import '../../data/user_data.dart';
import '../../authentication/controllers/auth_controller.dart';
import '../../extras/services/firebase/api.dart';
import '../../extras/services/firebase/database.dart';

class FeedsController extends GetxController
    with GetSingleTickerProviderStateMixin {
  UserData visitorData = UserData();

  final RxList<Post> feedData = <Post>[].obs;
  final FireDatabase database = FireDatabase();
  final FireApiClient apiClient = FireApiClient();
  RxList descSelected = [].obs;

  Future<bool?> onLikeButtonTapped(
      bool isLiked, FeedsController controller, int postIndex) async {
    //send the request here
    // final bool success = await sendRequest();

    //if failed, you can do nothing
    //return success? !isLiked:isLiked;
    print("IS LIKED" + isLiked.toString());
    // if (!isLiked) {
    //   await controller.likedPost(
    //     ownerId: controller.feedData[postIndex].ownerId,
    //     postId: controller.feedData[postIndex].postId,
    //     mediaUrl: controller.feedData[postIndex].mediaUrl,
    //   );

    //   controller.feedData[postIndex]
    //       .likes[AuthController.authInstance.firebaseUser.value!.uid] = true;
    //   return !isLiked;
    // } else {
    //   await controller.unLikePost(
    //     ownerId: controller.feedData[postIndex].ownerId,
    //     postId: controller.feedData[postIndex].postId,
    //   );

    //   controller.feedData[postIndex]
    //       .likes[AuthController.authInstance.firebaseUser.value!.uid] = false;
    //   return isLiked;
    // }
  }

  @override
  void onInit() async {
    await loadFeeds();
    super.onInit();
  }

  Future refreshList() async {
    await apiClient.getFeed();
    feedData.value = await apiClient.getFeed();
  }

  Future<void> loadFeeds() async {
    feedData.value = await apiClient.loadFeed();
  }

  Future getProfileSnapshot(String? profileID) async {
    if (profileID != null) {
      return database.getProfile(profileID);
    }
  }

  Future<dynamic> getPostCard(String? postId) async {
    return await database.getPostDataSnapshot(postId);
  }

  Future<void> likedPost(
      {required String ownerId,
      required String postId,
      required String mediaUrl}) async {
    if (AuthController.authInstance.firebaseUser.value != null) {
      await database.addLike(
        AuthController.authInstance.firebaseUser.value!.uid,
        ownerId,
        postId,
        mediaUrl,
      );
    }
  }

  Future<void> unLikePost(
      {required String ownerId, required String postId}) async {
    if (AuthController.authInstance.firebaseUser.value != null) {
      await database.removeLike(
        AuthController.authInstance.firebaseUser.value!.uid,
        ownerId,
        postId,
      );
    }
  }

  void toggle(int postIndex) {
    if (descSelected.contains(postIndex)) {
      descSelected.remove(postIndex);
    } else {
      descSelected.add(postIndex);
    }
  }

  Future loadNextData() async {
    await refreshList();
  }

  String dateTimeFirestore(DateTime date) {
    return DateFormat.yMMMd().add_jm().format(date);
  }
}
