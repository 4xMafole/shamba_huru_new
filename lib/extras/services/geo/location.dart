import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class CustomLocation extends GetxController {
  RxString city = "Loading..".obs;
  RxString country = "Loading..".obs;
  RxDouble lat = 0.0.obs;
  RxDouble lon = 0.0.obs;

  @override
  void onInit() {
    locationData();
    super.onInit();
  }

  Future<Placemark?> locationData() async {
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

      city.value = place.locality!;
      country.value = place.country!;
      lon.value = position.longitude;
      lat.value = position.latitude;

      return place;
    } catch (e) {
      return null;
    }
  }

  Future updateLocation(cityName) async {
    city.value = cityName;
  }
}
