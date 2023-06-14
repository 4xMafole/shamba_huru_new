import 'dart:convert';

import 'package:flutter/foundation.dart';

int highText = 0xFFD50000;
int highTemp = 0xFFD32F2F;
int moderateText = 0xFFffC400;
int moderateTemp = 0xFFFF9800;
int normalText = 0xFF69F0AE;
int normalTemp = 0xFF66BB6A;
int lightBlueHumidity = 0xFF2196F3;
int darkBlueMoisture = 0xFF3F51B5;
List types = ["recieved", "sent"];

List coins = [];

class DataModelApi {
  Channel channel;
  List<Feeds> feeds;
  DataModelApi({
    required this.channel,
    required this.feeds,
  });

  DataModelApi copyWith({
    required Channel channel,
    required List<Feeds> feeds,
  }) {
    return DataModelApi(
      channel: channel,
      feeds: feeds,
    );
  }

  DataModelApi merge(DataModelApi model) {
    return DataModelApi(
      channel: model.channel,
      feeds: model.feeds,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'channel': channel.toMap(),
      'feeds': feeds.map((x) => x.toMap()).toList(),
    };
  }

  factory DataModelApi.fromMap(Map<String, dynamic> map) {
    return DataModelApi(
      channel: Channel.fromMap(map['channel']),
      feeds: List<Feeds>.from(map['feeds']?.map((x) => Feeds.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory DataModelApi.fromJson(String source) =>
      DataModelApi.fromMap(json.decode(source));

  @override
  String toString() => 'DataModelApi(channel: $channel, feeds: $feeds)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is DataModelApi &&
        o.channel == channel &&
        listEquals(o.feeds, feeds);
  }

  @override
  int get hashCode => channel.hashCode ^ feeds.hashCode;
}

class Channel {
  int id;
  String name;
  String description;
  String latitude;
  String longitude;
  String field1;
  String field2;
  String field3;
  String createdAt;
  String updatedAt;
  int lastEntryId;
  Channel({
    required this.id,
    required this.name,
    required this.description,
    required this.latitude,
    required this.longitude,
    required this.field1,
    required this.field2,
    required this.field3,
    required this.createdAt,
    required this.updatedAt,
    required this.lastEntryId,
  });

  Channel copyWith({
    required int id,
    required String name,
    required String description,
    required String latitude,
    required String longitude,
    required String field1,
    required String field2,
    required String field3,
    required String createdAt,
    required String updatedAt,
    required int lastEntryId,
  }) {
    return Channel(
      id: id,
      name: name,
      description: description,
      latitude: latitude,
      longitude: longitude,
      field1: field1,
      field2: field2,
      field3: field3,
      createdAt: createdAt,
      updatedAt: updatedAt,
      lastEntryId: lastEntryId,
    );
  }

  Channel merge(Channel model) {
    return Channel(
      id: model.id,
      name: model.name,
      description: model.description,
      latitude: model.latitude,
      longitude: model.longitude,
      field1: model.field1,
      field2: model.field2,
      field3: model.field3,
      createdAt: model.createdAt,
      updatedAt: model.updatedAt,
      lastEntryId: model.lastEntryId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'latitude': latitude,
      'longitude': longitude,
      'field1': field1,
      'field2': field2,
      'field3': field3,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'lastEntryId': lastEntryId,
    };
  }

  factory Channel.fromMap(Map<String, dynamic> map) {
    return Channel(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      latitude: map['latitude'],
      longitude: map['longitude'],
      field1: map['field1'],
      field2: map['field2'],
      field3: map['field3'],
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
      lastEntryId: map['lastEntryId'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Channel.fromJson(String source) =>
      Channel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Channel(id: $id, name: $name, description: $description, latitude: $latitude, longitude: $longitude, field1: $field1, field2: $field2, field3: $field3, createdAt: $createdAt, updatedAt: $updatedAt, lastEntryId: $lastEntryId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Channel &&
        other.id == id &&
        other.name == name &&
        other.description == description &&
        other.latitude == latitude &&
        other.longitude == longitude &&
        other.field1 == field1 &&
        other.field2 == field2 &&
        other.field3 == field3 &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.lastEntryId == lastEntryId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        description.hashCode ^
        latitude.hashCode ^
        longitude.hashCode ^
        field1.hashCode ^
        field2.hashCode ^
        field3.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        lastEntryId.hashCode;
  }
}

class Feeds {
  String createdAt;
  int entryId;
  String field1;
  String field2;
  String field3;
  Feeds({
    required this.createdAt,
    required this.entryId,
    required this.field1,
    required this.field2,
    required this.field3,
  });

  Feeds copyWith({
    required String createdAt,
    required int entryId,
    required String field1,
    required String field2,
    required String field3,
  }) {
    return Feeds(
      createdAt: createdAt,
      entryId: entryId,
      field1: field1,
      field2: field2,
      field3: field3,
    );
  }

  Feeds merge(Feeds model) {
    return Feeds(
      createdAt: model.createdAt,
      entryId: model.entryId,
      field1: model.field1,
      field2: model.field2,
      field3: model.field3,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'createdAt': createdAt,
      'entryId': entryId,
      'field1': field1,
      'field2': field2,
      'field3': field3,
    };
  }

  factory Feeds.fromMap(Map<String, dynamic> map) {
    return Feeds(
      createdAt: map['createdAt'],
      entryId: map['entryId'],
      field1: map['field1'],
      field2: map['field2'],
      field3: map['field3'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Feeds.fromJson(String source) => Feeds.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Feeds(createdAt: $createdAt, entryId: $entryId, field1: $field1, field2: $field2, field3: $field3)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Feeds &&
        other.createdAt == createdAt &&
        other.entryId == entryId &&
        other.field1 == field1 &&
        other.field2 == field2 &&
        other.field3 == field3;
  }

  @override
  int get hashCode {
    return createdAt.hashCode ^
        entryId.hashCode ^
        field1.hashCode ^
        field2.hashCode ^
        field3.hashCode;
  }
}
