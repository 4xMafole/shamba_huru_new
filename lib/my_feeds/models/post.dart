import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class Post {
  String mediaUrl;
  String username;
  String location;
  String description;
  Map likes;
  String postId;
  String ownerId;
  Timestamp timestamp;
  Post({
    required this.mediaUrl,
    required this.username,
    required this.location,
    required this.description,
    required this.likes,
    required this.postId,
    required this.ownerId,
    required this.timestamp,
  });

  Post copyWith({
    required String mediaUrl,
    required String username,
    required String location,
    required String description,
    required Map likes,
    required String postId,
    required String ownerId,
    required Timestamp timestamp,
  }) {
    return Post(
      mediaUrl: mediaUrl,
      username: username,
      location: location,
      description: description,
      likes: likes,
      postId: postId,
      ownerId: ownerId,
      timestamp: timestamp,
    );
  }

  Post merge(Post model) {
    return Post(
      mediaUrl: model.mediaUrl,
      username: model.username,
      location: model.location,
      description: model.description,
      likes: model.likes,
      postId: model.postId,
      ownerId: model.ownerId,
      timestamp: model.timestamp,
    );
  }

  int getLikeCount(var likes) {
    if (likes == null) {
      return 0;
    }
    var vals = likes.values;
    int count = 0;
    for (var val in vals) {
      if (val == true) {
        count = count + 1;
      }
    }

    return count;
  }

  Map<String, dynamic> toMap() {
    return {
      'mediaUrl': mediaUrl,
      'username': username,
      'location': location,
      'description': description,
      'likes': likes,
      'postId': postId,
      'ownerId': ownerId,
      'timestamp': timestamp,
    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      mediaUrl: map['mediaUrl'],
      username: map['username'],
      location: map['location'],
      description: map['description'],
      likes: Map.from(map['likes']),
      postId: map['postId'],
      ownerId: map['ownerId'],
      timestamp: Timestamp(
          map['timestamp']['_seconds'], map['timestamp']['_nanoseconds']),
    );
  }

  factory Post.fromDocument(DocumentSnapshot document) {
    return Post(
      mediaUrl: document['mediaUrl'],
      username: document['username'],
      location: document['location'],
      description: document['description'],
      likes: Map.from(document['likes']),
      postId: document['postId'],
      ownerId: document['ownerId'],
      timestamp: document['timestamp'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Post.fromJson(String source) => Post.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Post(mediaUrl: $mediaUrl, username: $username, location: $location, description: $description, likes: $likes, postId: $postId, ownerId: $ownerId, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Post &&
        other.mediaUrl == mediaUrl &&
        other.username == username &&
        other.location == location &&
        other.description == description &&
        mapEquals(other.likes, likes) &&
        other.postId == postId &&
        other.ownerId == ownerId &&
        other.timestamp == timestamp;
  }

  @override
  int get hashCode {
    return mediaUrl.hashCode ^
        username.hashCode ^
        location.hashCode ^
        description.hashCode ^
        likes.hashCode ^
        postId.hashCode ^
        ownerId.hashCode ^
        timestamp.hashCode;
  }
}
