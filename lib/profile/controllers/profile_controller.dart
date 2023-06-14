import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shamba_huru/authentication/controllers/auth_controller.dart';
import 'package:shamba_huru/data/user_data.dart';
import 'package:shamba_huru/authentication/models/user.dart';

import '../../extras/services/firebase/database.dart';

class ProfileController extends GetxController {
  UserData visitorData = UserData();
  FireDatabase database = FireDatabase();
  var currentUserId = AuthController.authInstance.firebaseUser.value?.uid.obs;

  RxBool isFollowing = false.obs;
  RxBool followButtonClicked = false.obs;
  RxInt followerCount = 0.obs;
  RxInt followingCount = 0.obs;

  Future getProfileSnapshot(String? profileID) async {
    if (profileID != null) {
      return database.getProfile(profileID);
    }
  }

  @override
  void onInit() async {
    super.onInit();
  }

  int countFollow(Map follow) {
    int count = 0;

    void countValues(key, value) {
      if (value) {
        count += 1;
      }
    }

    follow.forEach(countValues);
    return count;
  }

  Future<void> unfollowUser(String? profileID) async {
    isFollowing.value = false;
    followButtonClicked.value = true;
    if (AuthController.authInstance.firebaseUser.value != null) {
      await database.unfollowUser(
          AuthController.authInstance.firebaseUser.value!.uid, profileID);
    }
  }

  Future<void> followUser(String? profileID) async {
    isFollowing.value = true;
    followButtonClicked.value = true;
    if (AuthController.authInstance.firebaseUser.value != null) {
      await database.followUser(
          AuthController.authInstance.firebaseUser.value!.uid, profileID);
    }
  }
}
