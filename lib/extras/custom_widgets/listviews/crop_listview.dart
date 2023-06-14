import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shamba_huru/home/controllers/home_controller.dart';
import 'package:shamba_huru/weather/models/crop.dart';

import '../../../home/views/market/market_stat_view.dart';
import '../../utils/app_colors.dart';

class CropListView extends StatelessWidget {
  HomeController controller;
  int cropIndex;
  CropListView({
    Key? key,
    required this.cropIndex,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (() => Get.to(MarketStatsView(
            pageData: [
              controller.cropData.value.crops[cropIndex].name,
              controller.cropData.value.crops[cropIndex].location,
            ],
          ))),
      child: Row(
        children: [
          Column(
            children: [
              Text(
                controller.cropData.value.crops[cropIndex].name,
                style: TextStyle(
                  fontSize: 18,
                  color: AppColor.paleBrown,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                controller.cropData.value.crops[cropIndex].location,
                style: TextStyle(
                  fontSize: 14,
                  color: AppColor.paleBrown.withOpacity(.5),
                ),
              ),
            ],
          ),
          Expanded(child: Container()),
          Column(
            children: [
              Text(
                controller.priceFormatter(controller
                    .cropData.value.crops[cropIndex].prices.values.first),
                style: TextStyle(
                  fontSize: 18,
                  color: AppColor.paleBrown,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                controller.priceFormatter(controller
                    .cropData.value.crops[cropIndex].prices.values.last),
                style: TextStyle(
                  fontSize: 14,
                  color: AppColor.paleBrown.withOpacity(.5),
                ),
              ),
            ],
          ),
          Expanded(child: Container()),
          Container(
            width: 65,
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: controller.cropData.value.crops[cropIndex]
                          .pricePercentage()
                          .toPrecision(1) >
                      0
                  ? AppColor.paleGreen
                  : controller.cropData.value.crops[cropIndex]
                              .pricePercentage()
                              .toPrecision(1) ==
                          0
                      ? AppColor.deepGrey
                      : AppColor.red,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Text(
                controller.cropData.value.crops[cropIndex]
                        .pricePercentage()
                        .toPrecision(1)
                        .toString() +
                    "%",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
