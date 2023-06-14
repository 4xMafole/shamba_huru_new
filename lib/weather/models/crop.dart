import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class Crop {
  String name;
  String location;
  Map<dynamic, dynamic> prices;
  Crop({
    required this.name,
    required this.location,
    required this.prices,
  });

  Crop copyWith({
    required String name,
    required String location,
    required Map<dynamic, dynamic> price,
  }) {
    return Crop(
      name: name,
      location: location,
      prices: price,
    );
  }

  Crop merge(Crop model) {
    return Crop(
      name: model.name,
      location: model.location,
      prices: model.prices,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'location': location,
      'price': prices,
    };
  }

  double pricePercentage({int? index}) {
    double priceEarly = prices.values.last;
    double priceLast = prices.values.first;
    if (priceEarly != 0.0) {
      return ((priceLast - priceEarly) / priceEarly) * 100;
    } else {
      return (priceLast / 1) * 100;
    }
  }

  factory Crop.fromMap(Map<String, dynamic> map) {
    return Crop(
      name: map['name'],
      location: map['location'],
      prices: Map<dynamic, dynamic>.from(map['price']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Crop.fromJson(String source) => Crop.fromMap(json.decode(source));

  @override
  String toString() => 'Crop(name: $name, location: $location, price: $prices)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Crop &&
        other.name == name &&
        other.location == location &&
        mapEquals(other.prices, prices);
  }

  @override
  int get hashCode => name.hashCode ^ location.hashCode ^ prices.hashCode;
}
