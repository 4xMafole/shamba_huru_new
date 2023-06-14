import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shamba_huru/home/controllers/market/market_stat_controller.dart';
import 'package:shamba_huru/home/controllers/home_controller.dart';
import 'package:shamba_huru/weather/models/crop.dart';

import '../../utils/app_colors.dart';

class CropStatListView extends StatelessWidget {
  String date;
  String price;
  double percentage;
  CropStatListView({
    Key? key,
    required this.date,
    required this.price,
    required this.percentage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          price,
          style: TextStyle(
            fontSize: 18,
            color: AppColor.paleBrown,
          ),
        ),
        Expanded(child: Container()),
        Text(
          date,
          style: TextStyle(
            fontSize: 18,
            color: AppColor.paleBrown,
          ),
        ),
        Expanded(child: Container()),
        Container(
          width: 65,
          padding: EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: percentage > 0
                ? AppColor.paleGreen
                : percentage == 0
                    ? AppColor.deepGrey
                    : AppColor.red,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(
              percentage.toString() + "%",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
