import 'dart:convert';

class MapFarm {
  String? city;
  String? country;
  double? lat;
  double? lon;
  MapFarm({
    this.city,
    this.country,
    this.lat,
    this.lon,
  });

  MapFarm copyWith({
    String? city,
    String? country,
    double? lat,
    double? lon,
  }) {
    return MapFarm(
      city: city ?? this.city,
      country: country ?? this.country,
      lat: lat ?? this.lat,
      lon: lon ?? this.lon,
    );
  }

  MapFarm merge(MapFarm model) {
    return MapFarm(
      city: model.city ?? this.city,
      country: model.country ?? this.country,
      lat: model.lat ?? this.lat,
      lon: model.lon ?? this.lon,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'city': city,
      'country': country,
      'lat': lat,
      'lon': lon,
    };
  }

  factory MapFarm.fromMap(Map<String, dynamic> map) {
    return MapFarm(
      city: map['city'],
      country: map['country'],
      lat: map['lat'],
      lon: map['lon'],
    );
  }

  String toJson() => json.encode(toMap());

  factory MapFarm.fromJson(String source) =>
      MapFarm.fromMap(json.decode(source));

  @override
  String toString() {
    return 'MapFarm(city: $city, country: $country, lat: $lat, lon: $lon)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MapFarm &&
        other.city == city &&
        other.country == country &&
        other.lat == lat &&
        other.lon == lon;
  }

  @override
  int get hashCode {
    return city.hashCode ^ country.hashCode ^ lat.hashCode ^ lon.hashCode;
  }
}
