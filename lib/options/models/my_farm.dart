import 'dart:convert';

class MyFarm {
  String photo;
  String name;
  String crop;
  String area;

  MyFarm({
    required this.photo,
    required this.name,
    required this.crop,
    required this.area,
  });

  MyFarm copyWith({
    required String photo,
    required String name,
    required String crop,
    required String area,
  }) {
    return MyFarm(
      photo: photo,
      name: name,
      crop: crop,
      area: area,
    );
  }

  MyFarm merge(MyFarm model) {
    return MyFarm(
      photo: model.photo,
      name: model.name,
      crop: model.crop,
      area: model.area,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'photo': photo,
      'name': name,
      'crop': crop,
      'area': area,
    };
  }

  factory MyFarm.fromMap(Map<String, dynamic> map) {
    return MyFarm(
      photo: map['photo'],
      name: map['name'],
      crop: map['crop'],
      area: map['area'],
    );
  }

  String toJson() => json.encode(toMap());

  factory MyFarm.fromJson(String source) => MyFarm.fromMap(json.decode(source));

  @override
  String toString() {
    return 'MyFarm(photo: $photo, name: $name, crop: $crop, area: $area)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is MyFarm &&
        o.photo == photo &&
        o.name == name &&
        o.crop == crop &&
        o.area == area;
  }

  @override
  int get hashCode {
    return photo.hashCode ^ name.hashCode ^ crop.hashCode ^ area.hashCode;
  }
}
