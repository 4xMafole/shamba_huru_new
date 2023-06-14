import 'dart:convert';

class FeedActivity {
  String ownerId;
  String username;
  String userId;
  String type;
  String userPhotoUrl;
  DateTime timestamp;
  FeedActivity({
    required this.ownerId,
    required this.username,
    required this.userId,
    required this.type,
    required this.userPhotoUrl,
    required this.timestamp,
  });

  FeedActivity copyWith({
    required String ownerId,
    required String username,
    required String userId,
    required String type,
    required String userProfile,
    required DateTime timestamp,
  }) {
    return FeedActivity(
      ownerId: ownerId,
      username: username,
      userId: userId,
      type: type,
      userPhotoUrl: userProfile,
      timestamp: timestamp,
    );
  }

  FeedActivity merge(FeedActivity model) {
    return FeedActivity(
      ownerId: model.ownerId,
      username: model.username,
      userId: model.userId,
      type: model.type,
      userPhotoUrl: model.userPhotoUrl,
      timestamp: model.timestamp,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'ownerID': ownerId,
      'username': username,
      'userID': userId,
      'type': type,
      'userProfile': userPhotoUrl,
      'timestamp': timestamp,
    };
  }

  factory FeedActivity.fromMap(Map<String, dynamic> map) {
    return FeedActivity(
      ownerId: map['ownerID'],
      username: map['username'],
      userId: map['userID'],
      type: map['type'],
      userPhotoUrl: map['userProfile'],
      timestamp: map['timestamp'],
    );
  }

  String toJson() => json.encode(toMap());

  factory FeedActivity.fromJson(String source) =>
      FeedActivity.fromMap(json.decode(source));

  @override
  String toString() {
    return 'FeedActivity(ownerId: $ownerId, username: $username, userId: $userId, type: $type, userProfile: $userPhotoUrl, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FeedActivity &&
        other.ownerId == ownerId &&
        other.username == username &&
        other.userId == userId &&
        other.type == type &&
        other.userPhotoUrl == userPhotoUrl &&
        other.timestamp == timestamp;
  }

  @override
  int get hashCode {
    return ownerId.hashCode ^
        username.hashCode ^
        userId.hashCode ^
        type.hashCode ^
        userPhotoUrl.hashCode ^
        timestamp.hashCode;
  }
}
