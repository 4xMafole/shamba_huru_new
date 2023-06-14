import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shamba_huru/data/crops_data.dart';
import 'package:shamba_huru/weather/models/crop.dart';
import 'package:money_formatter/money_formatter.dart';

import '../../extras/services/geo/location.dart';
import '../../extras/services/geo/weather.dart';

class HomeController extends GetxController {
  Rx<CropData> cropData = CropData().obs;
  RxInt? sortColumnIndex = 0.obs;
  RxBool isAscending = false.obs;
  final columns = ['Crop', 'Region', 'Tshs', '%'];
  CustomLocation location = Get.put(CustomLocation());
  CustomWeather weather = Get.put(CustomWeather());

  @override
  void onInit() {
    getLocation();

    super.onInit();
  }

  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    }
    if (hour < 17) {
      return 'Good Afternoon';
    }
    return 'Good Evening';
  }

  String priceFormatter(double price) {
    return MoneyFormatter(
      amount: price,
    ).output.nonSymbol;
  }

  Future getLocation() async {
    Placemark? place = await location.locationData();

    await weather.getWeatherData(place?.locality);
  }

  String dateTimeFirestore(DateTime date) {
    return DateFormat.yMMMd().format(date);
  }
}
