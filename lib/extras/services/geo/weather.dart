import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class CustomWeather extends GetxController {
  RxString temp = "0.0".obs;
  RxString mintemp = "".obs;
  RxString maxtemp = "".obs;
  RxString feeltemp = "0.0".obs;
  RxString description = "...".obs;
  RxString icon = "50d".obs;
  RxString pressure = "".obs;
  RxString humidity = "".obs;
  RxString visibility = "".obs;
  RxString windSpeed = "".obs;
  RxString sunrise = "".obs;
  RxString sunset = "".obs;
  RxString country = "".obs;
  RxString city = "".obs;
  RxString lon = "".obs;
  RxString lat = "".obs;
  RxString time = "...".obs;
  RxString winddeg = "".obs;

  Future getWeatherData(cityName) async {
    try {
      // var apikey = "390a80c6b8f3dc881ddb193cb56d8b0a&units=metric";
      var apikey = "3a8f5883304dcac9732d1df671ee6618&units=metric";
      var url = Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apikey');
      http.Response response = await http.get(url);
      var results = jsonDecode(response.body);
      if (results != null) {
        var date = DateTime.now();
        temp.value = results['main']['temp'].toString();
        mintemp.value = results['main']['temp_min'].toString();
        maxtemp.value = results['main']['temp_max'].toString();
        feeltemp.value = results['main']['feels_like'].toString();
        description.value = results['weather'][0]['description'].toString();
        icon.value =
            results['weather'][0]['icon'].toString().replaceAll("n", "d");
        pressure.value = results['main']['pressure'].toString();
        humidity.value = results['main']['humidity'].toString();
        visibility.value = results['visibility'].toString();
        windSpeed.value = results['wind']['speed'].toString();
        sunrise.value = results['sys']['sunrise'].toString();
        sunset.value = results['sys']['sunset'].toString();
        country.value = results['sys']['country'].toString();
        city.value = results['name'].toString();
        lat.value = results['coord']['lat'].toString();
        time.value = DateFormat('EEEE, d MMM').format(date).toString();
        lon.value = results['coord']['lon'].toString();
        winddeg.value = results['wind']['deg'].toString();
        print("${icon.value}");
        print(response.body);
      }
    } catch (e) {
      print(e);
    }
  }
}
