import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class AppUser {
  String uid;
  String username;
  String photoUrl;
  String email;
  String bio;
  Map<dynamic, dynamic> followers;
  Map<dynamic, dynamic> following;
  AppUser({
    required this.uid,
    required this.username,
    required this.photoUrl,
    required this.email,
    required this.bio,
    required this.followers,
    required this.following,
  });

  AppUser copyWith({
    required String uid,
    required String username,
    required String photoUrl,
    required String email,
    required String bio,
    required Map<dynamic, dynamic> followers,
    required Map<dynamic, dynamic> following,
  }) {
    return AppUser(
      uid: uid,
      username: username,
      photoUrl: photoUrl,
      email: email,
      bio: bio,
      followers: followers,
      following: following,
    );
  }

  AppUser merge(AppUser model) {
    return AppUser(
      uid: model.uid,
      username: model.username,
      photoUrl: model.photoUrl,
      email: model.email,
      bio: model.bio,
      followers: model.followers,
      following: model.following,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'username': username,
      'photoUrl': photoUrl,
      'email': email,
      'bio': bio,
      'followers': followers,
      'following': following,
    };
  }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      uid: map['uid'],
      username: map['username'],
      photoUrl: map['photoUrl'],
      email: map['email'],
      bio: map['bio'],
      followers: Map<dynamic, dynamic>.from(map['followers']),
      following: Map<dynamic, dynamic>.from(map['following']),
    );
  }
  factory AppUser.fromDocument(DocumentSnapshot snapshot) {
    return AppUser(
      uid: snapshot['uid'],
      username: snapshot['username'],
      photoUrl: snapshot['photoUrl'],
      email: snapshot['email'],
      bio: snapshot['bio'],
      followers: Map<dynamic, dynamic>.from(snapshot['followers']),
      following: Map<dynamic, dynamic>.from(snapshot['following']),
    );
  }

  String toJson() => json.encode(toMap());

  factory AppUser.fromJson(String source) =>
      AppUser.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AppUser(uid: $uid, username: $username, photoUrl: $photoUrl, email: $email, bio: $bio, followers: $followers, following: $following)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AppUser &&
        other.uid == uid &&
        other.username == username &&
        other.photoUrl == photoUrl &&
        other.email == email &&
        other.bio == bio &&
        mapEquals(other.followers, followers) &&
        mapEquals(other.following, following);
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        username.hashCode ^
        photoUrl.hashCode ^
        email.hashCode ^
        bio.hashCode ^
        followers.hashCode ^
        following.hashCode;
  }
}
