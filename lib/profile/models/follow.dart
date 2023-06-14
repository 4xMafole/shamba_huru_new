import 'dart:convert';

class Follow {
  String userId;
  String photo;
  String name;
  String profession;
  bool isFollower;
  Follow({
    required this.userId,
    required this.photo,
    required this.name,
    required this.profession,
    required this.isFollower,
  });

  Follow copyWith({
    required String userId,
    required String photo,
    required String name,
    required String profession,
    required bool isFollower,
  }) {
    return Follow(
      userId: userId,
      photo: photo,
      name: name,
      profession: profession,
      isFollower: isFollower,
    );
  }

  Follow merge(Follow model) {
    return Follow(
      userId: model.userId,
      photo: model.photo,
      name: model.name,
      profession: model.profession,
      isFollower: model.isFollower,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'photo': photo,
      'name': name,
      'profession': profession,
      'isFollower': isFollower,
    };
  }

  factory Follow.fromMap(Map<String, dynamic> map) {
    return Follow(
      userId: map['userId'],
      photo: map['photo'],
      name: map['name'],
      profession: map['profession'],
      isFollower: map['isFollower'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Follow.fromJson(String source) => Follow.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Follow(userId: $userId, photo: $photo, name: $name, profession: $profession, isFollower: $isFollower)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Follow &&
        other.userId == userId &&
        other.photo == photo &&
        other.name == name &&
        other.profession == profession &&
        other.isFollower == isFollower;
  }

  @override
  int get hashCode {
    return userId.hashCode ^
        photo.hashCode ^
        name.hashCode ^
        profession.hashCode ^
        isFollower.hashCode;
  }
}
