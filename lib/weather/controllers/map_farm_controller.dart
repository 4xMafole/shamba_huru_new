import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shamba_huru/weather/models/map_farm.dart';

import '../../extras/utils/app_colors.dart';

class MapFarmController extends GetxController {
  RxBool isLoading = true.obs;

  Rx<MapFarm> map = MapFarm().obs;

  Rx<HashSet<Polygon>> polygons = HashSet<Polygon>().obs;

  RxInt polygonCounter = 1.obs;
  RxBool isPolygon = true.obs;

  RxList<LatLng>? polygonLatLon = [LatLng(0, 0)].obs;

  @override
  void onInit() {
    initiliazeMap();
    getLocationData();
    super.onInit();
  }

  Future getLocationData() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Fluttertoast.showToast(msg: 'Please enable Your Location Service');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Fluttertoast.showToast(msg: 'Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Fluttertoast.showToast(
          msg:
              'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.medium);

    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark place = placemarks[0];

      map.value.city = place.locality!;
      map.value.country = place.country!;
      map.value.lon = position.longitude;
      map.value.lat = position.latitude;

      isLoading.value = false;
    } catch (e) {
      print(e);
    }
  }

  Future setPolygon() async {
    final String polygonIdVal = 'polygon_id_${polygonCounter.value}';
    polygons.value.add(Polygon(
      polygonId: PolygonId(polygonIdVal),
      points: polygonLatLon!,
      strokeWidth: 2,
      strokeColor: AppColor.paleGreen,
      fillColor: AppColor.paleGreen.withOpacity(0.15),
    ));
  }

  void initiliazeMap() {
    map.value.city = "";
    map.value.country = "";
    map.value.lat = 0.0;
    map.value.lon = 0.0;
  }
}
