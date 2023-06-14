import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../extras/utils/app_colors.dart';
import '../../../weather/models/crop.dart';

class MarketStatController extends GetxController {
  RxList newCropList = [].obs;
  late TooltipBehavior tooltipBehavior;

  final List<PriceData> chartData = [];

  @override
  void onInit() {
    newCropList.clear();
    chartData.clear();
    tooltipBehavior = TooltipBehavior(
      enable: true,
      borderWidth: 5,
      color: AppColor.paleGreen,
      header: "Price",
    );

    super.onInit();
  }

  @override
  void dispose() {
    newCropList.clear();
    chartData.clear();
    super.dispose();
  }

  String dateTimeFirestore(DateTime date) {
    return DateFormat.yMMMd().format(date);
  }

  String priceFormatter(double price) {
    return MoneyFormatter(
      amount: price,
    ).output.nonSymbol;
  }

  List getCropData(List<Crop> crops, List data) {
    newCropList.clear();

    for (var crop in crops) {
      if (crop.name.contains(data[0]) && crop.location.contains(data[1])) {
        crop.prices.forEach((key, value) {
          var temp = [key, value];
          chartData.add(PriceData(DateTime.parse(key), value));
          newCropList.add(temp);
        });
      }
    }
    return newCropList;
  }

  double pricePercentage(
      {required double initPrice, required double lastPrice}) {
    if (initPrice != 0.0) {
      return (((lastPrice - initPrice) / initPrice) * 100.0).toPrecision(1);
    } else {
      return 0.0.toPrecision(1);
    }
  }
}

class PriceData {
  PriceData(this.month, this.prices);

  final DateTime month;
  final double prices;
}
