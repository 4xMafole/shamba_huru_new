import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shamba_huru/authentication/controllers/auth_controller.dart';
import 'package:shamba_huru/activity_feed/models/feed_activity.dart';
import 'package:shamba_huru/my_feeds/models/post.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../authentication/models/user.dart';

class FireDatabase {
  static final FireDatabase _singleton = FireDatabase._internal();

  factory FireDatabase() {
    return _singleton;
  }

  FireDatabase._internal();

  /// The main Firestore user collection
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference feedCollection =
      FirebaseFirestore.instance.collection("feed");
  final CollectionReference postCollection =
      FirebaseFirestore.instance.collection("posts");

  Future<void> userToDatabase({required User user}) async {
    AppUser appUser = AppUser(
      uid: user.uid,
      username: user.displayName!,
      photoUrl: user.photoURL!,
      email: user.email!,
      bio: "",
      followers: {},
      following: {},
    );

    await userCollection
        .doc(user.uid)
        .set(appUser.toMap())
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<void> userUpdate(
      {required String currentUserId,
      required Map<String, Object?> data}) async {
    await AuthController.authInstance.firebaseUser.value
        ?.updateDisplayName(data["username"].toString());
    await userCollection
        .doc(currentUserId)
        .update(data)
        .then((value) => print("User data updated"))
        .catchError((onError) => "Failed to update user $onError");

    print("username " + data["username"].toString());
  }

  Future<bool> userExists(User user) async {
    try {
      var doc = await userCollection.doc(user.uid).get();

      return doc.exists;
    } catch (err) {
      print("userExists $err");
      return false;
    }
  }

  Future<void> storeNotificationToken(
      {required String? userId, required String? token}) async {
    await userCollection
        .doc(userId)
        .update({"androidNotificationToken": token});
  }

  Future getProfile(String profileID) async {
    print("user Profile ${userCollection.doc(profileID).get()}");
    return await userCollection.doc(profileID).get();
  }

  Future<void> removeLike(
      String userId, String? ownerId, String? postId) async {
    await postCollection.doc(postId).update({'likes.$userId': false});
    await removeActivityFeedItem(ownerId, postId);
  }

  Future<void> addLike(
      String userId, String? ownerId, String? postId, String? mediaUrl) async {
    await postCollection.doc(postId).update({'likes.$userId': true});
    await addActivityFeedItem(ownerId, postId, mediaUrl);
  }

  Future<void> unfollowUser(String currentUserId, String? profileID) async {
    //remove from profile followers
    await userCollection
        .doc(profileID)
        .update({'followers.$currentUserId': false});
    //remove from my followings
    await userCollection
        .doc(currentUserId)
        .update({"following.$profileID": false});

    //Delete profile from activity feed
    await feedCollection
        .doc(profileID)
        .collection("items")
        .doc(currentUserId)
        .delete();
  }

  Future<void> followUser(String currentUserId, String? profileID) async {
    FeedActivity feed = FeedActivity(
      ownerId: profileID!,
      username: AuthController.authInstance.firebaseUser.value!.displayName!,
      userId: currentUserId,
      type: "follow",
      userPhotoUrl: AuthController.authInstance.firebaseUser.value!.photoURL!,
      timestamp: DateTime.now(),
    );
    //add to profile followers
    await userCollection
        .doc(profileID)
        .update({'followers.$currentUserId': true});
    //add to my followings
    await userCollection
        .doc(currentUserId)
        .update({"following.$profileID": true});

    //Add profile to activity feed
    await feedCollection
        .doc(profileID)
        .collection("items")
        .doc(currentUserId)
        .set(feed.toMap());
  }

  Future<List<Post>> getPosts(String? profileID) async {
    List<Post> posts = [];
    try {
      var snap = await postCollection
          .where("ownerId", isEqualTo: profileID)
          .orderBy("timestamp")
          .get();
      for (var doc in snap.docs) {
        posts.add(Post.fromDocument(doc));
      }

      return posts.reversed.toList();
    } catch (e) {
      print(e);
    }
    return posts;
  }

  Future<dynamic> getPostDataSnapshot(String? postId) async {
    return await postCollection.doc(postId).get();
  }

  Future<void> removeActivityFeedItem(String? ownerId, String? postId) async {
    await feedCollection.doc(ownerId).collection("items").doc(postId).delete();
  }

  Future<void> addActivityFeedItem(
      String? ownerId, String? postId, String? mediaUrl) async {
    FeedActivity feed = FeedActivity(
      ownerId: ownerId!,
      username: AuthController.authInstance.firebaseUser.value!.displayName!,
      userId: AuthController.authInstance.firebaseUser.value!.uid,
      type: "like",
      userPhotoUrl: AuthController.authInstance.firebaseUser.value!.photoURL!,
      timestamp: DateTime.now(),
    );
    feed.toMap().addAll({
      "mediaUrl": mediaUrl,
      "postId": postId,
    });
    await feedCollection
        .doc(ownerId)
        .collection("items")
        .doc(postId)
        .set(feed.toMap());
  }

  Future<void> setPostData(
      {required String mediaUrl,
      required String city,
      required String description}) async {
    Post data = Post(
      mediaUrl: mediaUrl,
      username: AuthController.authInstance.firebaseUser.value!.displayName!,
      location: city,
      description: description,
      likes: {},
      postId: "",
      ownerId: AuthController.authInstance.firebaseUser.value!.uid,
      timestamp: Timestamp.fromDate(DateTime.now()),
    );
    postCollection.add(data.toMap()).then((doc) {
      String docId = doc.id;
      postCollection.doc(docId).update({"postId": docId});
    });
  }
}
